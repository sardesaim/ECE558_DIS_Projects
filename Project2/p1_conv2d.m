% Project 2 Question 1a and 1b
% Convolution. Spatial filtering in images
clc; clear all; close all;
img = imread('lena.png');
img = im2double(rgb2gray(img));
box_deriv = {1/9*[1,1,1;1,1,1;1,1,1],[1,-1],[1;-1]};
prewitt = {[-1,0,1;-1,0,1;-1,0,1],[-1,-1,-1;0,0,0;1,1,1]};
sobel = {[-1,0,1;-2,0,2;-1,0,1],[1,2,1;0,0,0;-1,-2,1]};
roberts = {[0,1 ; -1,0],[1,0;0,-1]};
prompt = 'Set padding type\n1. Zero Padding\n2. Copy Edge\n3. Wrap around\n4. Reflect across edge\n';
pad = input(prompt);
if size(img,3)==3 
    op(:,:,1) = conv2d(img(:,:,1), sobel{1},pad);
    op(:,:,2) = conv2d(img(:,:,2), sobel{1},pad);
    op(:,:,3) = conv2d(img(:,:,3), sobel{1},pad);
else
    op = conv2d(img, roberts{2},pad);
end
% opi = op-min(op(:)).*(1/(max(op(:))-min(op(:))));
subplot(1,2,1)
imshow(img)
subplot(1,2,2)
imshow(op)

% part 2 
% unit impulse function 
uimp = zeros(1024);
uimp(512, 512) = 1;
ouimp = conv2d(uimp, box_deriv{1}, pad);
figure;
subplot(1,2,1)
imshow(uimp)
subplot(1,2,2)
imshow(ouimp)