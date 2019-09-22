function [] = visualize_diff_hist(diff1, diff2)
%visualize_diff_hist Summary of this function goes here
%   Detailed explanation goes here
    subplot(2,2,1); 
    imshow(diff1);  %show difference image for first pair of neighbors
    title('Difference Image for first pair of neighbors');
    subplot(2,2,2); 
    imhist(diff1);  %show difference histogram for the first pair of neighbors
    title('Difference Histogram for first pair of neighbors');
    subplot(2,2,3); 
    imshow(diff2);  %show difference image for the second pair of neighbors
    title('Difference Image for first pair of neighbors');
    subplot(2,2,4); 
    imhist(diff2);  %show difference histogram for the second pair of neighbors
    title('Difference Histogram for first pair of neighbors');
end

