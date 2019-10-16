function [img_pad] = SetPadding(img, kern, pad)
%SETPADDING Summary of this function goes here
%   Detailed explanation goes here
    [r,c] = size(img);
    [rk, ck] = size(kern);
    if (mod(rk,2) && mod(ck,2))
        if pad == 1
            img_pad = zeros(r+ceil(rk/2),c+ceil(ck/2));
            img_pad((rk+1)/2:end-1, (ck+1)/2:end-1) = img;
        elseif pad == 2 
            img_pad = zeros(r+ceil(rk/2),c+ceil(ck/2));
            img_pad((rk+1)/2:end-1, (ck+1)/2:end-1) = img;
            img_pad(2:end-1, 1:floor(ck/2)) = img(:,1:floor(ck/2));
            img_pad(2:end-1, end-floor(ck/2)+1:end) = img(:,end-floor(ck/2)+1:end);
            img_pad(1:floor(rk/2),2:end-1) = img(1:floor(rk/2),:);
            img_pad(end-floor(rk/2)+1:end,2:end-1) = img(end-floor(rk/2)+1:end,:);
        elseif pad == 3 
            img_pad = zeros(r+ceil(rk/2),c+ceil(ck/2));
            img_pad((rk+1)/2:end-1, (ck+1)/2:end-1) = img;
            img_pad(2:end-1, 1:floor(ck/2)) = img(:,end-floor(ck/2)+1:end);
            img_pad(2:end-1, end-floor(ck/2)+1:end) = img(:,1:floor(ck/2));
            img_pad(1:floor(rk/2),2:end-1) = img(end-floor(rk/2)+1:end,:); 
            img_pad(end-floor(rk/2)+1:end,2:end-1) = img(1:floor(rk/2),:);
        elseif pad == 4
            img_pad = zeros(r+ceil(rk/2),c+ceil(ck/2));
            img_pad((rk+1)/2:end-1, (ck+1)/2:end-1) = img;
            img_pad(2:end-1, 1:floor(ck/2)) = img(:,floor(ck/2):1);
            img_pad(2:end-1, end-floor(ck/2)+1:end) = img(:,end:end-floor(ck/2)+1);
            img_pad(1:floor(rk/2),2:end-1) = img(floor(rk/2):1,:);
            img_pad(end-floor(rk/2)+1:end,2:end-1) = img(end:end-floor(rk/2)+1,:);
        end
    else
        if pad == 1
            img_pad = zeros(r+rk/2,c+ck/2);
            img_pad(1:end-1, 1:end-1) = img;
        elseif pad == 2 
            img_pad = zeros(r+rk/2,c+ck/2);
            img_pad(1:end-1, 1:end-1) = img;
            img_pad(1:end-1, end-ck/2+1:end) = img(:,end-ck/2+1:end);
            img_pad(end-rk/2+1:end,1:end-1) = img(end-rk/2+1:end,:);
        elseif pad == 3 
            img_pad = zeros(r+rk/2,c+ck/2);
            img_pad(1:end-1, 1:end-1) = img;
            img_pad(1:end-1, end-ck/2+1:end) = img(:,1:ck/2);
            img_pad(end-rk/2+1:end,1:end-1) = img(1:rk/2,:);
        elseif pad == 4
            img_pad = zeros(r+rk/2,c+ck/2);
            img_pad(1:end-1, 1:end-1) = img;
            img_pad(1:end-1, end-ck/2+1:end) = img(:,end:end-ck/2+1);
            img_pad(end-rk/2+1:end,1:end-1) = img(end:end-rk/2+1,:);
        end
    end
end

