function [padImg] = pad4dft(img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    padImg = zeros(2*size(img,1:2));
    padImg(1:size(img,1), 1:size(img, 2))=img;
end

