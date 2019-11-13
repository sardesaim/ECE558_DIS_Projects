function [ResampledImage] = upscale(InputImage,newSize)
%UPSCALE used to upscale image to selected size
%   newSize taken as input to avoid mismatch of dimensions while moving
%   through the pyramid. 
oldSize = size(InputImage);
scale = newSize./oldSize;

% nearest neighbor interpolation.
% calculate the new row and column indices for assignment of pixels
%subtract -0.5 to consider center of pixel. Add 0.5 to negate subtraction
%min function used to avoid any overflows 
rowIndices = min(round(((1:newSize(1))-0.5)./scale(1)+0.5), oldSize(1));
colIndices = min(round(((1:newSize(2))-0.5)./scale(2)+0.5), oldSize(2));
%assignment based on the newly calculated indices 
ResampledImage = InputImage(rowIndices, colIndices,:);
end

