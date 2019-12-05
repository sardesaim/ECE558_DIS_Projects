function [max_x, max_y, max_r] = nms(l,fsize, sig, oct, intervals, max_x, max_y, max_r)
%NMS Non max suppression
%   NMS - first find maximas in each layer. And then compare maximas with
%   the maximas from the layer above and below the particular layer. (3d
%   nms)
    possible_maximas = [];
    max_res = zeros(size(l{oct},1), size(l{oct},2),intervals+1);
    for i = 1:intervals+1
%         currImg = l{oct}(:,:,i);
        threshold = 0.01;
        mask_size = 5;
        mx = ordfilt2(l{oct}(:,:,i), mask_size^2, ones(mask_size));   
        max_res(:,:,i) = (l{oct}(:,:,i)==mx)&(l{oct}(:,:,i)>threshold);
        [r,c] = find(max_res(:,:,i));
        possible_maximas = [possible_maximas, {[r,c]}];
    end
    for intr = 2:intervals
        currMaxLvl = possible_maximas(intr);
        currentMaxCell = currMaxLvl{1};
        numFound = size(currentMaxCell);
        filterSize = fsize{oct}(intr);
        current_radius = sig{oct}(intr)*sqrt(2);
        image_size = size(l{oct},1:2);
%         ['level: ' num2str(intr) ' radius: ' num2str(current_radius) ' filter: ' num2str(filterSize)]
        for i=1 : numFound(1)
            current_point = currentMaxCell(i,:);
            x = current_point(1);
            y = current_point(2);
            % drop the max positions that are too close to the edge of the image
            if(x <= filterSize || x > image_size(1)-filterSize)
                continue;
            end
            if(y <= filterSize || y > image_size(2)-filterSize)
                continue;
            end
            local_max = l{oct}(x,y,intr);
            upper_vals = [ l{oct}(x-filterSize:x+filterSize, y-filterSize:y+filterSize, intr+1) ];
            upper_max = max(upper_vals(:));

            lower_vals = [ l{oct}(x-filterSize:x+filterSize, y-filterSize:y+filterSize, intr-1) ];
            lower_max = max(lower_vals(:));

            if( (local_max > upper_max) && (local_max > lower_max))
                max_x = [max_x, [x]];
                max_y = [max_y, [y]];
                max_r = [max_r, [current_radius]];
            end
        end
    end
end

