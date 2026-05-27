#!/usr/bin/gawk -f

BEGIN {
    # CSV field pattern – handles quoted fields with commas and escaped quotes
    FPAT = "([^,]*)|(\"([^\"]|\"\")*\")"
}

{
    for (i = 1; i <= NF; i++) {
        field = $i
        if (field ~ /^".*"$/) {
            sub(/^"/, "", field)
            sub(/"$/, "", field)
            gsub(/""/, "\"", field)
        }
        print field >> i ".txt"
        # close(i ".txt")   # uncomment if you have >~100 columns to avoid too many open files
    }
}

