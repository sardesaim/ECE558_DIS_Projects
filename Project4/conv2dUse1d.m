function [opImg] = conv2dUse1d(img, kern)
%CONV2DUSE1D Summary of this function goes here
%   Detailed explanation goes here
    [~,hc, rv] = isfilterseparable(kern);
    [r ,c] = size(img);
    img1 = vertcat(horzcat(img, repmat(zeros(length(hc)-1), r)), repmat(zeros(length(rv)-1), c));
end

