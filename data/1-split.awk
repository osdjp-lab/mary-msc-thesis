#!/usr/bin/gawk -f
# ------------------------------------------------------------
# Split CSV rows into one file per column (col 1 → 1.txt, …)
# Handles:
#   • fields that are NOT quoted
#   • fields that are quoted and may contain commas
#   • quoted fields that contain escaped double‑quotes ("")
#   • empty fields
# ------------------------------------------------------------

BEGIN {
    # FPAT – “field pattern” tells gawk how to recognise a field.
    #   1. A quoted field:
    #        " (anything except a quote OR a pair of quotes) * "
    #   2. OR an unquoted field: any characters up to the next comma
    #   3. The pattern also matches an empty field between two commas.
    FPAT = \
        "([^,]*|\"([^\"]|\"\")*\")"

    # keep track of which column files have already been opened
    # (first write uses ">", later writes use ">>")
    delete seen
}

{
    # Process each field in the current line
    for (i = 1; i <= NF; i++) {
        field = $i

        # ------------------------------------------------------------------
        # Strip surrounding double‑quotes (if present) and un‑escape "" → "
        # ------------------------------------------------------------------
        if (field ~ /^".*"$/) {
            # remove the leading and trailing quote
            sub(/^"/, "", field)
            sub(/"$/, "", field)
            # replace doubled quotes with a single quote
            gsub(/""/, "\"", field)
        }

        # ---------------------------------------------------------------
        # Write the field to its column‑specific file.
        #   First occurrence → truncate (">")
        #   Later occurrences → append (">>")
        # ---------------------------------------------------------------
        if (!(i in seen)) {
            print field > i ".txt"      # creates & truncates
            seen[i] = 1
        } else {
            print field >> i ".txt"     # appends
        }

        # Optional: close the file to stay under the OS file‑descriptor limit
        # close(i ".txt")
    }
}

