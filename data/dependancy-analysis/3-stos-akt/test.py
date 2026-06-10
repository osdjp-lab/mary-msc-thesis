#!/usr/bin/env python3

import numpy as np
from math import comb
from scipy.stats import chi2_contingency

# Observed 5x2 table:
# rows = physical activity groups
# cols = supplement use: [tak, nie]
table = np.array([
    [4, 0],   # Nigdy
    [30, 6],  # Rzadziej niż raz w tygodniu
    [26, 2],  # 1–2 razy w tygodniu
    [23, 2],  # 3–4 razy w tygodniu
    [14, 0]   # 5 lub więcej razy w tygodniu
])

print("Observed table:")
print(table)

# Chi-square test for comparison
chi2, p_chi, dof, expected = chi2_contingency(table, correction=False)
print("\nChi-square test")
print("Chi2 =", chi2)
print("dof  =", dof)
print("p    =", p_chi)
print("Expected counts:")
print(expected)

row_sums = table.sum(axis=1)
col_sums = table.sum(axis=0)
n = table.sum()

def table_prob(first_col):
    first_col = np.asarray(first_col)
    if first_col.sum() != col_sums[0]:
        return 0.0
    if np.any(first_col < 0) or np.any(first_col > row_sums):
        return 0.0

    num = 1
    for rs, x in zip(row_sums, first_col):
        num *= comb(rs, x)

    den = comb(n, col_sums[0])
    return num / den

obs_first_col = table[:, 0]
obs_prob = table_prob(obs_first_col)

print("\nObserved table probability =", obs_prob)

p_value = 0.0

# Enumerate all feasible first-column allocations for 5 rows
for a in range(max(0, col_sums[0] - row_sums[1] - row_sums[2] - row_sums[3] - row_sums[4]),
               min(row_sums[0], col_sums[0]) + 1):
    for b in range(max(0, col_sums[0] - a - row_sums[2] - row_sums[3] - row_sums[4]),
                   min(row_sums[1], col_sums[0] - a) + 1):
        for c in range(max(0, col_sums[0] - a - b - row_sums[3] - row_sums[4]),
                       min(row_sums[2], col_sums[0] - a - b) + 1):
            for d in range(max(0, col_sums[0] - a - b - c - row_sums[4]),
                           min(row_sums[3], col_sums[0] - a - b - c) + 1):
                e = col_sums[0] - a - b - c - d
                if 0 <= e <= row_sums[4]:
                    candidate = [a, b, c, d, e]
                    prob = table_prob(candidate)
                    if prob <= obs_prob + 1e-15:
                        p_value += prob

print("\nFisher-Freeman-Halton exact test")
print("Exact p-value =", p_value)
