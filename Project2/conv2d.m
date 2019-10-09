function [op_img] = conv2d(img,kern, pad)
%CONV2 Summary of this function goes here
%   Detailed explanation goes here
    [r,c] = size(img);
    [rk, ck] = size(kern);
    img_pad = zeros(r+((rk+1)/2),c+((ck+1)/2));
    img_pad((rk+1)/2:end-1, (ck+1)/2:end-1) = img;
    op_img = img;
    for i = 2:r
        for j = 2:c
            for k = -1:1
                for l = -1:1
                    su(k+2,l+2) = img_pad(i+k,j+l).*kern(k+2,l+2);
                end
            end
            op_img(i,j) = sum(sum(su));
%             op_img(i-1,j-1)= op_img(i,j) + img_pad(i+k,j+l).*kern(k+2,l+2);
        end
    end
end

    