function [max_x, max_y, max_r] = nonmaxs(currScale,sig, intervals, max_x, max_y, max_r, thresh)
%NMS Non max suppression
%   NMS - first find maximas in each layer. And then compare maximas with
%   the maximas from the layer above and below the particular layer. (3d
%   nms)
    mx = zeros(size(currScale,1), size(currScale,2),intervals);
%     for 2D non max filtering
    for i = 1:intervals+1
        mask_size = 3;
        %max filtering using a 3x3 window
        mx(:,:,i) = ordfilt2(currScale(:,:,i), mask_size^2, ones(mask_size));   
    end
%     3D non max filtering
    for i = 1:intervals+1
%        consider the maximum among the 3 adjacent layers
        mx(:,:,i) = max(mx(:,:,max(1,i-1):min(intervals+1,i+1)),[],3);
    end
    mx = mx.*(mx==currScale); %getting maximas 
    for i = 1:intervals+1
        curr = mx(:,:,i);   %maximas at current scale
        [r,c] = find(curr>thresh);  %discard maximas below threshold
        %can be used to eliminate blobs at the edges. 
%         rd = r(r>=1+sig(i)*sqrt(2) & r<=max(r)-sig(i)*sqrt(2) & c>=1+sig(i)*sqrt(2) ...
%             & c<=max(c)-sig(i)*sqrt(2));
%         cd = c(r>=1+sig(i)*sqrt(2) & r<=max(r)-sig(i)*sqrt(2) ...
%             & c>=1+sig(i)*sqrt(2) & c<=max(c)-sig(i)*sqrt(2));

%         repeat radius as a vector for all maximas at current scale
        current_radius = repmat(sig(i)*sqrt(2),[length(r) 1])';
        max_x = [max_x, [r]'];
        max_y = [max_y, [c]'];
        max_r = [max_r, [current_radius]];
    end
end