#!/usr/bin/env sh

# Fix irregularities

INPUT_DIR="$1"
OUTPUT_DIR="$2"

for i in $(find $INPUT_DIR -type f); do
    cp "$i" "$OUTPUT_DIR/$(basename $i)"
done

echo $(find $OUTPUT_DIR -type f)

sed -i -e 's/"/'\''/g' -e 's/^/"/g' -e 's/$/"/g' -e 's/;/,/g' $(find $OUTPUT_DIR -type f)

