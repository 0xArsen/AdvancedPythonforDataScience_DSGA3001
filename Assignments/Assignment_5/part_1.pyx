import numpy as np
import scipy.sparse as ss
import scipy.sparse.linalg as ssl
import matplotlib.pyplot as plt
import cProfile

def set_boundary_values(n):
    b = np.zeros((4,n))
    b[2]=0
    b[3]=0
    return(b)

def insert_grid_values(i, j, G):
    G[i,j] = -4
    G[i+1,j] = 1
    G[i-1,j] = 1
    G[i,j+1] = 1
    G[i,j-1] = 1
    
def form_point_vector(G,n):
    G = G[1:n-1,1:n-1]
    G = np.reshape(G, (1,(n-2)*(n-2)))
    return G
    
def form_y_point(G, n):
    point_array = np.zeros((2,n))
    point_array[0,:] = G[:,0]
    point_array[1,:] = G[:,n-1]
    return np.sum(point_array)
    
def build_matrix_and_vector(n,b):
    M = np.zeros(((n-2)*(n-2),(n-2)*(n-2)))
    M_insert_index = 0
    y = []
    for i in range(1, n-1):
        for j in range(1, n-1):
            G = build_grid(n)
            set_boundary_grid(G,b)
            insert_grid_values(i, j, G)
            point_sum = form_y_point(G, n)
            y.append(-point_sum)
            G = form_point_vector(G,n)
            M[M_insert_index,:] = G
            M_insert_index += 1

    #return(M,y)  # not sparce
    return(ss.csr_matrix(M),y)

def build_grid(n):
    '''defines the grid'''
    G = np.zeros((n,n))
    return(G)

def set_boundary_grid(G,b):
    '''set the boundary values: b[0]=botton, b[1]=top, b[2]=left, b[3]=right'''

    G[0,:]=b[0]
    G[-1,:]=b[1]
    G[:,0]=b[2]
    G[:,-1]=b[3]
    
def solve_heat_equation(n):
    b = set_boundary_values(n)
    M,y = build_matrix_and_vector(n,b)
    #f = np.linalg.solve(M,y)        # not sparse
    f = ssl.spsolve(M,y)
    G = np.zeros((n,n)) 
    G[1:n-1,1:n-1]=f.reshape(n-2,n-2) 

    return(G)


n = 100
cp = cProfile.Profile()
cp.enable()

G = solve_heat_equation(n)

cp.disable()
cp.print_stats()

img=plt.imshow(G)
img.set_cmap('rainbow')
plt.axis('off')
plt.show()