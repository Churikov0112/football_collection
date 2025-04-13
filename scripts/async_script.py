import os
import aiohttp
import asyncio
from bs4 import BeautifulSoup
import json
from urllib.parse import urljoin

# Папки для сохранения данных
team_flags_folder = "team_flags"
player_faces_folder = "player_faces"
os.makedirs(team_flags_folder, exist_ok=True)
os.makedirs(player_faces_folder, exist_ok=True)

# Заголовки для запросов
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',
    'Accept-Language': 'en-US,en;q=0.9',
}

# Базовый URL для парсинга списка команд
base_url = "https://www.transfermarkt.com/vereins-statistik/wertvollstenationalmannschaften/marktwertetop"

# Максимальное количество команд для обработки
max_teams = 300  # Установите нужное значение

# Год, за который парсим составы
target_season = 2025

# Словарь для преобразования позиций
# position_mapping = {
#     "Goalkeeper": "GK",
#     "Centre-Back": "CB",
#     "Left-Back": "LB",
#     "Right-Back": "RB",
#     "Defensive Midfield": "DM",
#     "Central Midfield": "CM",
#     "Attacking Midfield": "AM",
#     "Left Midfield": "LM",
#     "Right Midfield": "RM",
#     "Left Winger": "LW",
#     "Right Winger": "RW",
#     "Centre-Forward": "CF",
#     "Second Striker": "SS",
# }

# Асинхронная функция для получения HTML содержимого страницы
async def fetch_html(session, url):
    try:
        async with session.get(url, headers=headers) as response:
            response.raise_for_status()
            return await response.text()
    except Exception as e:
        print(f"Error fetching {url}: {e}")
        return None

# Асинхронная функция для скачивания изображения
async def download_image_async(session, url, path, max_retries=3):
    for attempt in range(max_retries):
        try:
            async with session.get(url, headers=headers) as response:
                if response.status == 200:
                    # Читаем данные по частям и записываем в файл
                    with open(path, 'wb') as f:
                        async for chunk in response.content.iter_chunked(1024):
                            f.write(chunk)
                    return True
                else:
                    print(f"Failed to download image from {url}. Status code: {response.status}")
        except Exception as e:
            print(f"Attempt {attempt + 1} failed: Error downloading image from {url}: {e}")
            if attempt == max_retries - 1:  # Если это последняя попытка
                return False
            await asyncio.sleep(1)  # Ждем 1 секунду перед повторной попыткой
    return False

# Функция для извлечения URL команд со страницы
def scrape_team_urls(html):
    soup = BeautifulSoup(html, "html.parser")
    urls = []
    table = soup.find("table", class_="items")
    if table:
        rows = table.find_all("tr")[1:]  # Пропускаем заголовок таблицы
        for row in rows:
            cols = row.find_all("td")
            if len(cols) >= 4:
                team_url = "https://www.transfermarkt.com" + cols[1].find("a")["href"]
                urls.append(team_url)
    return urls

# Асинхронная функция для получения данных о команде
async def scrape_team_data(session, url):
    html = await fetch_html(session, url)
    if not html:
        return None

    soup = BeautifulSoup(html, 'html.parser')
    team_id = url.split('/')[6]
    team_name_tag = soup.find("h1", class_="data-header__headline-wrapper")
    team_name = team_name_tag.text.strip() if team_name_tag else ""

    flag_url = ""
    flag_tag = soup.find("img", class_="flaggenrahmen")
    if flag_tag and flag_tag.get("src"):
        flag_url = urljoin("https://tmssl.akamaized.net", flag_tag["src"].split("?")[0])

    return {
        "id": team_id,
        "name": team_name,
        "flag_url": flag_url
    }

# Асинхронная функция для получения рыночной стоимости игрока
async def get_market_value(session, player_id):
    url = f"https://transfermarkt-api.fly.dev/players/{player_id}/market_value"
    try:
        async with session.get(url, headers=headers) as response:
            if response.status == 200:
                data = await response.json()
                current_market_value = data.get("marketValue", None)
                market_value_history = data.get("marketValueHistory", [])
                max_market_value = max([entry["marketValue"] for entry in market_value_history]) if market_value_history else None
                return current_market_value, max_market_value
    except Exception as e:
        print(f"Error fetching market value for player {player_id}: {e}")
    return None, None

