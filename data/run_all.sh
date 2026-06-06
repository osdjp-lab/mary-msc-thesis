#!/usr/bin/env sh

# Run all scripts in order

OUTPUT_DIR='org'

mkdir -p $OUTPUT_DIR

mkdir $OUTPUT_DIR/1-split

cd $OUTPUT_DIR/1-split
awk -f ../../1-split.awk ../../raw/results.csv
cd -

mkdir -p $OUTPUT_DIR/2-fixed
./2-fixed.sh $OUTPUT_DIR/1-split $OUTPUT_DIR/2-fixed

mkdir -p $OUTPUT_DIR/3.1-values
./3.1-values.sh $OUTPUT_DIR/2-fixed $OUTPUT_DIR/3.1-values

mkdir -p $OUTPUT_DIR/3.2-groups
./3.2-groups.sh $OUTPUT_DIR/2-fixed $OUTPUT_DIR/3.2-groups

mkdir -p $OUTPUT_DIR/4.1-reg-counts
./4.1-reg-counts.sh $OUTPUT_DIR/3.1-values $OUTPUT_DIR/2-fixed $OUTPUT_DIR/4.1-reg-counts

mkdir -p $OUTPUT_DIR/4.2-alt-counts
./4.2-alt-counts.sh $OUTPUT_DIR/2-fixed $OUTPUT_DIR/3.1-values $OUTPUT_DIR/4.2-alt-counts

OUTPUT_DIR='only-yes'

mkdir -p $OUTPUT_DIR

mkdir $OUTPUT_DIR/1-split

cd $OUTPUT_DIR/1-split
awk -f ../../1-split.awk ../../raw/results-only-yes.csv
cd -

mkdir -p $OUTPUT_DIR/2-fixed
./2-fixed.sh $OUTPUT_DIR/1-split $OUTPUT_DIR/2-fixed

mkdir -p $OUTPUT_DIR/3.1-values
./3.1-values.sh $OUTPUT_DIR/2-fixed $OUTPUT_DIR/3.1-values

mkdir -p $OUTPUT_DIR/3.2-groups
./3.2-groups.sh $OUTPUT_DIR/2-fixed $OUTPUT_DIR/3.2-groups

mkdir -p $OUTPUT_DIR/4.1-reg-counts
./4.1-reg-counts.sh $OUTPUT_DIR/3.1-values $OUTPUT_DIR/2-fixed $OUTPUT_DIR/4.1-reg-counts

mkdir -p $OUTPUT_DIR/4.2-alt-counts
./4.2-alt-counts.sh $OUTPUT_DIR/2-fixed $OUTPUT_DIR/3.1-values $OUTPUT_DIR/4.2-alt-counts

OUTPUT_DIR='only-no'

mkdir -p $OUTPUT_DIR

mkdir $OUTPUT_DIR/1-split

cd $OUTPUT_DIR/1-split
awk -f ../../1-split.awk ../../raw/results-only-no.csv
cd -

mkdir -p $OUTPUT_DIR/2-fixed
./2-fixed.sh $OUTPUT_DIR/1-split $OUTPUT_DIR/2-fixed

mkdir -p $OUTPUT_DIR/3.1-values
./3.1-values.sh $OUTPUT_DIR/2-fixed $OUTPUT_DIR/3.1-values

mkdir -p $OUTPUT_DIR/3.2-groups
./3.2-groups.sh $OUTPUT_DIR/2-fixed $OUTPUT_DIR/3.2-groups

mkdir -p $OUTPUT_DIR/4.1-reg-counts
./4.1-reg-counts.sh $OUTPUT_DIR/3.1-values $OUTPUT_DIR/2-fixed $OUTPUT_DIR/4.1-reg-counts

mkdir -p $OUTPUT_DIR/4.2-alt-counts
./4.2-alt-counts.sh $OUTPUT_DIR/2-fixed $OUTPUT_DIR/3.1-values $OUTPUT_DIR/4.2-alt-counts

