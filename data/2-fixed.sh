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

sed -i -e 's/^\s*//g'    \
       -e 's/\s*$//g'    \
       $(find $OUTPUT_DIR -type f)

# Replace occurences of interfield seperator in the fields with comma

sed -i -e 's/;/,/g' $(find $OUTPUT_DIR -type f)

# Irregular issue fixes

# 10

sed -i -e "s/ oraz ,,Merz Spezial'/, Merz Spezial/" \
       -e "s/, ale jest to zarejestrowane jako lek, nie suplement (Ascofer),//" \
       -e "s/i \(Merz Spezial\)/, \1/" \
       -e "s/(problemy z żelazem i niską ferrytyna)//" \
       -e "s/laktoferyna/Laktoferyna/g" \
       -e "s/beta alanina/Beta-alanina/g" \
       -e "s/complex B/B kompleks/g" \
       -e "s/kompleks witamin b/B kompleks/g" \
       -e "s/kompleks witamin z grupy B/B kompleks/g" \
       -e "s/Wit z grupy B/B kompleks/g" \
       -e "s/Wit B complex/B kompleks/g" \
       -e "s/Magnesium citrate/Cytrynian magnezu/g" \
       -e "s/wapń/Wapń/g" \
       -e "s/karnozyna cynkowa/Karnozyna cynkowa/g" \
       -e "s/\(,\s*\)cynk\(\s*,\)/\1Cynk\2/g" \
       -e "s/likopen/Likopen/g" \
       -e "s/bromelia/Bromelia/g" \
       -e "s/olej z czarnuszki/Olej z czarnuszki/g" \
       -e "s/Laktoferyna + szczep L. plantarum/Laktoferyna/g" \
       -e "s/żelazo/Żelazo/g" \
       -e "s/\s*,\s*/,/g" \
       -e "s/,E,/,Witamina E,/g" \
       -e "s/,K,/,Witamina K,/g" \
       "${OUTPUT_DIR}/10.txt"

# 15

sed -i -e "s/ zlecone przez lekarza/Zlecone przez lekarza/g" \
       -e "s/skóra, włosy, paznokcie/skóra włosy paznokcie/g" \
       -e "s/obniżony poziom vit D/Obniżony poziom witaminy D/g" \
       -e "s/Karmię piersią a mam ograniczoną dietę przez alergie i problemy jelitowe/Poprawa zdrowia/" \
       -e "s/\s*,\s*/,/g" \
       "${OUTPUT_DIR}/15.txt"

# 16

       # -e "s?Interesuję się ziołami i jestem członkiem grupy stosującej nutraceutyki Arbonne?\Znajomi/rodzina?g" \
       # -e "s/Literatura/Badania naukowe/g" \
       # -e "s/PubMed/Badania naukowe/g" \
       # -e "s/Rzetelne zrodla w internecie/Internet (artykuły blogi)/g" \

sed -i -e "s/artykuły, blogi/artykuły blogi/g" \
       -e "s/badania naukowe/Badania naukowe/g" \
       -e "s/studia/Studia/g" \
       -e "s/książki/Książki/g" \
       -e "s/\s*,\s*/,/g" \
       "${OUTPUT_DIR}/16.txt"

# 26

       # -e "s/Konsultacje z farmaceutą/Konsultacja ze specjalistą/g" \
       # -e "s/Dietetyk/Konsultacja ze specjalistą/g" \
       # -e "s/Od lekarza/Konsultacja ze specjalistą/g" \
       # -e "s/Artykuły naukowe/Artykuły naukowe lub popularnonaukowe/g" \
       # -e "s/Artykuły popularnonaukowe/Artykuły naukowe lub popularnonaukowe/g" \
       # -e "s/Webinary edukacyjne/Szkolenia/g" \
       # -e "s/Warsztaty na uczelni/Szkolenia/g" \
       # -e "s/Specjalistyczne szkolenia/Szkolenia/g" \
       # -e "s/Infografiki/Materiały lub nagrania/g" \
       # -e "s/Krótkie filmy edukacyjne/Materiały lub nagrania/g" \
       # -e "s/Podcasty/Materiały lub nagrania/g" \

sed -i -e "s/specjalistyczne szkolenia/Specjalistyczne szkolenia/g" \
       -e "s/webinary edukacyjne/Webinary edukacyjne/g" \
       -e "s/\s*,\s*/,/g" \
       "${OUTPUT_DIR}/26.txt"

# 28

