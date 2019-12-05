clc; close all;
tic;
image = imread('TestImages4Project\butterfly.jpg');
grayImg = im2double(rgb2gray(image));
sigma=1.2; %1.4 dinesh
k=sqrt(2);
octaves = 3;
intervals = 8;
max_x = [];
max_y = [];
max_r = [];
possible_maximas = [];
l = cell(octaves,1);
fsize = cell(octaves,1);
sig = cell(octaves,1);
sigma_op = sigma;
sigma_oct = sigma;
for oct = 1:octaves
    [rows,columns]=size(grayImg);
    for i=1:intervals+1 
        fsize{oct}(i) = 2*ceil(3*sigma_op)+1;
        sig{oct}(i) = sigma_op;
        filter = (sigma_op.^2)*log_kernel((2*ceil(3*sigma_op)+1),sigma_op);
%         l{oct}(:,:,i) = convolve(grayImg, filter, 1);
        l{oct}(:,:,i) = convfreq(grayImg, filter);
        l{oct}(:,:,i) = l{oct}(:,:,i).^2;
        figure;
        imshow(l{oct}(:,:,i));
        sigma_op=sigma_oct*(k^i);
    end
    sigma_oct = sigma*(2^oct-1);
    grayImg = downscale(convfreq(grayImg, genKernel('gaussian', (2*ceil(3*sigma_oct)+1), sigma_oct)), 0.5);
    grayImg = upscale(grayImg, [rows columns]);
    [max_x, max_y, max_r] = nms(l, fsize, sig, oct, intervals, max_x, max_y, max_r);
end
figure;
imshow(rgb2gray(image)); hold on;
for i = 1:length(max_x)
% drawcircle('Center', [max_x(i), max_y(i)], 'Radius', max_r(i), 'Color' , [1 0 0], 'Selected', false);
    circs(max_y(i), max_x(i), max_r(i));
end  
toc
