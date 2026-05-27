#!/usr/bin/env sh

INPUT_DIR="$1"
OUTPUT_DIR="$2"

for i in $INPUT_DIR/*; do
    echo "$OUTPUT_DIR/$(basename "$i")"
    tail -n +2 $i | sort -u > "$OUTPUT_DIR/$(basename "$i")"
done

