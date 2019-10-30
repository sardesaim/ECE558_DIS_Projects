function [ResampledImage] = upscale(InputImage,newSize)
%UPSCALE Summary of this function goes here
%   Detailed explanation goes here
oldSize = size(InputImage);
scale = newSize./oldSize;
rowIndices = min(round(((1:newSize(1))-0.5)./scale(1)+0.5), oldSize(1));
colIndices = min(round(((1:newSize(2))-0.5)./scale(2)+0.5), oldSize(2));
ResampledImage = InputImage(rowIndices, colIndices);
end

