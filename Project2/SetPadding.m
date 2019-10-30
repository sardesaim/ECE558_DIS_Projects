function [img_pad] = SetPadding(img, kern, pad)
%SETPADDING Set padding based on kernel size
%   Set padding to set up an image for convolution based on the kernel size
%   of the chosen kernel. The size of the kernel is used as a reference for
%   the amount of padding required. The padding is performed by considering
%   padding type and then slicing appropriate indices from original image
%   to copy them to the actual image.
[r,c] = size(img); %size of image
[rk, ck] = size(kern); %size of kernel 
if rk==1 && ck==2 %special case for horizontal derivative filter
    if pad == 1 %zero padding
        img_pad = zeros(r,c+1); %add a column 
        img_pad(:, 1:end-1) = img; 
    elseif pad == 2 %copy edge 
        img_pad = zeros(r,c+1); 
        img_pad(:, 1:end-1) = img;
        img_pad(:, end) = img(:,end);
    elseif pad == 3 %wrap around
        img_pad = zeros(r,c+1);
        img_pad(:, 1:end-1) = img;
        img_pad(:, end) = img(:,1);
    elseif pad == 4 %reflect across edge
        img_pad = zeros(r,c+1);
        img_pad(:, 1:end-1) = img;
        img_pad(:, end) = img(:,end);
<<<<<<< HEAD
    end
elseif rk==2 && ck==1 %special case for horizontal derivative filter
    if pad == 1 %zero padding
        img_pad = zeros(r+1,c);
        img_pad(1:end-1,:) = img;
    elseif pad == 2 %copy edge 
        img_pad = zeros(r+1,c);
        img_pad(1:end-1,:) = img;
        img_pad(end,:) = img(end,:);
    elseif pad == 3 %wrap around
        img_pad = zeros(r+1,c);
        img_pad(1:end-1,:) = img;
        img_pad(end,:) = img(1,:);
    elseif pad == 4 %reflect across edge 
        img_pad = zeros(r+1,c); 
        img_pad(1:end-1,:) = img;
        img_pad(end,:) = img(end,:);
    end
