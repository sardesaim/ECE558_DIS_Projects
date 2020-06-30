% Project 2 Question 1a and 1b
% Author - mmsardes Campus ID 200320514;
% Inputs - image, kernel, padding type, 
% Output - covolved image - using kernels given for spatial filtering
%% Convolution. Spatial filtering in images
clc; clear all; close all;
img = im2double(imread('lena.png'));
% img = rgb2gray(img); 
img1 = im2double(imread('wolves.png'));
img1 = rgb2gray(img1); %considering a grayscale conversion for wolves.png
%defining all the filters 
box_deriv = {1/9*[1,1,1;1,1,1;1,1,1],[1,-1],[1;-1]};
prewitt = {[-1,0,1;-1,0,1;-1,0,1],[-1,-1,-1;0,0,0;1,1,1]};
sobel = {[-1,0,1;-2,0,2;-1,0,1],[1,2,1;0,0,0;-1,-2,-1]};
roberts = {[0,1 ; -1,0],[1,0;0,-1]};
%creating a cell of all kernels
kernels = horzcat(box_deriv,prewitt, sobel, roberts);
%setting prompts for selecting kernel and padding type 
prompt = 'Set padding type\n1. Zero Padding\n2. Copy Edge\n3. Wrap around\n4. Reflect across edge\n';
prompt2 = ['Set Kernel type\n1. Box Filter 2. Derivative horizontal'...
    ' 3. Derivative vertical\n4. Prewitt horizontal 5. Prewitt vertical\n'...
    '6. Sobel horizontal 7. Sobel vertical\n8. Roberts Horizontal'...
    ' 9 Roberts Vertical\n'];
%setting up cells of kernel and padding type for saving output with
%suitable filename
padType = {'Zero', 'Copy Edge', 'Wrap Around', 'Reflect'};
kernType = {'Box', 'DerivHorizontal', 'DerivVertical', 'PrewittHorizontal',...
    'PrewittVertical','SobelHorizontal','SobelVertical', 'RobertsHorizontal',...
    'RobertsVertical'};

kern = input(prompt2); %take input of kernel from user
pad = input(prompt); %take padding type from user
if size(img,3)==3 %if the image is a color image, convolve channels separately
    op(:,:,1) = conv2d(img(:,:,1), kernels{kern},pad);
    op(:,:,2) = conv2d(img(:,:,2), kernels{kern},pad);
    op(:,:,3) = conv2d(img(:,:,3), kernels{kern},pad);
else
    op = conv2d(img, kernels{kern},pad); %else convolve the image directly 
end
ops = (op-min(op(:)))./(max(op(:))-min(op(:))); %scale image to visualize negative values better
%the process is repeated to check wolves.png as a grayscale image. 
if size(img1,3)==3 
    op1(:,:,1) = conv2d(img1(:,:,1), kernels{kern},pad);
    op1(:,:,2) = conv2d(img1(:,:,2), kernels{kern},pad);
    op1(:,:,3) = conv2d(img1(:,:,3), kernels{kern},pad);
else
    op1 = conv2d(img1, kernels{kern},pad);
end
ops1 = (op1-min(op1(:)))./(max(op1(:))-min(op1(:)));
%create a figure to display the results 
figure('units', 'normalized', 'outerposition', [0 0 1 1]); 
subplot(2,3,1); 
imshow(img);
title('lena.png');
subplot(2,3,2);
imshow(op);
title('o/p (Negative values Clipped)');
subplot(2,3,3)
imshow(ops);
title('o/p Scaled');
subplot(2,3,4); 
imshow(img1);
title('wolves.png');
subplot(2,3,5);
imshow(op1);
title('o/p (Negative values Clipped)');
subplot(2,3,6)
imshow(ops1);
title('o/p Scaled');
%save the results to a png file 
fileName = horzcat('Part1a',kernType{kern},padType{pad},'.png');
print(gcf, fileName,'-dpng', '-r300');
%% part 2 
% unit impulse function  
%the unit impulse is defined with a matrix of zeros with a one in the
%center as shown below 
uimp = zeros(1024);
uimp(512, 512) = 1;
ouimp = conv2d(uimp, kernels{7}, pad);
ouimp = ouimp-min(ouimp(:))./(max(ouimp(:))-min(ouimp(:)));
%show the results in the figure
figure;
subplot(1,2,1)
imshow(uimp)
subplot(1,2,2)
imshow(ouimp)
