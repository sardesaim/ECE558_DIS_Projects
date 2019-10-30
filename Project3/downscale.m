function [ResampledImage] = downscale(InputImage, ScalingFactor)
%IMRESAMPLE Resample image according to the given input 
%   Resize the given image according to the given scaling factor, implement
%   nearest neighbor interpolation while upsampling to sample the images. 
% if ScalingFactor<1
%     ResampledImage = InputImage(1:(1/ScalingFactor):end, 1:(1/ScalingFactor):end);
% end
scale = [ScalingFactor, ScalingFactor];
oldSize = size(InputImage);
newSize = max(floor(scale.*oldSize(1:2)),1);
% RowPos = ceil((1:newSize(1))./scale(1));
% ColPos = ceil((1:newSize(2))./scale(2));
% ResampledImage = InputImage(:,RowPos);
% ResampledImage = ResampledImage(ColPos,:);

rowIndices = min(round(((1:newSize(1))-0.5)./scale(1)+0.5), oldSize(1));
colIndices = min(round(((1:newSize(2))-0.5)./scale(2)+0.5), oldSize(2));
ResampledImage = InputImage(rowIndices, colIndices);
end

