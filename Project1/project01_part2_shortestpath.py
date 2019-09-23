# -*- coding: utf-8 -*-
"""
Created on Sun Sep 22 19:35:17 2019

@author: sarde
"""
from collections import deque
import numpy as np
import matplotlib.image as mpimg
#from skimage.color import rgb2gray

import time

start_time = time.time()

def bfs2(graph, start, end):
    """
    finds a shortest path in undirected `graph` between `start` and `end`. 
    If no path is found, returns `None`
    """
    if start == end:
        return [start]
    visited = {start}
    queue = deque([(start, [])])

    while queue:
        current, path = queue.popleft()
        visited.add(current)
        for neighbor in graph[current]:
            if neighbor == end:
                return path + [current, neighbor]
            if neighbor in visited:
                continue
            queue.append((neighbor, path + [current]))
            visited.add(neighbor)   
    return None  # no path found. not strictly needed


px,py = (0,11)
qx,qy = (512,512)


if __name__ == '__main__':
    wolves = np.array([[3,1,2,1],[2,2,0,2],[1,2,1,1],[1,0,1,2]])
    wolves = mpimg.imread('lena.jpg')
    #wolves = rgb2gray(wolves)
    wolves1 = wolves[:,:,1]
    #v = [1,2]
    v = {wolves1[i][j] for i in range(wolves1.shape[0]) for j in range(wolves1.shape[1]) if i%2==0 and j%2==0}
    ht,wd = wolves1.shape
    img_graph = np.zeros((ht,wd),dtype='uint8')
    neighbor_type = input('Choose path \n1. 4 path\n2. 8 path\n')
    graph = {}
    #graph = defaultdict(set)
    wp = np.full((ht+2,wd+2), -1)
    wp[1:-1,1:-1] = wolves1
    for i in range(ht):
        for j in range(wd):
            if wolves1[i][j] in v:
                graph.update({(i,j):set([])})
                try:
                    if neighbor_type == '4':
                        adjacents = {(-1,0),(0,1),(1,0),(0,-1)}
                        for n1, n2 in adjacents:
                            if((i+n1!=i or j+n2!=j) and (0<=i+n1<=ht) \
                               and (0<=i+n2<=wd) and (i+n1!=i+n2) and (i+n1!=-(i+n2))\
                               and wp[i+1+n1][j+1+n2] in v):
                                graph[(i,j)].add((i+n1,j+n2))            
                    if neighbor_type == '8':
                                for n1 in range(-1,2):
                                    for n2 in range(-1, 2):
                                        if((i+n1!=i or j+n2!=j) and (0<=i+n1<=ht) \
                                           and (0<=i+n2<=wd) and wp[i+1+n1][j+1+n2] in v):
                                            graph[(i,j)].add((i+n1,j+n2))  
                    if neighbor_type == 'm':
                        adjacents = {(-1,0),(0,1),(1,0),(0,-1)}
                        for n1, n2 in adjacents:
                            if((i+n1!=i or j+n2!=j) and (0<=i+n1<=ht) \
                               and (0<=i+n2<=wd) and (i+n1!=i+n2) and (i+n1!=-(i+n2))\
                               and wp[i+1+n1][j+1+n2] in v):
                                graph[(i,j)].add((i+n1,j+n2))  
                except IndexError:
                    continue              

    path = bfs2(graph, (px,py), (qx, qy) )
    if path:
        print(path)
        print('Length of path is ', len(path)-1)
    else:
        print('no path found')        
    print("--- %s seconds ---" % (time.time() - start_time))