%Face Swap 

clc; clear all; close all; 

bg = imread('lena.png');
fg = imread('rohit.jpeg');
fg = rgb2gray(fg);
bg = rgb2gray(bg);
fg = upscale(fg, size(bg));
fg1 = fg;
bw_mask = createMask(fg1, bg);
blendedImg = blendPyramid(fg1,bg,bw_mask);
figure; imshow(blendedImg);
% [gPyr, lPyr] = ComputePyr(img1, 8);