elseif (mod(rk,2) && mod(ck,2)) %for odd sized kernels. (3x3, 5x5...)
    if pad == 1 %zero padding
        img_pad = zeros(r+2*floor(rk/2),c+2*floor(ck/2)); %add ceil(kernelsize/2) number of rows and cols
        img_pad(ceil(rk/2):end-floor(rk/2), ceil(ck/2):end-floor(ck/2)) = img;
    elseif pad == 2 %copy edge 
        %set up as zero padding 
        img_pad = zeros(r+2*floor(rk/2),c+2*floor(ck/2));
        img_pad(ceil(rk/2):end-floor(rk/2), ceil(ck/2):end-floor(ck/2)) = img;
        %copy edges to the newly added edges
        img_pad(ceil(rk/2):end-floor(rk/2), 1:floor(ck/2)) = repmat(img(:,1),1,floor(ck/2)); 
        img_pad(ceil(rk/2):end-floor(rk/2), end-floor(ck/2)+1:end) = repmat(img(:,end),1,floor(rk/2));
        img_pad(1:floor(rk/2),ceil(ck/2):end-floor(ck/2)) = repmat(img(1,:),floor(rk/2),1);
        img_pad(end-floor(rk/2)+1:end,ceil(ck/2):end-floor(ck/2)) = repmat(img(end,:),floor(ck/2),1);
        %corner cases
        img_pad(1:floor(rk/2), 1:floor(ck/2)) = repmat(img(1,1), floor(rk/2), floor(ck/2));
        img_pad(end-floor(rk/2)+1:end, 1:floor(ck/2)) = repmat(img(end,1), floor(rk/2), floor(ck/2));
        img_pad(1:floor(rk/2), end-floor(ck/2)+1:end) = repmat(img(1,end), floor(rk/2), floor(ck/2));
        img_pad(end-floor(rk/2)+1:end, end-floor(ck/2)+1:end) = repmat(img(end,end), floor(rk/2), floor(ck/2));
    elseif pad == 3 %wrap around
        %set up as zero padding 
        img_pad = zeros(r+2*floor(rk/2),c+2*floor(ck/2));
        img_pad(ceil(rk/2):end-floor(rk/2), ceil(ck/2):end-floor(ck/2)) = img;
        %wrap edges from other end to the newly added edges
        img_pad(floor((rk+1)/2):end-floor(rk/2), 1:floor(ck/2)) = img(:,end-floor(ck/2)+1:end);
        img_pad(floor((rk+1)/2):end-floor(rk/2), end-floor(ck/2)+1:end) = img(:,1:floor(ck/2));
        img_pad(1:floor(rk/2),floor((ck+1)/2):end-floor(ck/2)) = img(end-floor(rk/2)+1:end,:); 
        img_pad(end-floor(rk/2)+1:end,floor((ck+1)/2):end-floor(ck/2)) = img(1:floor(rk/2),:);
        %corner cases
        img_pad(1:floor(rk/2), 1:floor(ck/2)) = img(end-floor(rk/2)+1:end, end-floor(ck/2)+1:end);
        img_pad(end-floor(rk/2)+1:end, 1:floor(ck/2)) = img(1:floor(rk/2), end-floor(ck/2)+1:end);
        img_pad(1:floor(rk/2), end-floor(ck/2)+1:end) = img(end-floor(rk/2)+1:end, 1:floor(ck/2));
        img_pad(end-floor(rk/2)+1:end, end-floor(ck/2)+1:end) = img(1:floor(rk/2), 1:floor(ck/2));
    elseif pad == 4 %reflect across edge
        %set up as zero padding 
        img_pad = zeros(r+2*floor(rk/2),c+2*floor(ck/2));
        img_pad(ceil(rk/2):end-floor(rk/2), ceil(ck/2):end-floor(ck/2)) = img;
        %reflect across edges
        img_pad(floor((rk+1)/2):end-floor(rk/2), 1:floor(ck/2)) = img(:,floor(ck/2):-1:1);
        img_pad(floor((rk+1)/2):end-floor(rk/2), end-floor(ck/2)+1:end) = img(:,end:-1:end-floor(ck/2)+1);
        img_pad(1:floor(rk/2),floor((ck+1)/2):end-floor(ck/2)) = img(floor(rk/2):-1:1,:);
        img_pad(end-floor(rk/2)+1:end,floor((ck+1)/2):end-floor(ck/2)) = img(end:-1:end-floor(rk/2)+1,:);
        %corner cases
        img_pad(1:floor(rk/2), 1:floor(ck/2)) = img(floor(rk/2):-1:1, floor(ck/2):-1:1);
        img_pad(end-floor(rk/2)+1:end, 1:floor(ck/2)) = img(end:-1:end-floor(rk/2)+1, floor(ck/2):-1:1);
        img_pad(1:floor(rk/2), end-floor(ck/2)+1:end) = img(floor(rk/2):-1:1, end:-1:end-floor(ck/2)+1);
        img_pad(end-floor(rk/2)+1:end, end-floor(ck/2)+1:end) = img(end:-1:end-floor(rk/2)+1, end:-1:end-floor(ck/2)+1);
    end
else %for even sized kernels (eg. 2x2, 4x4...) 
    if pad == 1 %zero padding
        img_pad = zeros(r+rk/2,c+ck/2);
        img_pad(1:end-(rk/2), 1:end-(ck/2)) = img;
    elseif pad == 2 %copy edge
        %set up as zero padding 
        img_pad = zeros(r+rk/2,c+ck/2);
        img_pad(1:end-(rk/2), 1:end-(ck/2)) = img;
        %copy edges to the image. 
        img_pad(1:end-(rk/2), end-ck/2+1:end) = repmat(img(:,end), floor(ck/2));
        img_pad(end-rk/2+1:end,1:end-(ck/2)) = repmat(img(end,:), floor(rk/2));
        %corner cases
        img_pad(end-(rk/2)+1:end, end-(ck/2)+1:end) = repmat(img(end,end), floor(rk/2),floor(ck/2));
    elseif pad == 3 %wrap around
        %set up as zero padding
        img_pad = zeros(r+rk/2,c+ck/2);
        img_pad(1:end-(rk/2), 1:end-(ck/2)) = img;
        %wrap around edges
        img_pad(1:end-1, end-ck/2+1:end) = img(:,1:ck/2);
        img_pad(end-rk/2+1:end,1:end-1) = img(1:rk/2,:);
        %corner case
        img_pad(end-(rk/2)+1:end, end-(ck/2)+1:end) = img(1:(rk/2),1:(ck/2));
    elseif pad == 4 %reflect across edge
        img_pad = zeros(r+rk/2,c+ck/2);
        img_pad(1:end-1, 1:end-1) = img;
        %reflect across edge
        img_pad(1:end-1, end-ck/2+1:end) = img(:,end:end-ck/2+1);
        img_pad(end-rk/2+1:end,1:end-1) = img(end:end-rk/2+1,:);
        %corner case
        img_pad(end-(rk/2)+1:end, end-(ck/2)+1:end) = img(end:end-(rk/2)+1,end:end-(ck/2)+1);
