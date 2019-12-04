function [respo] = convfreq(img,kern)
%CONVFREQ Summary of this function goes here
%   Detailed explanation goes here
    [rk,ck,chk]=size(kern);
    img = pad4dft(img);
    [r,c,ch] = size(img);
%     zpr = r+rk-1; zpc = c+ck-1;
    zpr = r; zpc = c;
    imgs = zeros(zpr,zpc);
    imgs(floor(zpr/2)+(1:r)-floor(r/2), floor(zpc/2)+(1:c)-floor ...
        (c/2),:) = img;
    imgfreq = dft2(fftshift(imgs));
    kernfreq = zeros(zpr,zpc);
    kernfreq(floor(zpr/2)+(1:rk)-floor(rk/2), floor(zpc/2)+(1:ck)-floor ...
        (ck/2),:) = kern;
    kernfreq = dft2(kernfreq);
    opfreq = imgfreq.*kernfreq;
    resp = real(idft2(opfreq));
    respo = ifftshift(resp);
    respo = respo(end/2+1:end, end/2+1:end);
end