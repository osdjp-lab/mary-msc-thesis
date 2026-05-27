#!/usr/bin/env sh

INPUT_DIR="$1"
OUTPUT_DIR="$2"

# Grupowanie
paste -d ';' $(for i in $(seq 1 5); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/grupowanie.csv

# Stan
paste -d ';' $(for i in $(seq 6 15); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/stan.csv

# Samoocena
paste -d ';' $(for i in $(seq 16 18); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/samoocena.csv

# Wiedza
paste -d ';' $(for i in $(seq 19 24); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/wiedza.csv

# Preferencje
paste -d ';' $(for i in $(seq 25 27); do echo $INPUT_DIR/$i.txt; done) > $OUTPUT_DIR/preferencje.csv

#################

# Check groupings

printf "Sum of columns in groupings: "
for i in $OUTPUT_DIR/*; do
    head -n 1 $i | tr -cd ";" | wc -c | sed -e "s/$/+1/" | tr '\n' '+'
done | sed 's/+$/\n/' | bc

