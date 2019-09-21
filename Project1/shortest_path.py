# -*- coding: utf-8 -*-
import numpy as np 
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from skimage.color import rgb2gray
import time

start_time = time.time()

wolves = mpimg.imread('wolves.png')
wolves = rgb2gray(wolves)
plt.figure(figsize=[12,12])
plt.imshow(wolves, cmap='gray')

v = np.array([40, 253])
print('Predefined set V: ', v)
print('Dimension of image is', wolves.shape)
print('Please enter coordinates of pixel p and q within the image size')
px,py = tuple(int(x.strip()) for x in input('Enter coordinates of p as x,y ').split(','))
qx,py = tuple(int(x.strip()) for x in input('Enter coordinates of q as x,y ').split(','))
path_type = input('Enter path type to trace a. 4 path b. 8 path c. m path ');

path_list = []

if path_type == '4':
    if px+1 or px-1 or py+1 or py-1 in v:
        path_list.append((px+1,py))
elif path_type == '8':
    pass
else:
    pass
print("--- %s seconds ---" % (time.time() - start_time))