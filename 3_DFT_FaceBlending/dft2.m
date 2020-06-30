function [fftImg] = dft2(img)
%DFT2 Summary of this function goes here
%   Detailed explanation goes here
%     img = (img-min(img(:)))./(max(img(:))-min(img(:)));
    %approach 1 - operate fft on first dimension first and then the second
    %using the syntax fft(x, [], dim)
    [r c ch] = size(img);
    if ch>1
        fftImg(:,:,1) = fft(fft(img(:,:,1), [],1), [], 2);
        fftImg(:,:,2) = fft(fft(img(:,:,2), [],1), [], 2);
        fftImg(:,:,3) = fft(fft(img(:,:,3), [],1), [], 2);
    else
        fftImg = fft(fft(img, [],1), [], 2);
    end
%     Approach 2 - use 2 for loops, one to take fft of the rows. Then use
%     another one to take the fft of the obtained result from the first
%     loop 
%     [r,c,ch] = size(img);
%     for c = 1:ch
%         for i = 1:r
%             fftImg(i,:,ch) = fft(img(i,:,ch));
%         end
%         for j = 1:c
%             fftImg(:,j,ch) = fft(fftImg(:,j,ch));
%         end
%     end
end