sed -i -e 's/^-$/Brak/g' \
       -e 's/^.$/Brak/g' \
       -e 's/^aby dać mi więcej motywacji i bardziej świadomy sposób rozumienia suplementów$/Lepsza edukacja/g' \
       -e 's/^Artykuł naukowy$/Badania naukowe/g' \
       -e 's/^badam To sama od 13 lat$/Ciekawość/g' \
       -e 's/^Badania naukowe$/Badania naukowe/g' \
       -e 's/^Bardziej atrakcyjne i zachęcające metody zdobywania wiedzy$/Ciekawość/g' \
       -e 's/^Chciałbym się czegoś więcej nauczyć, pogłębić swoją wiedzę$/Ciekawość/g' \
       -e 's/^Ciągle choruję na uczelni. Jakie witaminy działają?$/Chęć zadbania o zdrowie/g' \
       -e 's/^Ciekawe filmiki, artykuły, itd.$/Ciekawość/g' \
       -e 's/^ciekawość$/Ciekawość/g' \
       -e 's/^Ciekawość jak działa organizm i dlaczego dany suplement jest przydatny$/Ciekawość/g' \
       -e 's/^Ciekawy przekaz$/Ciekawość/g' \
       -e 's/^Czas$/Więcej czasu/g' \
       -e 's/^Darmowe badania krwi bez skierowania$/Chęć zadbania o zdrowie/g' \
       -e "s/^Dostęp do rzetelnych informacji opartych na badaniach, a nie na reklamach, które obiecują 'cudowne' efekty.$/Rzetelne informacje/g" \
       -e 's/^Edukacja i szerzenie wiedzy poprzez projekty, warsztaty i zajęcia z zakresu biologii i nauk o człowieku$/Lepsza edukacja/g' \
       -e 's/^Edukacja obowiązkowa wczesniej w szkole$/Lepsza edukacja/g' \
       -e 's/^Edukacja o tym, jak sprawdzać suplementy w rejestrach$/Lepsza edukacja/g' \
       -e 's/^Edukacja państwa - reklamy prawdziwe a nie zakłamane$/Rzetelne informacje/g' \
       -e 's/^Fajnie by było gdyby dietetyk robił warsztaty na uczelni$/Lepsza edukacja/g' \
       -e 's/^Filmiki w internecie$/Nagrania edukacyjne/g' \
       -e 's/^indywidualizacja planów ich zażywania a nie moda na niektóre$/Chęć zadbania o zdrowie/g' \
       -e 's/^Interesujący wykład$/Ciekawość/g' \
       -e 's/^jakaś ciekawa kampania edukacyjna pokazująca prawdziwe oblicze, do tej pory suplementy są uważane za rozwiązanie każdego problemu a niestety tak to nie działa$/Ciekawość/g' \
       -e 's/^jasne, zwięzłe informacje$/Lepsza edukacja/g' \
       -e 's/^jeśli zajdę w ciążę$/Chęć zadbania o zdrowie/g' \
       -e 's/^Jestem zachęcona$/Brak/g' \
       -e 's/^Już teraz jestem zachęcony do dowiedzenia się więcej o suplementach$/Brak/g' \
       -e 's/^Już większej zachęty nie potrzebuję, mam niedoczynność tarczycy, insulinooporność, IBS oraz hiperlipidemię, wsparcie suplementami jest ważne w moim przypadku :)$/Brak/g' \
       -e 's/^Konsekwencje zdrowotne przy niestosowaniu się do zaleceń$/Chęć zadbania o zdrowie/g' \
       -e 's/^Krótkie filmiki na internecie, posty na mediach$/Nagrania edukacyjne/g' \
       -e 's/^Krótkie przejrzyste treści$/Materiały edukacyjne/g' \
       -e 's/^Krótkie spotkania z farmaceutą odnośnie suplementacji i ulotki$/Konsultacja ze specjalistą/g' \
       -e 's/^Łatwa dostępność do wiedzy i badań$/Lepsza edukacja/g' \
       -e 's/^Łatwa dostępność informacji np. Na instagramie$/Lepsza edukacja/g' \
       -e 's/^Łatwe do zrozumienia źródła wiedzy na ten temat$/Lepsza edukacja/g' \
       -e 's/^Łatwiejszy dostęp do informacji opartych o najnowsze badania naukowe$/Lepsza edukacja/g' \
       -e 's/^moje studia dietetyczne są ważnym powodem, aby dowiedzieć się więcej$/Brak/g' \
       -e 's/^Moje zdrowie$/Chęć zadbania o zdrowie/g' \
       -e 's/^Motywuje mnie moja aktualna sytuacja - stan zdrowia, wyniki badań, samopoczucie i chęć poprawy w tych zakresach$/Chęć zadbania o zdrowie/g' \
       -e 's/^naukowe dowody na ich skuteczność$/Badania naukowe/g' \
       -e 's/^Nic$/Brak/g' \
       -e 's/^Nie potrzebuje więcejwiedzy w tym zakresie$/Brak/g' \
       -e 's/^nie potrzebuję zachęty, wiem jak ważna jest rzetelna wiedza na temat suplementów i staram się ją ciągle poszerzać.$/Brak/g' \
       -e 's/^Nie potrzebuję zachęty, z własnej woli poszerzam wiedzę$/Brak/g' \
       -e 's/^Nie wiem$/Brak/g' \
       -e 's/^Nie wiem, nic.$/Brak/g' \
       -e 's/^Odróżnienie nauki od marketingu$/Rzetelne informacje/g' \
       -e 's/^Ogólnie nie polecam suplementów, wolę leki. Staram się stosować leki a nie suplementy, bo są lepiej przebadane. Więc ograniczam jak mogę suplementy.$/Brak/g' \
       -e 's/^Pewność że to co czytam jest rzetelne.$/Rzetelne informacje/g' \
       -e 's/^Podejście do suplementów i wiedza o nich$/Lepsza edukacja/g' \
       -e 's/^Podkasty lekarzy$/Nagrania edukacyjne/g' \
       -e 's/^poprawić mój ogólny stan zdrowia$/Chęć zadbania o zdrowie/g' \
       -e 's/^posty na ig$/Ciekawość/g' \
       -e 's/^Potrzeba$/Chęć zadbania o zdrowie/g' \
       -e 's/^Potrzeby własne$/Chęć zadbania o zdrowie/g' \
       -e 's/^Powinno być więcej ciekawych stron na ten temat$/Ciekawość/g' \
       -e 's/^Proste opisy bez zbędnych dodatków które sa niezrozumiałe$/Rzetelne informacje/g' \
       -e 's/^Prosty, szybki, przekaz$/Rzetelne informacje/g' \
       -e 's/^Przekaz oparty na wiedzy dietetyków, lekarzy i farmaceutów$/Rzetelne informacje/g' \
       -e 's/^Raczej nic$/Brak/g' \
       -e 's/^Reklamy ministerstwa zdrowia  informujące w tv o suplementacji$/Rzetelne informacje/g' \
       -e 's/^Rozwój nauki i medycyny$/Badania naukowe/g' \
       -e 's/^Rzetelne informacje$/Rzetelne informacje/g' \
       -e 's/^Rzetelne ulotki w aptekach$/Rzetelne informacje/g' \
       -e 's/^Rzetelność$/Rzetelne informacje/g' \
       -e 's/^Rzetelność informacji$/Rzetelne informacje/g' \
       -e 's/^Samoświadomość dot zdrowia$/Lepsza edukacja/g' \
       -e 's/^Skuteczność ich działania, dostęp do wiarygodnych informacji$/Rzetelne informacje/g' \
       -e 's/^Skutki uboczne$/Rzetelne informacje/g' \
       -e 's/^Spotkania z osobami, które mają wiedzę na ten temat.$/Lepsza edukacja/g' \
       -e 's/^Szybki dostęp do informacji$/Rzetelne informacje/g' \
       -e 's/^Ulotki, artykuły$/Lepsza edukacja/g' \
       -e 's/^Umieszczenie wiedzy na jednym portalu, stronie www$/Rzetelne informacje/g' \
       -e 's/^Warsztaty$/Lepsza edukacja/g' \
       -e 's/^Warsztaty oparte na rzetelnej wiedzy, badaniach przeprowadzone przez kompetentna osobe , ktora potrafi przekazac wiedze w przystepny sposob, oraz mozliwosc konsultacji, doboru suplementow i regularne monitorowanie wynikow.$/Lepsza edukacja/g' \
       -e 's/^Warsztaty, wykłady o suplementach :)$/Lepsza edukacja/g' \
       -e 's/^Więcej artykułów, oficjalnych informacji$/Rzetelne informacje/g' \
       -e 's/^Więcej ciekawych filmików edukacyjnych$/Nagrania edukacyjne/g' \
       -e 's/^Więcej czasu :)$/Więcej czasu/g' \
       -e 's/^Więcej czasu$/Więcej czasu/g' \
       -e 's/^więcej informacji$/Rzetelne informacje/g' \
       -e 's/^Więcej warsztatów na ten temat$/Lepsza edukacja/g' \
       -e 's/^Więcej warsztatów na uczelni$/Lepsza edukacja/g' \
       -e 's/^W moim przypadku są to moje choroby, niedoczynność tarczycy, insulinooporność, hiperlipidemia.$/Chęć zadbania o zdrowie/g' \
       -e 's/^Wyniki badan$/Chęć zadbania o zdrowie/g' \
       -e 's/^Zdrowie$/Chęć zadbania o zdrowie/g' \
       -e 's/^Złe samopoczucie$/Chęć zadbania o zdrowie/g' \
       -e 's/^zwiększyć moją świadomość dotyczącą zdrowia i codziennego stylu życia$/Lepsza edukacja/g' \
       "${OUTPUT_DIR}/28.txt"

