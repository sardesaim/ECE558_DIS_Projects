clc; close all;
img = imread('wolves.png');
img = rgb2gray(img);
box_deriv = {1/9*[1,1,1;1,1,1;1,1,1],[1,-1],[1;-1]};
prewitt = {[-1,0,1;-1,0,1;-1,0,1],[-1,-1,-1;0,0,0;1,1,1]};
sobel = {[-1,0,1;-2,0,2;-1,0,1],[1,2,1;0,0,0;-1,-2,1]};
roberts = {[0,1 ; -1,0],[1,0;0,-1]};
pad = 1;
op = conv2d(img, box_deriv{1},pad);
subplot(1,2,1)
imshow(img)
subplot(1,2,2)
imshow(op)

uimp = zeros(1024);
uimp(512, 512) = 1;
ouimp = conv2d(uimp, box_deriv{1}, pad);
figure;
subplot(1,2,1)
imshow(uimp)
subplot(1,2,2)
imshow(ouimp)