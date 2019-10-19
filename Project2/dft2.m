function [fftImg] = dft2(img)
%DFT2 Summary of this function goes here
%   Detailed explanation goes here
    img = (img-min(img(:)))./(max(img(:))-min(img(:)));
    %approach 1 - operate fft on first dimension first and then the second
    %using the syntax fft(x, [], dim)
    fftImg = fft(fft(img, [],1), [], 2);
%     Approach 2 - use 2 for loops, one to take fft of the rows. Then use
%     another one to take the fft of the obtained result from the first
%     loop 
%     [r,c] = size(img);
%     for i = 1:r
%         fftImg(i,:) = fft(img(i,:));
%     end
%     for j = 1:c
%         fftImg(:,j) = fft(fftImg(:,j));
%     end
end

