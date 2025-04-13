import os
from PIL import Image

# Пути к папкам
input_folder = 'player_faces'
output_folder = 'player_faces_compressed'

# Создаем папку для обработанных изображений
if not os.path.exists(output_folder):
    os.makedirs(output_folder)

# Проходим по всем файлам
for filename in os.listdir(input_folder):
    if filename.lower().endswith(('.png', '.jpg', '.jpeg', '.webp')):
        try:
            # Открываем изображение
            img_path = os.path.join(input_folder, filename)
            img = Image.open(img_path)

            # Если изображение с прозрачностью (RGBA)
            if img.mode == 'RGBA':
                # Создаем белый фон того же размера
                white_bg = Image.new('RGB', img.size, (255, 255, 255))
                # Накладываем оригинал на белый фон (используя альфа-канал как маску)
                white_bg.paste(img, (0, 0), img)
                img = white_bg
            # Если изображение в другом режиме с прозрачностью (например, P с прозрачностью)
            elif img.mode == 'P' and 'transparency' in img.info:
                img = img.convert('RGBA')
                white_bg = Image.new('RGB', img.size, (255, 255, 255))
                white_bg.paste(img, (0, 0), img)
                img = white_bg
            # Для всех остальных режимов просто конвертируем в RGB
            else:
                img = img.convert('RGB')

            # Сохраняем результат (меняем расширение на .jpg для единообразия)
            output_filename = os.path.splitext(filename)[0] + '.jpg'
            output_path = os.path.join(output_folder, output_filename)

            # Сохраняем с хорошим качеством
            img.save(output_path, 'JPEG', quality=90, optimize=True)
            print(f'Обработано: {filename} -> {output_filename}')

        except Exception as e:
            print(f'Ошибка при обработке {filename}: {str(e)}')

print('Обработка завершена! Все изображения сохранены с белым фоном.')