# Variables requiring extra preprocessing
#
# Pseudocode:
#
# In place replace synonyms by their primary descriptors
#

# 4)
#
# Set 1:
# - Dietetyka;25
# - Dietetyka kliniczna;1
# - Dietetyka sportowa;1
# 
# Set 2:
# - Filologia;1
# - Filologia angielska;2
# 
# Set 3:
# - Lekarski;1
# - Medycyna;1
# 
# Set 4:
# - Psychologia;49
# - Psychologia kliniczna;1
# - Psychologia kliniczna i psychoterapia;2
# - Psychologia, Prawo;1
# 
# Set 5:
# - Psychologia, Prawo;1
#

sed -i -e 's/Dietetyka kliniczna/Dietetyka/g' \
       -e 's/Dietetyka sportowa/Dietetyka/g' \
       -e 's/Filologia angielska/Filologia/g' \
       -e 's/Lekarski/Medycyna/g' \
       -e 's/Psychologia kliniczna/Psychologia/g' \
       -e 's/Psychologia kliniczna i psychoterapia/Psychologia/g' \
       -e 's/\(Psychologia, Prawo\)/\1\n\1/g' \
       -e 's/Psychologia, Prawo/Psychologia/' \
       -e 's/Psychologia, Prawo/Prawo/' \
       ${OUTPUT_DIR}/4.txt

