 function [op_img] = conv2d(img,kern, pad)
%CONV2 Summary of this function goes here
%   Detailed explanation goes here
    [r,c] = size(img);
    [rk, ck] = size(kern);
    img_pad = SetPadding(img, kern, pad);
    op_img = img;
    if not(mod(rk,2) && mod(ck,2))
        for i = 2:r
            for j = 2:c
                for k = 1:rk
                    for l = 1:ck
                        su(k,l) = img_pad(i+k-1,j+l-1).*kern(k,l);
                    end
                end
                op_img(i,j) = sum(sum(su));
            end
        end
    else
        for i = 2:r
            for j = 2:c
                for k = -floor(rk/2):floor(rk/2)
                    for l = -floor(ck/2):floor(ck/2)
                        su(k+2,l+2) = img_pad(i+k,j+l).*kern(k+2,l+2);
                    end
                end
                op_img(i,j) = sum(sum(su));
            end
        end
    end
 end
    