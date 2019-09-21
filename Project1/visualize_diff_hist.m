function [] = visualize_diff_hist(diff1, diff2)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    subplot(2,2,1);
    imshow(diff1);
    subplot(2,2,2);
    imhist(diff1);
    subplot(2,2,3);
    imshow(diff2);
    subplot(2,2,4);
    imhist(diff2);
end

