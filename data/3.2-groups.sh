#!/usr/bin/env sh

INPUT_DIR="$1"
OUTPUT_DIR="$2"

# 1 - Dane socjodemograficzne
paste -d ';' $(for i in $(seq 2 6); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/1-dane-socjodemograficzne.csv

# 2 - Praktyki suplementacyjne
paste -d ';' $(for i in $(seq 7 15); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/2-praktyki-suplementacyjne.csv

# 3 - Źródła informacji
paste -d ';' $(for i in 16 26 27 28; do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/3-info.csv

# 4 - Wiedza dot. suplementów diety
paste -d ';' $(for i in $(seq 17 25); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/4-wiedza.csv

#################

# Check groupings

printf "Sum of columns in groupings: "
for i in $OUTPUT_DIR/*; do
    head -n 1 $i | tr -cd ";" | wc -c | sed -e "s/$/+1/" | tr '\n' '+'
done | sed 's/+$/\n/' | bc

