#!/usr/bin/env sh

INPUT_DIR="$1"
OUTPUT_DIR="$2"

# 1-Grupowanie
paste -d ';' $(for i in $(seq 2 6); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/1-grupowanie.csv

# 2-Stan
paste -d ';' $(for i in $(seq 7 16); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/2-stan.csv

# 3-Samoocena
paste -d ';' $(for i in $(seq 17 19); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/3-samoocena.csv

# 4-Wiedza
paste -d ';' $(for i in $(seq 20 25); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/4-wiedza.csv

# 5-Preferencje
paste -d ';' $(for i in $(seq 26 28); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/5-preferencje.csv

#################

# Check groupings

printf "Sum of columns in groupings: "
for i in $OUTPUT_DIR/*; do
    head -n 1 $i | tr -cd ";" | wc -c | sed -e "s/$/+1/" | tr '\n' '+'
done | sed 's/+$/\n/' | bc

