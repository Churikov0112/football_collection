#!/bin/bash

# URL страницы (можно заменить на нужный)
url="https://www.transfermarkt.world/vereins-statistik/wertvollstenationalmannschaften/marktwertetop"

# Файл для сохранения HTML-кода
output_file="page.html"

# Загружаем HTML-код страницы и сохраняем в файл
curl -s -A "Mozilla/5.0" "$url" -o "$output_file"

echo "HTML-код сохранён в $output_file"
