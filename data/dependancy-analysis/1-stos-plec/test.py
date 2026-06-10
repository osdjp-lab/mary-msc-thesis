#!/usr/bin/env python3

import scipy.stats as stats

table = [[17, 0],
         [80, 10]]
oddsratio, p = stats.fisher_exact(table)

print(oddsratio)

print(p)
