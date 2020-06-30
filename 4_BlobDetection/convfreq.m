function [respo] = convfreq(img,kern)
%CONVFREQ Convolution in frequency domain (Frequency domain filtering)
%   Filter the image in frequency domain. Use the dft2 and idft2 functions
%   for conversion to frequency domain. 
    [rk,ck]=size(kern); %kernel size
    [r,c] = size(img);  %image size
    if ~(r>rk && c>ck)  %calculate padding based on kernel size 
        zpr = r+2*floor(rk/2); zpc = c+2*floor(ck/2);
    else   %dont pad if kernel size is smaller than image size
        zpr = r; zpc = c;
    end
    imgs = zeros(zpr,zpc);  
    imgs(floor(zpr/2)+(1:r)-floor(r/2), floor(zpc/2)+(1:c)-floor ...
        (c/2),:) = img; %zero pad image
    imgs = pad4dft(imgs); %padding to avoid wraparound error
    imgfreq = dft2(fftshift(imgs)); %calculate dft of image
    [r,c] = size(imgs); %get size of new padded image 
    zpr = r; zpc = c;
    kernfreq = zeros(zpr,zpc);  %pad kernel
    kernfreq(floor(zpr/2)+(1:rk)-floor(rk/2), floor(zpc/2)+(1:ck)-floor ...
        (ck/2),:) = kern;   %pad kernel
    kernfreq = dft2(kernfreq);  %calculate dft of kernel
    opfreq = imgfreq.*kernfreq; %calculate the output in frequency domain 
    resp = real(idft2(opfreq)); %consider real part of idft
    respo = ifftshift(resp);    %shift the output 
    respo = respo(end/2+1:end, end/2+1:end);    %'unpad' image 
    if ~(size(img,1)>rk && size(img,2)>ck)  %'unpad' image
        respo = respo(1+floor(rk/2):end-floor(rk/2),1+floor(ck/2):end-floor(ck/2));
    else
        respo = respo;
    end
end