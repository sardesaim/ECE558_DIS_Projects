function [blendedImg] = blendPyramid(bg, fg, bw_mask, nlayers)
%BLENDPYRAMID blend the pyramid based on selected bg fg and mask.
%   Calculates the Laplacian Pyramids of images and Gaussian Pyramid of the
%   mask and does alpha blending to get the blended pyramid. Then collapses
%   the pyramid to recover the blended image. 
    [~, lPyrBG] = ComputePyr(bg, nlayers); %calculate laplacian pyr of 1st img
    [~, lPyrFG] = ComputePyr(fg, nlayers); %calculate laplacian pyr of 2nd img
    [gPyrMask,~] = ComputePyr(double(bw_mask), nlayers); %gaussian pyr of mask
    for i = 1:length(gPyrMask)
        %calculate blended pyramid based on alpha blending with mask gpyr
        lblend{i} = (gPyrMask{i}) .* lPyrBG{i} + (1-(gPyrMask{i})).*lPyrFG{i};
    end
    layer = length(lblend);
    %generate gaussian kernel 
    dscale = 2.5; 
    sigm = (2*dscale)./6;
    kernS = floor(4*sigm+0.5);
    h = fspecial('gaussian', kernS ,sigm);
%     h = ([1;4;6;4;1]*[1 4 6 4 1])./256; % can be implemented as separable
%     filter as shown 

    %collapse pyramid 
    while(layer>1)
%         lblend{layer-1} = conv2d(upscale(lblend{layer}, size(lblend{layer-1})),h,3)+lblend{layer-1};
        lblend{layer-1} = convfreq(upscale(lblend{layer}, size(lblend{layer-1})),h)+lblend{layer-1};
        layer = layer-1;
    end
    blendedImg = lblend{1};
end

