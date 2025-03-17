#!/bin/bash

# URL страницы с данными
URL="https://www.transfermarkt.world/vereins-statistik/wertvollstenationalmannschaften/marktwertetop"

# Загрузка HTML-страницы
HTML_CONTENT=$(curl -s "$URL")

# Извлечение данных с помощью pup
echo "$HTML_CONTENT" | pup 'table.items tbody tr json{}' | jq -r '
  .[] | 
  .children | 
  map(select(.tag == "td")) | 
  .[1].children[0].children[1].children[0].text + " " + .[3].text
'