# Асинхронная функция для получения данных об игроках
async def scrape_players(session, squad_url, team_id):
    html = await fetch_html(session, squad_url)
    if not html:
        return []

    soup = BeautifulSoup(html, 'html.parser')
    players = []
    player_table = soup.find('table', {'class': 'items'})

    if player_table:
        rows = player_table.find_all('tr', {'class': ['odd', 'even']})
        for row in rows:
            columns = row.find_all('td')
            if len(columns) > 0:
                link = columns[1].find('a')
                if link and 'href' in link.attrs:
                    player_id = link['href'].split('/')[-1]
                    player_profile_url = 'https://www.transfermarkt.com' + link['href']

                    # Переходим на страницу профиля игрока
                    player_html = await fetch_html(session, player_profile_url)
                    if not player_html:
                        continue

                    player_soup = BeautifulSoup(player_html, 'html.parser')

                    # Поиск фотографии на странице профиля
                    img_tag = player_soup.find('img', {'class': 'data-header__profile-image'})
                    if img_tag and 'src' in img_tag.attrs:
                        img_url = img_tag['src']
                        if img_url.startswith('//'):
                            img_url = 'https:' + img_url

                        # Пропуск игроков с дефолтным изображением
                        if "default" in img_url:
                            continue  # Пропускаем игрока, если изображение дефолтное
                        else:
                            # Замена "header" на "big" для увеличения разрешения
                            img_url = img_url.replace("header", "big")
                            image_url = img_url

                            # Скачивание фотографии
                            img_path = os.path.join(player_faces_folder, f'{player_id}.jpg')
                            if not await download_image_async(session, img_url, img_path):
                                continue  # Пропускаем игрока, если не удалось скачать фото
                    else:
                        continue  # Пропускаем игрока, если изображение не найдено

                    # Извлечение данных об игроке
                    position = columns[4].text.strip()
                    # position_short = position_mapping.get(position, position)

                    birth_date = player_soup.find('span', {'itemprop': 'birthDate'})
                    birth_date = birth_date.text.strip() if birth_date else None

                    height = player_soup.find('span', {'itemprop': 'height'})
                    height = height.text.strip() if height else None

                    foot_label = player_soup.find('span', string='Foot:')
                    foot = None
                    if foot_label:
                        foot = foot_label.find_next('span', class_='info-table__content--bold').text.strip()

                    current_club = player_soup.find('span', {'class': 'data-header__club'})
                    current_club = current_club.text.strip() if current_club else None

                    # Получение рыночной стоимости игрока
                    current_market_value, max_market_value = await get_market_value(session, player_id)

                    player_data = {
                        "id": player_id,
                        "team_id": team_id,
                        "name": link.text.strip(),
                        "position": position,
                        "birth_date": birth_date,
                        "height": height,
                        "foot": foot,
                        "current_club": current_club,
                        "current_market_value": current_market_value,
                        "max_market_value": max_market_value,
                        "image_url": image_url,  # Добавляем поле image_url
                    }
                    players.append(player_data)

    return players

# Основная асинхронная функция
async def main():
    async with aiohttp.ClientSession() as session:
        # Получаем список URL команд
        print("Parsing the list of teams...")
        all_urls = []
        page = 1

        while True:
            url = f"{base_url}?page={page}"
            print(f"Processing page {page}...")
            html = await fetch_html(session, url)
            if not html:
                break

            page_urls = scrape_team_urls(html)
            if not page_urls:
                break

            all_urls.extend(page_urls)

            # Ограничение количества команд (если нужно)
            if len(all_urls) >= max_teams:
                break

            page += 1

        print(f"Found {len(all_urls)} teams to process.")

        # Обрабатываем команды параллельно
        tasks = [process_team(session, url) for url in all_urls[:max_teams]]
        teams_data = await asyncio.gather(*tasks)

        # Сохраняем данные о командах (без списка игроков)
        teams_data_cleaned = [team["team"] for team in teams_data if team]
        teams_data_cleaned = list({team["id"]: team for team in teams_data_cleaned}.values())

        with open('teams_data.json', 'w', encoding='utf-8') as f:
            json.dump(teams_data_cleaned, f, indent=4, ensure_ascii=False)

        # Сохраняем данные об игроках
        all_players = [player for team in teams_data if team for player in team["players"]]
        all_players = list({player["id"]: player for player in all_players}.values())
        with open('players_data.json', 'w', encoding='utf-8') as f:
            json.dump(all_players, f, indent=4, ensure_ascii=False)

        print("Parsing completed.")

# Функция для обработки одной команды
async def process_team(session, url):
    team_data = await scrape_team_data(session, url)
    if not team_data:
        return None

    squad_url = url.replace("/startseite/verein/", "/kader/verein/").split("/saison_id/")[0] + f"/saison_id/{target_season}"
    print(f"Scraping squad for team {team_data['name']} ({team_data['id']}) from URL: {squad_url}")

    players = await scrape_players(session, squad_url, team_data['id'])
    if not players:
        print(f"No players with photos found in team {team_data['name']}. Skipping.")
        return None

    # Скачивание флага команды
    if team_data.get("flag_url"):
        flag_filename = os.path.join(team_flags_folder, f"{team_data['id']}.png")
        if await download_image_async(session, team_data['flag_url'], flag_filename):
            print(f"Flag for team {team_data['name']} ({team_data['id']}) saved.")
        else:
            print(f"Error downloading flag for {team_data['name']} ({team_data['id']}).")
            return None

    # Возвращаем данные команды и игроков
    return {
        "team": team_data,
        "players": players
    }

# Запуск асинхронного кода
if __name__ == '__main__':
    asyncio.run(main())