#!/bin/bash 
 
# Получаем параметр из аргументов командной строки 
param="$1" 
 
# Формируем имя файла с паттерном "_<параметр>.scss" 
filename="_${param}.scss" 
 
# Путь к директории с файлами 
config_path="src/scss/blocks" 
 
# Пути к файлам 
path="$config_path/$filename" 
index_path="$config_path/_index.scss" 
 
# Строка импорта для добавления в _index.scss 
import_line="@import '$filename';" 
 
# Создаем директорию, если она не существует 
mkdir -p "$config_path" 
 
# Проверяем, существует ли файл 
if [ -f "$path" ]; then 
    echo -e "\033[0;31mФайл $path уже существует\033[0m" 
else 
    # Создаем файл с определением класса, если его нет 
    echo -e "@import \"../mixins\";\n\n.$param {\n    \n}" > "$path" 
 
    # Добавляем импорт в _index.scss, если его там еще нет 
    if [ ! -f "$index_path" ]; then 
        touch "$index_path" 
    fi 
 
    if ! grep -q "$import_line" "$index_path"; then 
        echo "$import_line" >> "$index_path" 
    fi 
 
    # Выводим сообщение о завершении работы 
    echo -e "\033[0;32mФайл $path создан, импорт добавлен в $index_path\033[0m" 
fi