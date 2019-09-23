%ECE558 - Digital Imaging Systems 
%Project 1. Question 1. 
%Visualising the smoothness prior of an image. 
%Mayuresh Sardesai 
%200320514

clc; close all; 
tic; %start timer to record runtime
wolves = imread('Hunt.jpg'); %read image
wolves = im2double(wolves); %convert to double to avoid clipping during subtraction
prompt1 = 'Which color space you want to consider\na. RGB\nb. Grayscale\nc. HSV\nd. La*b*\n';
color_space = input(prompt1, 's'); %ask the user to select color space
prompt2 = ['Which neighbor type you want to consider'...
    '\na. 4 - Neighbors -(x,y) and (x+1,y) , (x,y) and (x,y+1)\n'...
    'b. 8/d - Neighbors (x,y) and (x+1, y+1) ,(x,y) and (x-1, y-1)\n'];
neighbor_type = input(prompt2); %ask the user to select the neighbors
[diff1, diff2] = calculate_diff(wolves, color_space, neighbor_type); %compute squared difference between the neighbors
figure;
visualize_diff_hist(diff1, diff2); %visualize the difference using the histogram and the subtracted image. 
toc;