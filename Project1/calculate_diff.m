function [diff1, diff2] = calculate_diff(wolves,color_space,neighbor)
%This function takes the image, selected color space and type of neighbors
%as input and outputs the squared difference depending on the selected type

%   Detailed explanation goes here
    [ht ,wd, col] = size(wolves);
    switch(color_space)
        case 'RGB'
            subplot(211);
            imshow(wolves);
            subplot(212)
            bar(imhist(wolves(:,:,1)), 'r'); hold on;
            bar(imhist(wolves(:,:,2)), 'g'); hold on;
            bar(imhist(wolves(:,:,3)), 'b'); hold on; legend('Red channel', 'Green Channel', 'Blue Channel'); hold off;
            switch(neighbor)
                case 4
                    %for neighbors (x,y) and (x+1,y) 
                    wolves_x1 = [wolves(:,2:end, :) zeros(ht,1,col)];
                    diff = (wolves-wolves_x1).^2;
                    diff1 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3);
                    %for neighbors (x,y) and (x,y+1)
                    wolves_y1 = [wolves(2:end,:, :) ;zeros(1,wd,col)];
                    diff = (wolves-wolves_y1).^2;
                    diff2 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3);
                case 8
                    %for neighbors (x,y) and (x+1, y+1)
                    wolves_x1 = [wolves(2:end,2:end, :) zeros(ht-1,1,col); zeros(1, wd, col)];
                    diff = (wolves-wolves_x1).^2;
                    diff1 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3);
                    %for neighbors (x,y) and (x-1, y-1)
                    wolves_y1 = zeros(ht, wd, col, 'uint8');
                    wolves_y1(2:end,2:end,:) = wolves(1:end-1,1:end-1, :);
                    diff = (wolves-wolves_y1).^2;
                    diff2 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3);
                otherwise
                    disp('Please select 4/ 8 neighbor pairs');
            end
        case 'Grayscale'
            wolves_gray = rgb2gray(wolves);
            subplot(211);
            imshow(wolves_gray);
            subplot(212)
            imhist(wolves_gray);
            switch(neighbor)
                case 4
                    %for neighbors (x,y) and (x+1,y) 
                    wolves_gray_x1 = [wolves_gray(:, 2:end) zeros(ht,1)];
                    diff1 = (wolves_gray-wolves_gray_x1).^2;
                    %for neighbors (x,y) and (x,y+1) 
                    wolves_gray_y1 = [wolves_gray(2:end, :); zeros(1, wd)];
                    diff2 = (wolves_gray-wolves_gray_y1).^2;
                case 8
                    %for neighbors (x,y) and (x+1,y+1) 
                    wolves_gray_x1 = [wolves_gray(2:end, 2:end) zeros(ht-1,1); zeros(1,wd)];
                    diff1 = (wolves_gray-wolves_gray_x1).^2;
                    %for neighbors (x,y) and (x-1,y-1) 
                    wolves_gray_y1 = zeros(ht, wd, 'uint8');
                    wolves_gray_y1(2:end, 2:end) = wolves_gray(1:end-1, 1:end-1);
                    diff2 = (wolves_gray-wolves_gray_y1).^2;
                otherwise
                    disp('Please select 4/ 8 neighbor pairs');
            end
        case 'HSV'
            wolves_hsv = rgb2hsv(wolves);
            subplot(211);
            imshow(wolves_hsv);
            subplot(212)
            bar(imhist(wolves_hsv(:,:,1)), 'y'); hold on;
            bar(imhist(wolves_hsv(:,:,2)), 'm'); hold on;
            bar(imhist(wolves_hsv(:,:,3)), 'c'); hold on; legend('Hue', 'Saturation', 'Value'); hold off;
            switch(neighbor)
                case 4
                    %for neighbors (x,y) and (x+1,y) 
                    wolves_hsv_x1 = [wolves_hsv(:, 2:end,3) zeros(ht,1)];
                    diff1 = (wolves_hsv-wolves_hsv_x1).^2;
                    %for neighbors (x,y) and (x,y+1) 
                    wolves_hsv_y1 = [wolves_hsv(2:end, :,3); zeros(1, wd)];
                    diff2 = (wolves_hsv-wolves_hsv_y1).^2;
                case 8
                    %for neighbors (x,y) and (x+1,y+1) 
                    wolves_hsv_x1 = [wolves_hsv(2:end, 2:end,3) zeros(ht-1,1); zeros(1,wd)];
                    diff1 = (wolves_hsv-wolves_hsv_x1).^2;
                    %for neighbors (x,y) and (x-1,y-1) 
                    wolves_hsv_y1 = zeros(ht, wd, 'double');
                    wolves_hsv_y1(2:end, 2:end,3) = wolves_hsv(1:end-1, 1:end-1,3);
                    diff2 = (wolves_hsv-wolves_hsv_y1).^2;
                otherwise
                    disp('Please select 4/ 8 neighbor pairs');
            end
        case 'La*b*'
            wolves_lab = rgb2lab(wolves);
            subplot(211);
            imshow(wolves_lab);
            subplot(212)
            bar(imhist(wolves_lab(:,:,1)), 'm'); hold on;
            bar(imhist(wolves_lab(:,:,2)), 'g'); hold on;
            bar(imhist(wolves_lab(:,:,3)), 'c'); hold on; legend('L', 'a*', 'b*'); hold off;
            switch(neighbor)
                case 4
                    %for neighbors (x,y) and (x+1,y) 
                    wolves_lab_x1 = [wolves_lab(:, 2:end,1) zeros(ht,1)];
                    diff1 = (wolves_lab-wolves_lab_x1).^2;
                    %for neighbors (x,y) and (x,y+1) 
                    wolves_lab_y1 = [wolves_lab(2:end, :,1); zeros(1, wd)];
                    diff2 = (wolves_lab-wolves_lab_y1).^2;
                case 8
                    %for neighbors (x,y) and (x+1,y+1) 
                    wolves_lab_x1 = [wolves_lab(2:end, 2:end,1) zeros(ht-1,1); zeros(1,wd)];
                    diff1 = (wolves_lab-wolves_lab_x1).^2;
                    %for neighbors (x,y) and (x-1,y-1) 
                    wolves_lab_y1 = zeros(ht, wd, 'double');
                    wolves_lab_y1(2:end, 2:end,3) = wolves_lab(1:end-1, 1:end-1,3);
                    diff2 = (wolves_lab-wolves_lab_y1).^2;
                otherwise
                    disp('Please select 4/ 8 neighbor pairs');
            end
        otherwise
    end
end

