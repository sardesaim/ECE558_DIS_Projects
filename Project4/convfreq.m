function [respo] = convfreq(img,kern)
%CONVFREQ Summary of this function goes here
%   Detailed explanation goes here
    [rk,ck]=size(kern);
%     img = pad4dft(img);
    [r,c] = size(img);
    if ~(r>rk && c>ck)
        zpr = r+2*floor(rk/2); zpc = c+2*floor(ck/2);
    else
        zpr = r; zpc = c;
    end
%     zpr = r; zpc = c;
    imgs = zeros(zpr,zpc);
    imgs(floor(zpr/2)+(1:r)-floor(r/2), floor(zpc/2)+(1:c)-floor ...
        (c/2),:) = img;
    imgs = pad4dft(imgs); %test
    imgfreq = dft2(fftshift(imgs));
    [r,c] = size(imgs);
    zpr = r; zpc = c;
    kernfreq = zeros(zpr,zpc);
    kernfreq(floor(zpr/2)+(1:rk)-floor(rk/2), floor(zpc/2)+(1:ck)-floor ...
        (ck/2),:) = kern;
    kernfreq = dft2(kernfreq);
    opfreq = imgfreq.*kernfreq;
    resp = real(idft2(opfreq));
    respo = ifftshift(resp);
    respo = respo(end/2+1:end, end/2+1:end);
    if ~(size(img,1)>rk && size(img,2)>ck)
        respo = respo(1+floor(rk/2):end-floor(rk/2),1+floor(ck/2):end-floor(ck/2));
    else
        respo = respo;
    end
end