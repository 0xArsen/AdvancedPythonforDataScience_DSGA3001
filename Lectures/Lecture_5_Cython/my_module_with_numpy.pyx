import numpy as np

def cfunc_with_numpy(int n):
    A = np.zeros((n,n))
    E = np.eye(n,dtype=int)
    cdef int i
    for i in range(n):
        A += A+E*i
    return A
