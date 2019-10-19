%% Problem 2 2D fft
% Author - mmsardes Campus ID 200320514;
% Inputs - image. 
% Outputs - Spectrum and Phase visualization, recovered image from fft of
% the original image
% The problem is to use 1d fft to get a 2d fft of an image. Visualize the
% spectrum 
%% 
clc; clear all; close all;
img = imread('wolves.png'); %read image - Results for wolves.png are saved in the folder
img = rgb2gray(img); %convert to grayscale
img = im2double(img); %convert to double precision
[r,c] = size(img); %take the size of the image

fftImg = dft2(img); %take fft using the dft2 function - (2d fft using 1d fft)
fftsImg = fftshift(fftImg); %shift fft to get centered fft for visualization purposes
%spectrum is root of sum of squares of real and imaginary parts of fft 
spec = sqrt(real(fftsImg).^2+imag(fftsImg).^2); 
% Apply log transformation for better visualization
spec = log(1+abs(spec));
% Normalize to 0-255 again to display using imshow 
spec = uint8(floor((spec-min(spec(:))).*255./(max(spec(:))-min(spec(:)))));
% Phase is arctan(imaginary part of fft/real part of fft)
phase = atan(imag(fftsImg)/real(fftsImg));
% Apply log transformation for better visualization
phase = log(1+abs(phase));
% Normalize to 0-255 again to display using imshow 
phase = uint8(floor((phase-min(phase(:))).*255./(max(phase(:))-min(phase(:)))));

%% Doing the same process using builtin fft function to verify results. 
fft2Img = fft2(img);
fft2sImg = fftshift(fft2Img);
spec1 = sqrt(real(fft2sImg).^2+imag(fft2sImg).^2);
spec1 = log(1+abs(spec1));
spec1 = uint8(round((spec1-min(spec1(:))).*255./(max(spec1(:))-min(spec1(:)))));
phase1 = atan(imag(fft2sImg)/real(fft2sImg));
phase1 = log(1+abs(phase1));
phase1 = uint8(round((phase1-min(phase1(:))).*255./(max(phase1(:))-min(phase1(:)))));
%% part 2b Recover original image from the fft obtained using dft2 function

%recover original image by operating dft on conjugate of the fft and then
%taking the conjugate of result and dividing by MN 
recov = (1/numel(fftImg)).*real(conj(dft2(conj(fftImg))));
%scale recovered image from 0 -255 to get image compared to original image
recov = uint8(floor((recov-min(recov(:))).*255./(max(recov(:))-min(recov(:)))));
%scale original image from 0 -255 to get it in the original form (It was
%scaled from 0-1 for fft calculation purposes
img = uint8(floor((img-min(img(:))).*255./(max(img(:))-min(img(:)))));
% Get difference image
d = img - recov;

%% plotting the results 

%plot spectra and phase using dft2 and fft2(built-in) functions
subplot(2,2,1)
imshow(spec)
title('Spectrum using dft2');
subplot(2,2,2)
imshow(phase)
title('Phase using dft2');
subplot(2,2,3) 
imshow(spec1)
title('Spectrum using fft2');
subplot(2,2,4)
imshow(phase1)
title('Phase using fft2');
%plot original image, recovered image and difference image
figure;
subplot(3,1,1);
imshow(img);
title('Original Image');
subplot(3,1,2);
imshow(recov);
title('Recovered Image');
subplot(3,1,3);
imshow(d);
title('Difference Image');