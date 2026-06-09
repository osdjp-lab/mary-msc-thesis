#!/usr/bin/env sh

INPUT_DIR="$1"
OUTPUT_DIR="$2"

for i in $(seq -f "$INPUT_DIR/%g.txt" 1 9) \
         $(seq -f "$INPUT_DIR/%g.txt" 11 14) \
         $(seq -f "$INPUT_DIR/%g.txt" 17 25) \
         $(seq -f "$INPUT_DIR/%g.txt" 27 31); do
    name=$(basename "$i")
    echo "$OUTPUT_DIR/${name}"
    tail -n +2 $i | sort -u > "$OUTPUT_DIR/${name}"
done

for i in ${INPUT_DIR}/{10,15,16,26}.txt; do
    name_1="$(basename "$i" | sed 's/\.txt/-1.txt/')"
    echo "$OUTPUT_DIR/${name_1}"
    tail -n +2 "$i" | sort -u > "$OUTPUT_DIR/${name_1}"
    name_2="$(basename "$i" | sed 's/\.txt/-2.txt/')"
    echo "$OUTPUT_DIR/${name_2}"
    tail -n +2 "$i" | sed -e 's/"//g' \
        -e 's/,/\n/g' | sort -u > "$OUTPUT_DIR/${name_2}"
done

