#!/usr/bin/env bash

# Get counts for each multi answer question
#
# Alternative workflow variables
# 10,15,16,26

# Pseudocode
#
# Split file by comma's
# Get list of all unique values
#

set -x

INPUT_DIR=$1
REF_DIR=$2
OUTPUT_DIR=$3

# Version 1
# 
# Count number of answers per question
#

for i in ${INPUT_DIR}/10.txt \
         ${INPUT_DIR}/15.txt \
         ${INPUT_DIR}/16.txt \
         ${INPUT_DIR}/26.txt; do
    name="$(basename "$i" | sed 's/\.txt/-1.txt/')"
    : > ${OUTPUT_DIR}/${name}
    echo "$OUTPUT_DIR/${name}"
    tail -n +2 "$i" | while IFS= read -r line; do
        count=$(printf "%s" "$line" | grep -o "," | wc -l | sed 's/$/+1/' | bc)
        printf '%s;"%s"\n' "$line" "$count" >> "$OUTPUT_DIR/${name}"
      done
done

# Version 2
#
# Count number of instances of regular and irregular answers per question
#

# for i in ${INPUT_DIR}/{10,15,16,26}.txt; do
#     name_1="$(basename "$i" | sed 's/\.txt/-1.txt/')"
#     echo "$OUTPUT_DIR/${name_1}"
#     tail -n +2 "$i" | sort -u > "$OUTPUT_DIR/${name_1}"
#     name_2="$(basename "$i" | sed 's/\.txt/-2.txt/')"
#     echo "$OUTPUT_DIR/${name_2}"
#     tail -n +2 "$i" | sed -e 's/"//g' \
#         -e 's/,/\n/g' | sort -u > "$OUTPUT_DIR/${name_2}"
# done

