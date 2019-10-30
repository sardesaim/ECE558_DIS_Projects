function [blendedImg] = blendPyramid(bg, fg, bw_mask)
%BLENDPYRAMID Summary of this function goes here
%   Detailed explanation goes here
    [~, lPyrBG] = ComputePyr(bg, 15);
    [~, lPyrFG] = ComputePyr(fg, 15);
    [gPyrMask,~] = ComputePyr(bw_mask, 15);
    for i = 1:length(gPyrMask)
        lblend{i} = uint8(gPyrMask{i}) .* lPyrBG{i} + (1-uint8(gPyrMask{i})).*lPyrFG{i};
    end
    layer = length(lblend);
    blendedImg = uint8(zeros(size(lblend{1})));
    while(layer>1)
        lblend{layer-1} = upscale(lblend{layer}, size(lblend{layer-1}))+lblend{layer-1};
        layer = layer-1;
    end
    blendedImg = lblend{1};
end

