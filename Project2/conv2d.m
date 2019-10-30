function [op_img] = conv2d(img,kern, pad)
%CONV2 perform 2d convolution of an image with given kernel
%   Perform 2d convolution of an image. 
    [r,c] = size(img);
    [rk, ck] = size(kern);
    img_pad = SetPadding(img, kern, pad);
    op_img = img;
    if rk==1 && ck==2 %special case, horizontal derivative. 
        for i = 2:r+1
            for j = 2:c+1
                op_img(i-1,j-1) = img_pad(i-1,j-1).*kern(1,1)+ img_pad(i-1,j).*kern(1,2) ;
            end
        end
    elseif rk==2 && ck==1 %special case vertical derivative. 
        for i = 2:r+1
            for j = 2:c+1
                op_img(i-1,j-1) = img_pad(i-1,j-1).*kern(1,1)+ img_pad(i,j-1).*kern(2,1) ;
            end
        end
    elseif not(mod(rk,2) && mod(ck,2)) %even sized kernels (eg. 2x2, 4x4...)
        for i = 1:r
            for j = 1:c
                for k = 1:rk
                    for l = 1:ck
                        su(k,l) = img_pad(i+k-1,j+l-1).*kern(k,l);
                    end
                end
                op_img(i,j) = sum(sum(su));
            end
        end
    else %for odd sized kernels (3x3, 5x5...)
        for i = ceil(rk/2):r+1
            for j = ceil(ck/2):c+1
                for k = -floor(rk/2):floor(rk/2)
                    for l = -floor(ck/2):floor(ck/2)
                        su(k+ceil(rk/2),l+ceil(ck/2)) = img_pad(i+k,j+l).*kern(k+ceil(rk/2),l+ceil(ck/2));
                    end
                end
                op_img(i-1,j-1) = sum(sum(su));
            end
        end
    end
 end
    