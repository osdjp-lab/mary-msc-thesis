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

# Variables requiring extra preprocessing
#
# Pseudocode:
#
# In place replace synonyms by their primary descriptors
#

# 4)
#
# Set 1:
# - "Dietetyka";"25"
# - "Dietetyka kliniczna";"1"
# - "Dietetyka sportowa";"1"
# 
# Set 2:
# - "Filologia";"1"
# - "Filologia angielska";"2"
# 
# Set 3:
# - "Lekarski";"1"
# - "Medycyna";"1"
# 
# Set 4:
# - "Psychologia";"49"
# - "Psychologia kliniczna";"1"
# - "Psychologia kliniczna i psychoterapia";"2"
# - "Psychologia, Prawo";"1"
# 
# Set 5:
# - "Psychologia, Prawo";"1"
#

sed -i -e 's/"Dietetyka kliniczna"/"Dietetyka"/g' \
       -e 's/"Dietetyka sportowa"/"Dietetyka"/g' \
       -e 's/"Filologia angielska"/"Filologia"/g' \
       -e 's/"Lekarski"/"Medycyna"/g' \
       -e 's/"Psychologia kliniczna"/"Psychologia"/g' \
       -e 's/"Psychologia kliniczna i psychoterapia"/"Psychologia"/g' \
       -e 's/\("Psychologia, Prawo"\)/\1\n\1/g' \
       -e 's/"Psychologia, Prawo"/"Psychologia"/' \
       -e 's/"Psychologia, Prawo"/"Prawo"/' \
       "${OUTPUT_DIR}/4.txt"

# 14)
# 
# Konsultuje:
# - "Dostałam zalecenie od lekarza specjalisty";"1"
# - "Tak, specjalista medycyny funkcjonalnej";"1"
# - "Tak, z lekarzem";"27"
# - "z lekarzem, ale sporo czytam na ten temat";"1"
# - "Głównie sama decyduje, ale częśxiowo też na zalecenie lekarza i dietetyka";"1"
# - "Tak, z dietetykiem";"15"
# - "Tak, z farmaceutą";"6"
# - "Z trenerem";"1"
# 
# Nie konsultuje:
# - "Na podstawie własnej wiedzy";"1"
# - "Nie, nie konsultuję";"53"
#

sed -i -e 's/"Dostałam zalecenie od lekarza specjalisty"/"Konsultuje"/g' \
       -e 's/"Tak, specjalista medycyny funkcjonalnej"/"Konsultuje"/g' \
       -e 's/"Tak, z lekarzem"/"Konsultuje"/g' \
       -e 's/"z lekarzem, ale sporo czytam na ten temat"/"Konsultuje"/g' \
       -e 's/"Głównie sama decyduje, ale częśxiowo też na zalecenie lekarza i dietetyka"/"Konsultuje"/g' \
       -e 's/"Tak, z dietetykiem"/"Konsultuje"/g' \
       -e 's/"Tak, z farmaceutą"/"Konsultuje"/g' \
       -e 's/"Z trenerem"/"Konsultuje"/g' \
       -e 's/"Na podstawie własnej wiedzy"/"Nie konsultuje"/g' \
       -e 's/"Nie, nie konsultuję"/"Nie konsultuje"/g' \
       "${OUTPUT_DIR}/14.txt"

# 27)

# Opinia pojedynczego specjalisty:
# - "Lekarz";"34"
# - "Lekarze medycyny funkcjonalnej";"1"
# - "Dietetyk";"17"
# - "Farmaceuta";"11"
# 
# Opinia zespołu / instytutu:
# - "Badania naukowe";"1"
# - "Instytucje zdrowia publicznego";"18"
# - "Portale zbierające wyniki badań lub też oponie specjalistów, ale wielu, żeby mozna było porównać podejścia, nie ufam jednemu lekarzowi, dietetykowi itp. ponieważ każdy mówi co innego";"1"
#
# Inne:
# - "Naukowe portale internetowe";"23"
# - "Takie, którego polecenia nie wynikają z profitów jakie otrzymują";"1"

sed -i -e 's/"Lekarz"/"Opinia pojedynczego specjalisty"/g' \
       -e 's/"Lekarze medycyny funkcjonalnej"/"Opinia pojedynczego specjalisty"/g' \
       -e 's/"Dietetyk"/"Opinia pojedynczego specjalisty"/g' \
       -e 's/"Farmaceuta"/"Opinia pojedynczego specjalisty"/g' \
       -e 's?"Badania naukowe"?"Opinia zespołu lub instytutu"?g' \
       -e 's?"Instytucje zdrowia publicznego"?"Opinia zespołu lub instytutu"?g' \
       -e 's?"Portale zbierające wyniki badań lub też oponie specjalistów, ale wielu, żeby mozna było porównać podejścia, nie ufam jednemu lekarzowi, dietetykowi itp. ponieważ każdy mówi co innego"?"Opinia zespołu lub instytutu"?g' \
       -e 's/"Naukowe portale internetowe"/"Inne"/g' \
       -e 's/"Takie, którego polecenia nie wynikają z profitów jakie otrzymują"/"Inne"/g' \
       "${OUTPUT_DIR}/27.txt"

