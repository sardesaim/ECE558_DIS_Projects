function [gPyr,lPyr] = ComputePyr(img1, num_layers)
%GENGAUSSIANPYR Summary of this function goes here
%   Detailed explanation goes here
    layer = 1;
    gPyr{layer}=img1;
    while(sum(size(gPyr{layer}))~=2 && layer<=num_layers)
    h = fspecial('gaussian', 3, 2);
    gPyr{layer+1} = conv2d(gPyr{layer}, h, 4);
%     figure(layer);
%     imshow(gPyr{layer+1});
    gPyr{layer+1} = downscale(gPyr{layer+1},0.5);
    layer = layer+1;
    end
    lPyr{layer}=gPyr{layer};
    while layer>1
        lPyr{layer-1} = gPyr{layer-1}-conv2d(upscale(gPyr{layer},size(gPyr{layer-1})), h, 4);
%         figure;
%         imshow(lPyr{layer});
        layer = layer-1;
    end
end

