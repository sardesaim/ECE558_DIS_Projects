function [ResampledImage] = downscale(InputImage, ScalingFactor)
%IMRESAMPLE Resample image according to the given input 
%   Resize the given image according to the given scaling factor, implement
%   nearest neighbor interpolation while upsampling to sample the images. 

scale = [ScalingFactor, ScalingFactor];
oldSize = size(InputImage);
newSize = max(floor(scale.*oldSize(1:2)),1); %to avoid 0 index error 
% nearest neighbor interpolation.
% calculate the new row and column indices for assignment of pixels
rowIndices = min(round(((1:newSize(1))-0.5)./scale(1)+0.5), oldSize(1));
colIndices = min(round(((1:newSize(2))-0.5)./scale(2)+0.5), oldSize(2));
ResampledImage = InputImage(rowIndices, colIndices,:);
end

