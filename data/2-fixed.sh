#!/usr/bin/env sh

# Fix irregularities

INPUT_DIR="$1"
OUTPUT_DIR="$2"

for i in $(find $INPUT_DIR -type f); do
    cp "$i" "$OUTPUT_DIR/$(basename $i)"
done

echo $(find $OUTPUT_DIR -type f)

# Replace non standard double quotes

sed -i -e 's/“/"/g'  -e 's/”/"/g'  -e 's/«/"/g'  -e 's/»/"/g'  \
       -e 's/“/"/g'  -e 's/”/"/g'  -e 's/„/"/g'  -e 's/‟/"/g'  \
       -e 's/‹/"/g'  -e 's/›/"/g'  -e 's/「/"/g' -e 's/」/"/g' \
       -e 's/『/"/g' -e 's/』/"/g' -e 's/〝/"/g' -e 's/〞/"/g' \
       -e 's/〟/"/g' -e 's/＂/"/g' -e 's/｢/"/g'  -e 's/｣/"/g'  \
       -e 's/❝/"/g'  -e 's/❞/"/g'  \
       $(find $OUTPUT_DIR -type f)

# Replace non standard single quotes

sed -i -e "s/’/'/g"  -e "s/’/'/g" -e "s/‘/'/g"  -e "s/’/'/g"  \
       -e "s/‚/'/g"  -e "s/＇/'/g" -e "s/❛/s'/g" -e "s/❜/'/g" \
       $(find $OUTPUT_DIR -type f)

# Remove prexisting double quotes

sed -i -e 's/"/'\''/g' $(find $OUTPUT_DIR -type f)

# Strip leading and trailing spaces from fields and add delimiting quotes

sed -i -e 's/^\s*/"/g'    \
       -e 's/\s*$/"/g'    \
       $(find $OUTPUT_DIR -type f)

# Replace occurences of interfield seperator in the fields with comma

sed -i -e 's/;/,/g' $(find $OUTPUT_DIR -type f)

