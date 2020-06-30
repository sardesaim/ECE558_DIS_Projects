clc; close all;
%-------------------------------------------------------------------------%
% LAPLACIAN BLOB DETECTION
% Authors - Mayuresh Sardesai, Dinesh Bhosale, Omkar Mujumdar
% 1. Generate Laplacian Scale space using the generate log filter
% 2. Perform non max suppression 
% 3. Plot the resulting circles at their corresponding scales
%-------------------------------------------------------------------------%
tic;
image = imread('TestImages4Project\simba.jpg');
grayImg = im2double(rgb2gray(image));
sigma=1.4; %initial sigma 
k=sqrt(2);  %change sigma for every iteration by a factor of sqrt(2)
octaves = 1;    %set number of octaves
% # Scales for images
% 1. Butterfly - 10
% 2. Einstein - 10
% 3. Fishes - 10
% 4. Sunflowers - 10
% 5. Lena - 10
% 6. Omkar - 10
% 7. Eye - 10
% 8. Simba - 10
intervals = 10; %set number of itervals in a one scale
%Threshold for images 
% 1. Butterfly - 0.02
% 2. Einstein - 0.03
% 3. Fishes - 0.0175
% 4. Sunflowers - 0.0325
% 5. Lena - 0.025
% 6. Omkar - 0.025
% 7. Eye - 0.025
% 8. Simba - 0.02
thresh = 0.02;
%empty arrays for storing the coordinates and the corresponding radius
max_x = [];
max_y = [];
max_r = [];
l = cell(octaves,1);    %empty cell array to store the scale space 
fsize = cell(octaves,1);%empty cell array for storing filter sizes at each oct
sig = cell(octaves,1);  %empty cell array to store sigma values at each oct
sigma_op = sigma;       %init sigma_op - sigma at each level of scale space
sigma_oct = sigma;      %init sigma_oct - initial sigma at each octave
for oct = 1:octaves    %traverse through octaves
    [rows,columns]=size(grayImg);   %size of the grayscale image
    sigma_op = sigma_oct;   %set sigma_op as the sigma at the current octave
    for i=1:intervals+1     %traverse through the number of scales
        fsize{oct}(i) = 2*ceil(3*sigma_op)+1;   %calculate filter size 
        sig{oct}(i) = sigma_op; %store sigma_op
        %generate log filter in spatial domain based on the formula
        filter = (sigma_op.^2)*log_kernel((2*ceil(3*sigma_op)+1),sigma_op);
        l{oct}(:,: ,i) = convfreq(grayImg, filter); %get log response
        l{oct}(:,:,i) = l{oct}(:,:,i).^2;   %get squared response
%         figure;
%         imshow(l{oct}(:,:,i));
        sigma_op=sigma_op*(k);  %update sigma_op by multiplying it with k
    end
    sigma_oct = sigma*(2^oct);  %update sigma_oct
    %downscale image and smoothen with gaussian having sigma_oct
    grayImg = convfreq(downscale(grayImg,0.5), ...
        genKernel('gaussian', (2*ceil(3*sigma_oct)+1), sigma_oct));
    %resize the image back to the original size. 
    grayImg = upscale(grayImg, [rows columns]); 
    %perform non max suppression
    [max_x, max_y, max_r] = nonmaxs(l{oct}, sig{oct}, ...
        intervals, max_x, max_y, max_r, thresh);
%     [max_x, max_y, max_r] = nms(l{oct}, sig{oct}, fsize{oct}, ...
%         intervals, max_x, max_y, max_r);
end
figure;
imshow(rgb2gray(image)); hold on;   %display the image 
%plot the circles
for i = 1:length(max_x)
%     viscircles([max_y(i), max_x(i)], max_r(i));
    circs(max_x(i), max_y(i), max_r(i));
end  
toc
saveas(gcf, 'Output.png');