#!/bin/bash

# Helper script used to generate 
# - assets/item_category_map.json
# - assets/localization.json
# - assets/item_ids.txt
# Args: path to directory containing files generated by ao-id-extractor
# Usage python scripts/generate_assets.sh ${EXTRACTED}


declare game_data_dir="$1"

if [[ -z $game_data_dir ]]; then
    echo "First argument should point to game data dir generated by ao-id-extractor"
    exit 1
fi

declare items_file="$(find $game_data_dir -type f -name items.xml)"
declare localization_file="$(find $game_data_dir -type f -name localization.xml)"

if [[ -z $items_file ]]; then
    echo "$game_data_dir does not contains items.xml file"
    exit 1
fi

if [[ -z $localization_file ]]; then
    echo "$localization_file does not contains localization.xml file"
    exit 1
fi

echo "Generating pyaoaddons/item_category_mapping.py..."
echo "mapping =" > pyaoaddons/item_category_mapping.py
python scripts/item_category_map.py $items_file >> pyaoaddons/item_category_mapping.py

echo "Generating pyaoaddons/localization_mapping.py..."
echo "mapping =" > pyaoaddons/localization_mapping.py
python scripts/localization.py $localization_file >> pyaoaddons/localization_mapping.py