=======
>>>>>>> c26e8f1896b5b70ea31c86ff97d6141df9f19f48
    end
elseif rk==2 && ck==1 %special case for horizontal derivative filter
    if pad == 1 %zero padding
        img_pad = zeros(r+1,c);
        img_pad(1:end-1,:) = img;
    elseif pad == 2 %copy edge 
        img_pad = zeros(r+1,c);
        img_pad(1:end-1,:) = img;
        img_pad(end,:) = img(end,:);
    elseif pad == 3 %wrap around
        img_pad = zeros(r+1,c);
        img_pad(1:end-1,:) = img;
        img_pad(end,:) = img(1,:);
    elseif pad == 4 %reflect across edge 
        img_pad = zeros(r+1,c); 
        img_pad(1:end-1,:) = img;
        img_pad(end,:) = img(end,:);
    end
elseif (mod(rk,2) && mod(ck,2)) %for odd sized kernels. (3x3, 5x5...)
    if pad == 1 %zero padding
        img_pad = zeros(r+ceil(rk/2),c+ceil(ck/2)); %add ceil(kernelsize/2) number of rows and cols
        img_pad((rk+1)/2:end-1, (ck+1)/2:end-1) = img;
    elseif pad == 2 %copy edge 
        %set up as zero padding 
        img_pad = zeros(r+ceil(rk/2),c+ceil(ck/2)); 
        img_pad((rk+1)/2:end-1, (ck+1)/2:end-1) = img;
        %copy edges to the newly added edges
        img_pad(floor((rk+1)/2):end-1, 1:floor(ck/2)) = repmat(img(:,1),floor(ck/2)); 
        img_pad(floor((rk+1)/2):end-1, end-floor(ck/2)+1:end) = repmat(img(:,end),floor(rk/2));
        img_pad(1:floor(rk/2),floor((ck+1)/2):end-1) = repmat(img(1,:),floor(rk/2));
        img_pad(end-floor(rk/2)+1:end,floor((ck+1)/2):end-1) = repmat(img(end,:),floor(ck/2));
        %corner cases
        img_pad(1:floor(rk/2), 1:floor(ck/2)) = repmat(img(1,1), floor(rk/2), floor(ck/2));
        img_pad(end-floor(rk/2):end, 1:floor(ck/2)) = repmat(img(end,1), floor(rk/2), floor(ck/2));
        img_pad(1:floor(rk/2), end-floor(ck/2):end) = repmat(img(1,end), floor(rk/2), floor(ck/2));
        img_pad(end-floor(rk/2):end, end-floor(ck/2):end) = repmat(img(end,end), floor(rk/2), floor(ck/2));
    elseif pad == 3 %wrap around
        %set up as zero padding 
        img_pad = zeros(r+ceil(rk/2),c+ceil(ck/2));
        img_pad((rk+1)/2:end-1, (ck+1)/2:end-1) = img;
        %wrap edges from other end to the newly added edges
        img_pad(floor((rk+1)/2):end-1, 1:floor(ck/2)) = img(:,end-floor(ck/2)+1:end);
        img_pad(floor((rk+1)/2):end-1, end-floor(ck/2)+1:end) = img(:,1:floor(ck/2));
        img_pad(1:floor(rk/2),floor((ck+1)/2):end-1) = img(end-floor(rk/2)+1:end,:); 
        img_pad(end-floor(rk/2)+1:end,floor((ck+1)/2):end-1) = img(1:floor(rk/2),:);
        %corner cases
        img_pad(1:floor(rk/2), 1:floor(ck/2)) = img(end-floor(rk/2)+1:end, end-floor(ck/2)+1:end);
        img_pad(end-floor(rk/2)+1:end, 1:floor(ck/2)) = img(1:floor(rk/2), end-floor(ck/2)+1:end);
        img_pad(1:floor(rk/2), end-floor(ck/2)+1:end) = img(end-floor(rk/2)+1:end, 1:floor(ck/2));
        img_pad(end-floor(rk/2)+1:end, end-floor(ck/2)+1:end) = img(1:floor(rk/2), 1:floor(ck/2));
    elseif pad == 4 %reflect across edge
        %set up as zero padding 
        img_pad = zeros(r+ceil(rk/2),c+ceil(ck/2));
        img_pad((rk+1)/2:end-1, (ck+1)/2:end-1) = img;
        %reflect across edges
        img_pad(floor((rk+1)/2):end-1, 1:floor(ck/2)) = img(:,floor(ck/2):1);
        img_pad(floor((rk+1)/2):end-1, end-floor(ck/2)+1:end) = img(:,end:end-floor(ck/2)+1);
        img_pad(1:floor(rk/2),floor((ck+1)/2):end-1) = img(floor(rk/2):1,:);
        img_pad(end-floor(rk/2)+1:end,floor((ck+1)/2):end-1) = img(end:end-floor(rk/2)+1,:);
        %corner cases
        img_pad(1:floor(rk/2), 1:floor(ck/2)) = img(floor(rk/2):1, floor(ck/2):1);
        img_pad(end-floor(rk/2)+1:end, 1:floor(ck/2)) = img(end:end-floor(rk/2)+1, floor(ck/2):1);
        img_pad(1:floor(rk/2), end-floor(ck/2)+1:end) = img(floor(rk/2):1, end:end-floor(ck/2)+1);
        img_pad(end-floor(rk/2)+1:end, end-floor(ck/2)+1:end) = img(end:end-floor(rk/2)+1, end:end-floor(ck/2)+1);
    end
