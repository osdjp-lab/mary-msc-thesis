# Summary of command use

cd 1-split
awk -f ../1-split.awk ../0-raw/results.csv
cd -
./2-fixed.sh 1-split 2-fixed
./3.1-values.sh 2-fixed 3.1-values
./3.2-groups.sh 2-fixed 3.2-groups
./4.1-counts.sh 3.1-values 2-fixed 4.1-basic-counts

