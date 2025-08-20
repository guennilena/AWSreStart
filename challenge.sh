#!/bin/bash

file_folder="companyA"
file_name=$USER
num_files=25

# prüfen ob Ordner existiert
if [ ! -d "$file_folder" ]; then
  # fragen ob Ordner angelegt werden soll
  echo "Der Ordner $file_folder existiert nicht in $(pwd)."
  echo "Soll der Ordner angelegt werden?"
  echo "Drücken sie J zum Anlegen, N um einen Ordnernamen anzugeben."
  read -n 1 result
  if [ "$result" == "J" ] || [ "$result" == "j" ]; then
    # wenn ja, anlegen
    mkdir "$file_folder"
    if [ $? != 0 ]; then
      echo -e "\n\nFehler beim Erstellen des Ordners"
      exit
    else
      echo -e "\n\nOrdner erfolgreich erstellt"
    fi
#  elif [ "$result" == "N" ] || [ "$result" == "n" ]; then
#    read new_folder
#    mkdir "$new_folder"
#    file_folder = $new_folder
  else
    # ansonsten beenden
    exit
  fi
fi

# Finde alle Dateien im Ordner $file_folder die mit $file_name beginnen und eine Zahl haben
# führende 0 interpretiert die Zahl als Oktal daher | bc
max_num=$(ls $file_folder/*$file_name 2>/dev/null | grep -o -E '[0-9]{1,6}' | sort -n | tail -n 1 | bc)

# Falls keine Dateien existieren, setze max_num auf 0
if [ -z "$max_num" ]; then
  max_num=0
fi

echo -e "\nmax_num =  $max_num"

# Erhöhe die Nummer um 1 und erstelle die neuen Dateien
next_num=$((max_num + 1))

echo -e "next_num = $next_num"

echo -e "\nDateien erstellen"

for ((i = $next_num; i < $next_num + $num_files; i++)) do
  # Dateien erstellen
  new_file="$file_folder/$(printf '%06d' $i)-$file_name"
  #new_file="$file_folder/$file_name-$(printf '%06d' $i)"
  #new_file="$file_folder/$file_name-$i"
  touch "$new_file"
  echo "Datei erstellt: $new_file"
done

echo -e "\nSkript beendet\n"

exit
