function [bw_mask] = createMask(fg, bg)
%CREATEMASK Summary of this function goes here
%   Detailed explanation goes here
    imshow(fg);
    roi = drawrectangle('Label', 'Face', 'color', [1 0 0]);
    bw_mask = createMask(roi);
    imshow(bw_mask);
%     figure;
%     imshow(bg);
%     bgFaceCenter = drawrectangle('Label', 'FaceCenterBG');
end

