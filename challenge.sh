#!/bin/bash

file_folder="companyA/"
file_name=$USER
num_files=25

if [ ! -d "$file_folder" ]; then
  echo "Der Ordner $file_folder existiert nicht in $(pwd)"
  echo "Soll der Ordner angelegt werden?"
  echo "Drücken sie A zum Abbrechen, N um einen Ordnernamen anzugeben"
  read -n 1 result
  if (result == 'A') then
    exit;
  elif (result == 'N') then
    read -n 1 $file_folder
  fi
  mkdir "$file_folder"
fi

# Finde alle Dateien, die mit 'datei' beginnen und eine Zahl haben
#max_num=$(ls datei* 2>/dev/null | grep -oP '$name\K\d+' | sort -n | tail -n 1)
max_num=$(ls $file_folder$file_name* 2>/dev/null | grep -o -E '[0-9]+' | sort -n | tail -n 1)

# Falls keine Dateien existieren, setze max_num auf 0
if [ -z "$max_num" ]; then
  max_num=0
fi

# Erhöhe die Nummer um 1 und erstelle die neue Datei
next_num=$((max_num + 1))

for ((i=$next_num; i<$next_num + $num_files; i++))
do
	new_file="$file_folder$file_name$i"
	touch "$new_file"
	echo "Erstellt: $new_file"
done

exit
