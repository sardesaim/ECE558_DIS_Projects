function [logScaleSpace] = scaleSpace(img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    t = [1:0.2:2];
    sigma = exp(t);
    kernSize = ceil(3*sigma)*2+1;
    disp(kernSize);
    logScaleSpace = zeros([size(img,1:2), length(t)]);
    for i = 1:length(sigma)
        figure;
        g = (sigma(i).^2).*genKernel(sigma(i), kernSize(i), 'log');
        logScaleSpace(:,:,i) = convolve(img, g, 1);
        imshow(logScaleSpace(:,:,i)); 
    end
end

