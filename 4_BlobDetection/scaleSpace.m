function [l, dog] = scaleSpace(img, octaves,sigma, intervals)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    l = cell(octaves,1);
    dog = cell(octaves,1);
    fsize = cell(octaves,1);
    sig = cell(octaves,1);
    sigma_op = sigma;
    sigma_oct = sigma;
    k = sqrt(2);
    for oct = 1:octaves
        [rows,columns]=size(img);
        for i=1:intervals+1 
            fsize{oct}(i) = 2*ceil(3*sigma_op)+1;
            sig{oct}(i) = sigma_op;
            filter = genKernel('gaussian', (2*ceil(3*sigma_op)+1),sigma_op);
            l{oct}(:,:,i) = convfreq(img, filter);
            try
                dog{oct}(:,:,i-1) = l{oct}(:,:,i)-l{oct}(:,:,i-1);
            catch
            end
%             dog{oct}(:,:,i) = l{oct}(:,:,i).^2;
    %         figure;
    %         imshow(l{oct}(:,:,i));
            sigma_op=sigma_oct*(k^i);
        end
        sigma_oct = sigma*(2^oct-1);
        img = downscale(l{oct}(:,:,end-1), 0.5);
        img = upscale(img, [rows columns]);
    end
end

