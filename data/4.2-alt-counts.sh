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

INPUT_DIR=$1
REF_DIR=$2
OUTPUT_DIR=$3

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Part 1
# 
# Count number of answers per question
#
printf "Part 1\n"

for i in ${INPUT_DIR}/10.txt \
         ${INPUT_DIR}/15.txt \
         ${INPUT_DIR}/16.txt \
         ${INPUT_DIR}/26.txt; do
    name="$(basename "$i" | sed 's/\.txt/-1.txt/')"
    : > ${OUTPUT_DIR}/${name}
    printf "$OUTPUT_DIR/${name}\n"
    tail -n +2 "$i" | while IFS= read -r line; do
        count=$(printf "%s" "$line" | grep -o "," | wc -l | sed 's/$/+1/' | bc)
        printf '%s;"%s"\n' "$line" "$count" >> "$OUTPUT_DIR/${name}"
      done
done

# Part 2
#
# Count number of instances of different answers per question
#

printf "Part 2\n"

for ref_file in ${REF_DIR}/10-2.txt \
                ${REF_DIR}/15-2.txt \
                ${REF_DIR}/16-2.txt \
                ${REF_DIR}/26-2.txt; do
    : > ${OUTPUT_DIR}/$(basename $ref_file)
    printf "$OUTPUT_DIR/$(basename $ref_file)\n"
    
    name="$(basename "$ref_file" | sed 's/-2\.txt/.txt/')"
    base_file="$INPUT_DIR/${name}"

    # Prepare the output file (same basename in OUTPUT_DIR)
    out_file="$OUTPUT_DIR/$(basename $ref_file)"
    # Truncate any previous contents
    : > "$out_file"

    # Read the reference file line by line
    while IFS= read -r ref_line; do
        # Count occurrences of the exact line in the base file
        # The leading/trailing spaces are preserved by using grep -F -x
        count=$(grep -F -c -- "$ref_line" "$base_file")
        # Append the line and its count (semicolon‑separated) to the output file
        printf '%s;"%s"\n' "$ref_line" "$count" >> "$out_file"
    done < "$ref_file"
done

