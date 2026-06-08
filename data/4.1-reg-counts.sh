#!/usr/bin/env sh

# Get value counts for each single choice question

# Pseudocode
#
# For each line in file of uniq values get count of these values
# in the base files then save copy the uniq values file adding
# the count as a seperate column
#
# for ref_file in REF_DIR
#   for ref_line in ref_file
#       base_file = BASE_DIR + basename of ref_file
#       count = number of occurances of ref_line in base_file
#       out_file = OUTPUT_DIR + basename of ref_file
#       append ref_line + ';"$count" to out_file
#

# Directories
REF_DIR=$1
BASE_DIR=$2
OUTPUT_DIR=$3

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop over every regular file in REF_DIR
for ref_file in $(seq -f "$REF_DIR/%g.txt" 2 9) \
                $(seq -f "$REF_DIR/%g.txt" 11 14) \
                $(seq -f "$REF_DIR/%g.txt" 17 25) \
                $(seq -f "$REF_DIR/%g.txt" 27 29); do
    # Skip if not a regular file
    [ -f "$ref_file" ] || continue

    # Determine the matching base file (same basename in BASE_DIR)
    base_file="$BASE_DIR/$(basename "$ref_file")"

    # Skip if the base file is missing
    [ -f "$base_file" ] || continue

    # Prepare the output file (same basename in OUTPUT_DIR)
    out_file="$OUTPUT_DIR/$(basename "$ref_file")"
    # Truncate any previous contents
    : > "$out_file"

    # Read the reference file line by line
    while IFS= read -r ref_line; do
        # Count occurrences of the exact line in the base file
        # The leading/trailing spaces are preserved by using grep -F -x
        count=$(grep -F -x -c -- "$ref_line" "$base_file")
        # Append the line and its count (semicolon‑separated) to the output file
        printf '%s;"%s"\n' "$ref_line" "$count" >> "$out_file"
    done < "$ref_file"
done

