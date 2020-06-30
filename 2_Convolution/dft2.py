# -*- coding: utf-8 -*-
"""
Created on Fri Oct 25 16:32:23 2019

@author: sarde
"""

# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import numpy as np
import matplotlib.pyplot as plt 
import cv2 as cv

def rgb2gray(rgb):
    return np.dot(rgb[...,:3], [0.2989, 0.5870, 0.1140])

def dft2(img):
    r,c = img.shape  
    ffti = np.zeros(img.shape, dtype = np.complex64)
    for i in range(r):
        ffti[i,:] = np.fft.fft(img[i,:])
    for i in range(c):
        ffti[:,i] = np.fft.fft(ffti[:,i])
    return ffti

img = plt.imread('Lena.png')
gray = rgb2gray(img)
plt.imshow(gray,cmap=plt.get_cmap('gray'), vmin=0, vmax=1)
ffti = dft2(gray)
fftsi = np.fft.fftshift(ffti)
spec = 1+np.log(abs(fftsi))
phase = 1+np.log(atan(fftsi))

spec = (spec-np.amin(spec))/(np.amax(spec)-np.amin(spec))
phase = (phase-np.amin(phase)/(np.amax(phase)-np.amin(phase)))
