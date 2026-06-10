#!/usr/bin/env python3

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import mannwhitneyu, norm

# -------------------------------------------------
# Raw data (as strings) – keep them for reference only
# -------------------------------------------------
group_A_raw = [4,4,5,2,4,5,5,4,4,5,5,5,5,5,4,4,5,4,5,5,5,5,5,5,5,5,4,5,4,4,5,3,3,1,3,1,5,2,5,4,2,4,5,4,4,2,5,5,2,4,1,3,4,0,4,4,5,0,3,4,2,3,5,5,4,3,2,4,5,4,2,4,5,2,5,2,1,3,3,5,5,3,5,2,5,4,5,3,2,4,5,2,5,2,5,5,4,1,4,3,4,4,0,5,1,3,5]

group_B_raw = ["Tak","Tak","Tak","Nie","Tak","Nie","Tak","Tak","Nie","Tak","Nie","Tak","Tak","Tak","Tak","Tak","Tak","Tak","Tak","Nie","Tak","Nie","Tak","Tak","Nie","Tak","Tak","Tak","Tak","Tak","Tak","Tak","Nie","Nie","Tak","Nie","Tak","Tak","Tak","Nie","Nie","Nie","Nie","Tak","Tak","Tak","Tak","Tak","Tak","Nie","Nie","Nie","Tak","Nie","Tak","Tak","Nie","Nie","Tak","Tak","Tak","Tak","Nie","Nie","Nie","Nie","Nie","Tak","Nie","Nie","Tak","Tak","Tak","Nie","Nie","Tak","Tak","Tak","Nie","Nie","Tak","Nie","Nie","Nie","Tak","Tak","Tak","Tak","Nie","Nie","Nie","Tak","Tak","Tak","Tak","Tak","Tak","Tak","Nie","Nie","Tak","Nie","Tak","Tak","Tak","Nie","Tak"]

# -------------------------------------------------
# Convert to numeric vectors
# -------------------------------------------------
group_A = np.array(group_A_raw, dtype=int)                # 0‑5 Likert scores
b_map = {"Tak": 1, "Nie": 0}
group_B = np.array([b_map[x] for x in group_B_raw], dtype=int)  # binary 0/1

# -------------------------------------------------
# Mann‑Whitney U test
# -------------------------------------------------
u, p = mannwhitneyu(group_A, group_B, alternative="two-sided")
print(f"U = {u:.0f},  p‑value = {p:.4g}")

# -------------------------------------------------
# Effect‑size (optional)
# -------------------------------------------------
n1, n2 = len(group_A), len(group_B)
mean_U = n1 * n2 / 2
sd_U   = np.sqrt(n1 * n2 * (n1 + n2 + 1) / 12)
z = (u - mean_U) / sd_U
r = z / np.sqrt(n1 + n2)
print(f"Z = {z:.3f},  r (effect size) = {r:.3f}")

