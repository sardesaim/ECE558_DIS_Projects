% project01_part 2
% shortest path between connected components 
clc; close all; 

wolves = imread('wolves.png');
wolves = rgb2gray(wolves);
predefined_v = [253, 40];
sprintf('Image Dimensions are %d x %d\n',size(wolves,1), size(wolves,2));
p = input('Enter pixel location 1 within the image\n');
q = input('Enter pixel location 2 within the image\n');