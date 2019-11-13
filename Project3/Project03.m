%Image Blending
clc; clear all; close all;  
tic
bg = im2double(imread('hand.jpg'));
fg = im2double(imread('eye.jpg'));
% fg = rgb2gray(fg);
% bg = rgb2gray(bg);
% fg = upscale(fg, size(bg));
fg1 = fg;
% imshow(bg);
[fg1,bw_mask] = createMask(fg1, bg, 3);
blendedImg(:,:,1) = blendPyramid(fg1(:,:,1),bg(:,:,1),bw_mask);
blendedImg(:,:,2) = blendPyramid(fg1(:,:,2),bg(:,:,2),bw_mask);
blendedImg(:,:,3) = blendPyramid(fg1(:,:,3),bg(:,:,3),bw_mask);
blendedImg = ScaleRGBValues(blendedImg);
figure; imshow(blendedImg);
% [gPyr, lPyr] = ComputePyr(img1, 8);
toc
