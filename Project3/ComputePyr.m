function [gPyr,lPyr] = ComputePyr(img1, num_layers)
%GENGAUSSIANPYR Galculate Gaussian and Laplacian Pyramids of the image. 
%   Calculate the Gaussian and Laplacian Pyramid based on the number of
%   layers provided by the user/ till max possible layers (last layer being
%   1x1)

    layer = 1;
    %generate gaussian kernel 
    dscale = 2.5; 
    sigm = (2*dscale)./6;
    kernS = floor(4*sigm+0.5);
    h = fspecial('gaussian', kernS ,sigm);
%     h = ([1;4;6;4;1]*[1 4 6 4 1])./256; %can be implemented as a
%     separable filter as shown 
    
    %set the initial layer as the original image. 
    gPyr{layer} = img1; 
    %while size of pyramid is greater than 1x1 & greater than layers
    %specified.
    
    %can view the pyramids by uncommenting the imshow and figure functions.
    %Takes up a lot of time. 
    while(sum(size(gPyr{layer}))~=2 && layer<=num_layers)
        %smoothen and downscale 
        gPyr{layer+1} = conv2d(gPyr{layer}, h, 3);
        gPyr{layer+1} = downscale(gPyr{layer+1},0.5);
        layer = layer+1;
%         figure; 
%         imshow(gPyr{layer});
    end
    lPyr{layer}=gPyr{layer};
    while layer>1
        lPyr{layer-1} = gPyr{layer-1}-conv2d(upscale(gPyr{layer},size(gPyr{layer-1})), h, 3);
%         figure;
%         imshow(lPyr{layer});
        layer = layer-1;
    end
end

