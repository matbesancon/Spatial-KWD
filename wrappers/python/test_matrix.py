# @fileoverview Copyright (c) 2019-2020, Stefano Gualandi,
#               via Ferrata, 1, I-27100, Pavia, Italy
#
# @author stefano.gualandi@gmail.com (Stefano Gualandi)

# Library for reading input files
import pickle
import numpy

from random import randint, uniform, seed
from time import perf_counter

from KWD import *


seed(13)

X, Y, A, B, C = [], [], [], [], []

# Take a subeset of data
N = 32 * 32

for _ in range(N):
    X.append(randint(1, 100))
    Y.append(randint(1, 100))
    A.append(uniform(1, 10))
    B.append(uniform(1, 10))


# Scale coordinates
X = np.array(X, dtype=np.int32)
Y = np.array(Y, dtype=np.int32)
A = np.array(A, dtype=float)
B = np.array(B, dtype=float)

M = 3
for _ in range(N*M):
    C.append(uniform(1, 10))
C = np.array(C, dtype=float)    
Ws = np.array(C, dtype=float)


s = Solver()
s.setStrParam("Method".encode('utf-8'), "Approx".encode('utf-8'));
s.setStrParam("Model".encode('utf-8'), "mincostflow".encode('utf-8'));
s.setStrParam("Algorithm".encode('utf-8'), "colgen".encode('utf-8'));


start = perf_counter()
print("approx: d(a,b) =", s.compareApprox(N, X, Y, A, B, 3), "- runtime:",
      s.runtime(),
      perf_counter() - start)


start = perf_counter()
print("approx: d(a,b) =", s.compareApprox2(N, M, X, Y, A, Ws, 3), "- runtime:",
      s.runtime(),
      perf_counter() - start)