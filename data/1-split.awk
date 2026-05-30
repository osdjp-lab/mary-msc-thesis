#!/usr/bin/gawk -f

BEGIN {
    # CSV field pattern – handles quoted fields with commas and escaped quotes
    FPAT = "([^,]*)|(\"([^\"]|\"\")*\")"
    # remember which column‑files have already been created
    for (i = 1; i <= 0; i++) seen[i] = 0   # initialise an empty array
}

{
    for (i = 1; i <= NF; i++) {
        field = $i

        # Strip surrounding quotes and un‑escape inner double quotes
        if (field ~ /^".*"$/) {
            sub(/^"/, "", field)
            sub(/"$/, "", field)
            gsub(/""/, "\"", field)
        }

        # First time we write this column → truncate the file
        if (!(i in seen)) {
            print field >  i ".txt"   # ">" creates/truncates
            seen[i] = 1
        } else {
            print field >> i ".txt"   # ">>" appends
        }

        # Uncomment the next line if you have >~100 columns and want to avoid
        # hitting the open‑file limit.
        # close(i ".txt")
    }
}

