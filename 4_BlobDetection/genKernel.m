function [kernel] = genKernel(type,size,sigm)
%GENKERNEL Summary of this function goes here
%   Detailed explanation goes here
    %generate gaussian kernel 
    if strcmp(type,'gaussian')
        kernel = fspecial('gaussian', size ,sigm);
    elseif strcmp(type ,'log')
        kernel = fspecial('log', size,sigm);
    end
end