else %for even sized kernels (eg. 2x2, 4x4...) 
    if pad == 1 %zero padding
        img_pad = zeros(r+rk/2,c+ck/2);
        img_pad(1:end-(rk/2), 1:end-(ck/2)) = img;
    elseif pad == 2 %copy edge
        %set up as zero padding 
        img_pad = zeros(r+rk/2,c+ck/2);
        img_pad(1:end-(rk/2), 1:end-(ck/2)) = img;
        %copy edges to the image. 
        img_pad(1:end-(rk/2), end-ck/2+1:end) = repmat(img(:,end), floor(ck/2));
        img_pad(end-rk/2+1:end,1:end-(ck/2)) = repmat(img(end,:), floor(rk/2));
        %corner cases
        img_pad(end-(rk/2)+1:end, end-(ck/2)+1:end) = repmat(img(end,end), floor(rk/2),floor(ck/2));
    elseif pad == 3 %wrap around
        %set up as zero padding
        img_pad = zeros(r+rk/2,c+ck/2);
        img_pad(1:end-(rk/2), 1:end-(ck/2)) = img;
        %wrap around edges
        img_pad(1:end-1, end-ck/2+1:end) = img(:,1:ck/2);
        img_pad(end-rk/2+1:end,1:end-1) = img(1:rk/2,:);
        %corner case
        img_pad(end-(rk/2)+1:end, end-(ck/2)+1:end) = img(1:(rk/2),1:(ck/2));
    elseif pad == 4 %reflect across edge
        img_pad = zeros(r+rk/2,c+ck/2);
        img_pad(1:end-1, 1:end-1) = img;
        %reflect across edge
        img_pad(1:end-1, end-ck/2+1:end) = img(:,end:end-ck/2+1);
        img_pad(end-rk/2+1:end,1:end-1) = img(end:end-rk/2+1,:);
        %corner case
        img_pad(end-(rk/2)+1:end, end-(ck/2)+1:end) = img(end:end-(rk/2)+1,end:end-(ck/2)+1);
end
end