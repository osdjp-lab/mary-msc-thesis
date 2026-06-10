#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import pandas as pd
from scipy.stats import spearmanr


def spearman_vs_first(df: pd.DataFrame) -> pd.DataFrame:
    """
    Computes Spearman rank correlation between the first column and every
    other column in ``df``.
    Returns a DataFrame with columns: ['target_column', 'rho', 'p_value'].
    If there is nothing to correlate (e.g. only one column) an empty
    DataFrame with the same column names is returned.
    """
    # -------------------------------------------------
    # 1. reference column (the very first one in the file)
    # -------------------------------------------------
    if df.shape[1] < 2:                     # <‑‑ only one column → nothing to compare
        return pd.DataFrame(columns=["target_column", "rho", "p_value"])

    ref_name = df.columns[0]
    ref_vals = df.iloc[:, 0]

    # -------------------------------------------------
    # 2. loop over the remaining columns
    # -------------------------------------------------
    results = []
    for col in df.columns[1:]:
        # keep only rows where BOTH variables are present
        pair = pd.concat([ref_vals, df[col]], axis=1).dropna()
        if pair.empty:
            rho, p = float("nan"), float("nan")
        else:
            # spearmanr will also return (nan, nan) if one of the vectors
            # has zero variance; we keep that outcome – it signals “no info”.
            rho, p = spearmanr(pair.iloc[:, 0], pair.iloc[:, 1])

        results.append({"target_column": col, "rho": rho, "p_value": p})

    # -------------------------------------------------
    # 3. build the output DataFrame
    # -------------------------------------------------
    out = pd.DataFrame(results)

    if out.empty:                     # no usable pairs at all
        return out

    # add absolute rho only for sorting purposes, then drop it again
    out["abs_rho"] = out["rho"].abs()
    out = out.sort_values("abs_rho", ascending=False).drop(columns="abs_rho")
    out.reset_index(drop=True, inplace=True)
    return out


# -----------------------------------------------------------------
# 4. command‑line interface (optional – you can also import the
#    function from another script)
# -----------------------------------------------------------------
if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.stderr.write("Usage: python spearman_all.py <path_to_csv>\n")
        sys.exit(1)

    csv_path = sys.argv[1]

    # -----------------------------------------------------------------
    # read the CSV – we let pandas infer dtypes; non‑numeric columns are
    # kept because they may be the reference column, but they will be
    # ignored by spearmanr if they cannot be cast to floats.
    # -----------------------------------------------------------------
    df = pd.read_csv(csv_path,
                     low_memory=False,
                     na_values=["", "NA", "N/A", "null"], sep=';')

    print(df)

    summary = spearman_vs_first(df)

    # -----------------------------------------------------------------
    # pretty console output
    # -----------------------------------------------------------------
    print("\nSpearman rank correlation of the first column with all others:")
    print("-" * 70)
    if summary.empty:
        print("❌ No usable pairs were found (maybe the file has only one column "
              "or all rows contain missing data).")
    else:
        print(summary.to_string(index=False, float_format="{:.10f}".format))
    print("-" * 70)
    print(f"Reference column: {df.columns[0]}")
    print(f"Rows read from file: {len(df)}")

