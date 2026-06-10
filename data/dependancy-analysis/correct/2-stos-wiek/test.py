#!/usr/bin/env python3

import numpy as np
from math import comb
from scipy.stats import chi2_contingency

# Observed 4x2 table:
# rows = age groups
# cols = supplement use: [tak, nie]
table = np.array([
    [10, 0],   # <20
    [13, 1],   # 20–22
    [20, 4],   # 23–25
    [54, 5]    # >25
])

print("Observed table:")
print(table)

# Optional: chi-square test for comparison
chi2, p_chi, dof, expected = chi2_contingency(table, correction=False)
print("\nChi-square test")
print("Chi2 =", chi2)
print("dof  =", dof)
print("p    =", p_chi)
print("Expected counts:")
print(expected)

# Fisher-Freeman-Halton exact test for r x c tables
# This implementation enumerates all tables with the same margins
# and sums probabilities <= observed table probability.

row_sums = table.sum(axis=1)
col_sums = table.sum(axis=0)
n = table.sum()

def table_prob(first_col):
    """
    Probability of a 4x2 table under fixed margins,
    using the multivariate hypergeometric form.
    first_col is a vector of counts in the first column.
    """
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

# Enumerate all feasible first-column allocations with fixed row and column margins
for a in range(max(0, col_sums[0] - row_sums[1] - row_sums[2] - row_sums[3]),
               min(row_sums[0], col_sums[0]) + 1):
    for b in range(max(0, col_sums[0] - a - row_sums[2] - row_sums[3]),
                   min(row_sums[1], col_sums[0] - a) + 1):
        for c in range(max(0, col_sums[0] - a - b - row_sums[3]),
                       min(row_sums[2], col_sums[0] - a - b) + 1):
            d = col_sums[0] - a - b - c
            if 0 <= d <= row_sums[3]:
                candidate = [a, b, c, d]
                prob = table_prob(candidate)
                if prob <= obs_prob + 1e-15:
                    p_value += prob

print("\nFisher-Freeman-Halton exact test")
print("Exact p-value =", p_value)
