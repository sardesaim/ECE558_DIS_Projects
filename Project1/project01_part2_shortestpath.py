# -*- coding: utf-8 -*-
"""
Created on Sun Sep 22 19:35:17 2019

@author: sarde
"""
from collections import deque
#from skimage.color import rgb2gray
import numpy as np
import matplotlib.image as mpimg
import time

def bfs(graph, start, end):
    """
    BFS is used as weights for all the edges are 1, in any case of neighborhood
    or connectivity. 
    As we only need 1 shortest path between the start and end point, BFS algorithm
    can be faster and space saving than say Dijkstra's algorithm which calculates 
    shortest distance to every other node.
    """
    if start == end:
        return [start]  #return start if start and end node are the same
    visited = {start}   #add start to visited set
    queue = deque([(start, [])])    #queue implementation using dequeue from collections
                                    #start element and empty path is added to the queue
    while queue:    #loop until queue is empty
        current, path = queue.popleft() #pop current element and path from the queue
        visited.add(current)    #add current element to visited
        for neighbor in graph[current]: #loop through all neighbors of current element
            if neighbor == end:
                return path + [current, neighbor]   #if neighbor is equal to end, return the path as path+[current,neighbor]
            if neighbor in visited:
                continue    #If neighbor is visited, continue to next iteration                                 
            queue.append((neighbor, path + [current]))  #append neighbor, new path to the queue. 
            visited.add(neighbor)    #add neighbor to visited
    return None  # no path found.

if __name__ == '__main__':
    img = np.array([[3,1,2,1],[2,2,0,2],[1,2,1,1],[1,0,1,2]])   #example 1. for part a and b. 
#    img = np.array([[2,3,1,0,1],[0,2,5,1,2],[0,4,1,3,1],[0,1,2,3,1]])
#    img = mpimg.imread('lena.jpg')  #imread image for part c. 
    #img = rgb2gray(img)
    img1 = img[:,:]
    v = [0,1] #V_set for example 1. part a and b
#    v = {img1[i][j] for i in range(img1.shape[0]) for j in range(img1.shape[1]) if i%2==0 and j%2==0} #create random predefined v set 
    ht,wd = img1.shape    #get height and width of the image
#    img_graph = np.zeros((ht,wd),dtype='uint8') #debug
    neighbor_type = input('Choose path \n1. 4 path\n2. 8 path\n3. m path\n')   #take users input for connectivity 
    promptp = 'Set start point as (x,y) within the image dimensions of {} x {} - 0 based indexing\t'.format(ht,wd)
    promptq = 'Set end point as (x,y) within the image dimensions of {} x {} - 0 based indexing\t'.format(ht,wd)
    px = qx = py = qy = -1  #initialize start and end points 
    while px<0 or qx<0 or py<0 or qy<0 or px>ht or qx>ht or qy>wd or py>wd: #handle start, end pixels out of bounds
        px, py = tuple(int(x.strip()) for x in  input(promptp).split(','))  #get user input for px, py
        qx, qy = tuple(int(x.strip()) for x in  input(promptq).split(','))  #get user input for px, py
    start_time = time.time()    #start to record time
    graph = {}  #initialize adjacency list as a dictionary 
    #creation of adjacency list
    img_ex = np.full((ht+2,wd+2), -1) #extended image to handle edge pixel cases
    img_ex[1:-1,1:-1] = img1   #copy original image in the center of the extended image.
    for i in range(ht): 
        for j in range(wd): #traverse through original image
            if img1[i][j] in v: #if the pixels are in set v, add keys to dictionary 
                graph.update({(i,j):set([])})   
                try:
                    if neighbor_type == '4':    #if neighbor type 4
                        adjacents = {(-1,0),(0,1),(1,0),(0,-1)} #4 neighbors defined by the following list
                        for n1, n2 in adjacents:
                            if((i+n1!=i or j+n2!=j) and (0<=i+n1<=ht) \
                               and (0<=i+n2<=wd) and (i+n1!=i+n2) and (i+n1!=-(i+n2))\
                               and img_ex[i+1+n1][j+1+n2] in v):    #all conditions to check validity of 4 neighbors
                                graph[(i,j)].add((i+n1,j+n2))            
                    if neighbor_type == '8':    #if 8 neighbors specified by the user 
                                for n1 in range(-1,2): 
                                    for n2 in range(-1, 2):
                                        if((i+n1!=i or j+n2!=j) and (0<=i+n1<=ht) \
                                           and (0<=i+n2<=wd) and img_ex[i+1+n1][j+1+n2] in v):
                                            graph[(i,j)].add((i+n1,j+n2))   #all conditions to check validity 
                    if neighbor_type == 'm':    #if neighbor type - m neighbors 
                        adjacents = {(-1,0),(0,1),(1,0),(0,-1)}
                        for n1, n2 in adjacents:
                            if((i+n1!=i or j+n2!=j) and (0<=i+n1<=ht) \
                               and (0<=i+n2<=wd) and (i+n1!=i+n2) and (i+n1!=-(i+n2))\
                               and img_ex[i+1+n1][j+1+n2] in v):
                                graph[(i,j)].add((i+n1,j+n2))  
                            elif((img_ex[i+1+n1][j+1+n2] not in v)):
                                adjacents={(-1,-1),(-1,1),(1,-1),(1,1)}
                                for d1, d2 in adjacents:
                                    if((i+d1!=i or j+d2!=j) and (0<=i+d1<=ht) \
                                       and (0<=i+d2<=wd) and (i+n1!=i+d2) and (i+d1!=-(i+d2))\
                                       and img_ex[i+1+d1][j+1+d2] in v):
                                        graph[(i,j)].add((i+d1,j+d2))  
                except IndexError:
                    continue              

    path = bfs(graph, (px,py), (qx, qy) ) #use bfs algorithm for searching from p to q
    if path:
        print(path,'\nLength of path is ', len(path)-1)  #return path and length of the path
    else:
        print('no path found')        
    print("--- %s seconds ---" % (time.time() - start_time))