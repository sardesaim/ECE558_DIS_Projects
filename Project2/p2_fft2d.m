% Problem 2 2D fft
clc; clear all; close all;
img = imread('lena.png');
img = rgb2gray(img);
img = im2double(img);
[r,c] = size(img);
fftImg = fft(fft(img, [],1), [], 2);
fft2Img = fft2(img);
subplot(211) 
imshow(fftImg)
subplot(212)
imshow(fft2Img)
isequal(fftImg, fft2Img)