# 14)
# 
# Konsultuje:
# - Dostałam zalecenie od lekarza specjalisty;1
# - Tak, specjalista medycyny funkcjonalnej;1
# - Tak, z lekarzem;27
# - z lekarzem, ale sporo czytam na ten temat;1
# - Głównie sama decyduje, ale częśxiowo też na zalecenie lekarza i dietetyka;1
# - Tak, z dietetykiem;15
# - Tak, z farmaceutą;6
# - Z trenerem;1
# 
# Nie konsultuje:
# - Na podstawie własnej wiedzy;1
# - Nie, nie konsultuję;53
#

sed -i -e 's/Dostałam zalecenie od lekarza specjalisty/Konsultuje/g' \
       -e 's/Tak, specjalista medycyny funkcjonalnej/Konsultuje/g' \
       -e 's/Tak, z lekarzem/Konsultuje/g' \
       -e 's/z lekarzem, ale sporo czytam na ten temat/Konsultuje/g' \
       -e 's/Głównie sama decyduje, ale częśxiowo też na zalecenie lekarza i dietetyka/Konsultuje/g' \
       -e 's/Tak, z dietetykiem/Konsultuje/g' \
       -e 's/Tak, z farmaceutą/Konsultuje/g' \
       -e 's/Z trenerem/Konsultuje/g' \
       -e 's/Na podstawie własnej wiedzy/Nie konsultuje/g' \
       -e 's/Nie, nie konsultuję/Nie konsultuje/g' \
       ${OUTPUT_DIR}/14.txt

# 27)

# Opinia pojedynczego specjalisty:
# - Lekarz;34
# - Lekarze medycyny funkcjonalnej;1
# - Dietetyk;17
# - Farmaceuta;11
# 
# Opinia zespołu / instytutu:
# - Badania naukowe;1
# - Instytucje zdrowia publicznego;18
# - Portale zbierające wyniki badań lub też oponie specjalistów, ale wielu, żeby mozna było porównać podejścia, nie ufam jednemu lekarzowi, dietetykowi itp. ponieważ każdy mówi co innego;1
#
# Inne:
# - Naukowe portale internetowe;23
# - Takie, którego polecenia nie wynikają z profitów jakie otrzymują;1

# sed -i -e 's/Lekarz/Opinia pojedynczego specjalisty/g' \
#        -e 's/Lekarze medycyny funkcjonalnej/Opinia pojedynczego specjalisty/g' \
#        -e 's/Dietetyk/Opinia pojedynczego specjalisty/g' \
#        -e 's/Farmaceuta/Opinia pojedynczego specjalisty/g' \
#        -e 's?Badania naukowe?Opinia zespołu lub instytutu?g' \
#        -e 's?Instytucje zdrowia publicznego?Opinia zespołu lub instytutu?g' \
#        -e 's?Portale zbierające wyniki badań lub też oponie specjalistów, ale wielu, żeby mozna było porównać podejścia, nie ufam jednemu lekarzowi, dietetykowi itp. ponieważ każdy mówi co innego?Opinia zespołu lub instytutu?g' \
#        -e 's/Takie, którego polecenia nie wynikają z profitów jakie otrzymują/Inne/g' \
#        "${OUTPUT_DIR}/27.txt"

# Strip leading and trailing spaces from fields and add delimiting quotes

sed -i -e 's/^\s*//g'    \
       -e 's/\s*$//g'    \
       $(find $OUTPUT_DIR -type f)

# Add field delimiting quotes

sed -i -e 's/^/"/g'    \
       -e 's/$/"/g'    \
       $(find $OUTPUT_DIR -type f)

