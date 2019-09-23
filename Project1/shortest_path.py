# -*- coding: utf-8 -*-
import numpy as np 
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from skimage.color import rgb2gray
import time

start_time = time.time()

#wolves = mpimg.imread('wolves.png')
#wolves = rgb2gray(wolves)
#plt.figure(figsize=[12,12])
##plt.imshow(wolves, cmap='gray')
#ht, wd = wolves.shape
#print('Predefined set V: ', v)
#print('Dimension of image is', wolves.shape)
#
#path_type = input('Enter path type to trace a. 4 path b. 8 path c. m path ');
#
#graph = np.zeros((ht,wd), dtype='uint8')
#for i in range(ht):
#    for j in range(wd):
#        if(wolves[i][j] in v):
#            graph[i][j]=1
#            
#        if path_type == '4':
#            for              
#        elif path_type == '8':
#            pass
#        else:
#            pass

        #print('Please enter coordinates of pixel p and q within the image size')
#px,py = tuple(int(x.strip()) for x in input('Enter coordinates of p as x,y ').split(','))
#qx,py = tuple(int(x.strip()) for x in input('Enter coordinates of q as x,y ').split(','))


#currx, curry = px, py
#path_list = []
        

v = np.array([0,1])
wolves = np.array([[3,1,2,1],[2,2,0,2],[1,2,1,1],[1,0,1,2]])
ht,wd = wolves.shape
img_graph = np.zeros((ht,wd),dtype='uint8')
for i in range(ht):
    for j in range(wd):
        if(wolves[i][j] in v):
            img_graph[i][j]=1

print(img_graph)
px,py = (0,3)
qx,qy = (3,0)

vertices = np.count_nonzero(img_graph)
import sys 
  
class Graph(): 
  
    def __init__(self, vertices): 
        self.V = vertices 
        self.graph = [[0 for column in range(vertices)]  
                    for row in range(vertices)] 
  
    def printSolution(self, dist): 
        print("Vertex \tDistance from Source")
        for node in range(self.V): 
            print(node, "\t", dist[node]) 
  
    # A utility function to find the vertex with  
    # minimum distance value, from the set of vertices  
    # not yet included in shortest path tree 
    def minDistance(self, dist, sptSet):  
    # Initilaize minimum distance for next node 
        min = sys.maxsize 
  
        # Search not nearest vertex not in the  
        # shortest path tree 
        for v in range(self.V): 
            if dist[v] < min and sptSet[v] == False: 
                min = dist[v] 
                min_index = v 
        return min_index 
  
    # Funtion that implements Dijkstra's single source  
    # shortest path algorithm for a graph represented  
    # using adjacency matrix representation 
    def dijkstra(self, src): 
  
        dist = [sys.maxsize] * self.V 
        dist[src] = 0
        sptSet = [False] * self.V 
  
        for cout in range(self.V): 
  
            # Pick the minimum distance vertex from  
            # the set of vertices not yet processed.  
            # u is always equal to src in first iteration 
            u = self.minDistance(dist, sptSet) 
  
            # Put the minimum distance vertex in the  
            # shotest path tree 
            sptSet[u] = True
  
            # Update dist value of the adjacent vertices  
            # of the picked vertex only if the current  
            # distance is greater than new distance and 
            # the vertex in not in the shotest path tree 
            for v in range(self.V): 
                if self.graph[u][v] > 0 and sptSet[v] == False and dist[v] > dist[u] + self.graph[u][v]: 
                        dist[v] = dist[u] + self.graph[u][v] 
  
        self.printSolution(dist) 
  
# Driver program 
g = Graph(9) 
g.graph = [[0, 0, 0, 0, 0, 0, 0, 0], 
        [0, 0, 0, 0, 0, 0, 0, 0, 0], 
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        ]; 
  
g.dijkstra(0);
    
print("--- %s seconds ---" % (time.time() - start_time))