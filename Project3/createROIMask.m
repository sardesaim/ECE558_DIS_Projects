function [fgo, roi, bw_mask1] = createROIMask(fg, bg, roitype)
%CREATEMASK Create Mask based on ROI type and returns the resized image
% and mask 
%   Returns the padded image and mask based on the selected ROI. The user
%   has 3 options - rectangular, elliptical and freeform. 
    %check roitype
    if(roitype == 1)
        roi = drawrectangle('Label', 'ROI', 'color', [1 0 0]);
    elseif(roitype == 2)
        roi = drawellipse('Label', 'ROI', 'color', [1 0 0]);
    else
        roi = drawfreehand('Label', 'ROI', 'color', [1 0 0]);
    end
    %create mask from the selected ROI 
    bw_mask = createMask(roi);
    [rb, cb, bch] = size(bg);
    [rf, cf, fch] = size(fg);
    %resize/ pad fg based on its original size.  
    if(rf*cf>rb*cb)
        fgo=upscale(fg, [rb,cb,bch]);
        bw_mask1 = upscale(bw_mask, [rb,cb]);
    elseif(rf*cf<rb*cb)
        fgo = zeros(rb,cb,bch);
        bw_mask1 = zeros(rb,cb);
        % center the smaller fg and its mask by zero padding to bg size 
        fgo(floor(rb/2)+(1:rf)-floor(rf/2), floor(cb/2)+(1:cf)-floor ...
            (cf/2),:) = fg;
        bw_mask1(floor(rb/2)+(1:rf)-floor(rf/2), floor(cb/2)+(1:cf)- ...
            floor(cf/2)) = bw_mask;
    else
        fgo = fg;
        bw_mask1 = bw_mask;
    end
end

