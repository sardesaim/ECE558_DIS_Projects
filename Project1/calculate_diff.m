function [diff1, diff2] = calculate_diff(image,color_space,neighbor)
%This function takes the image, selected color space and type of neighbors
%as input and outputs the squared difference depending on the selected type

%Note - the calculation for squared difference has been vectorized to avoid
%lengthy loops and save some time. 


%   Detailed explanation goes here
    [ht ,wd, col] = size(image); %size of input image. 
    switch(color_space) %select color space. Different computation of difference for each color space
        case 'RGB'
            %plot original image and it's histogram
            subplot(211);
            imshow(image);
            subplot(212);
            bar(imhist(image(:,:,1)), 'r'); hold on;
            bar(imhist(image(:,:,2)), 'g'); hold on;
            bar(imhist(image(:,:,3)), 'b'); hold on; legend('Red channel', 'Green Channel', 'Blue Channel'); hold off;
            switch(neighbor)
                case 4
                    %for neighbors (x,y) and (x+1,y) 
                    img_x1 = [image(:,2:end, :) zeros(ht,1,col)]; %consider the image from column 2 and later 
                    diff = ((image)-(img_x1)).^2; %calculate squared difference between original image and image in img_x1
                    diff1 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3); %add difference for rgb. (Sum of squared difference)
                    %for neighbors (x,y) and (x,y+1)
                    img_y1 = [image(2:end,:, :) ;zeros(1,wd,col)]; %consider image from row 2 and later
                    diff = ((image)-(img_y1)).^2;   %calculate squared diff between original image and img_y1
                    diff2 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3); %sum of squared differences
                case 8
                    %for neighbors (x,y) and (x+1, y+1)
                    img_x1 = [image(2:end,2:end, :) zeros(ht-1,1,col); zeros(1, wd, col)]; %create image for x+1, y+1
                    diff = ((image)-(img_x1)).^2; %calculate difference 
                    diff1 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3); %sum of squared difference
                    %for neighbors (x,y) and (x-1, y-1)
                    img_y1 = zeros(ht, wd, col);   
                    img_y1(2:end,2:end,:) = image(1:end-1,1:end-1, :); %create image for x-1, y-1 
                    diff = ((image)-(img_y1)).^2;   %squared difference 
                    diff2 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3);    %sum of squared difference
                otherwise
                    disp('Please select 4/ 8 neighbor pairs');
            end
        case 'Grayscale'
            img_gray = rgb2gray(image); %convert to grayscale
            %plot grayscale image and histogram
            subplot(211); 
            imshow(img_gray);
            subplot(212); 
            imhist(img_gray);
            %choose between neighbors
            switch(neighbor)
                case 4
                    %for neighbors (x,y) and (x+1,y) 
                    img_gray_x1 = [img_gray(:, 2:end) zeros(ht,1)]; %x+1, y - image
                    diff1 = ((img_gray)-(img_gray_x1)).^2;  %squared difference between 'intensities'
                    %for neighbors (x,y) and (x,y+1) 
                    img_gray_y1 = [img_gray(2:end, :); zeros(1, wd)];   
                    diff2 = ((img_gray)-(img_gray_y1)).^2;  %squared difference between intensities 
                case 8
                    %for neighbors (x,y) and (x+1,y+1) 
                    img_gray_x1 = [img_gray(2:end, 2:end) zeros(ht-1,1); zeros(1,wd)];
                    diff1 = ((img_gray)-(img_gray_x1)).^2;  %squared difference between intensities
                    %for neighbors (x,y) and (x-1,y-1) 
                    img_gray_y1 = zeros(ht, wd);
                    img_gray_y1(2:end, 2:end) = img_gray(1:end-1, 1:end-1);
                    diff2 = ((img_gray)-(img_gray_y1)).^2;  %squared difference between intensities
                otherwise
                    disp('Please select 4/ 8 neighbor pairs');
            end
        case 'HSV'
            img_hsv = rgb2hsv(image); %convert to hsv
            %plot hsv image and histogram 
            subplot(211); 
            imshow(img_hsv);
            subplot(212); 
            bar(imhist(img_hsv(:,:,1)), 'y'); hold on;
            bar(imhist(img_hsv(:,:,2)), 'm'); hold on;
            bar(imhist(img_hsv(:,:,3)), 'c'); hold on; legend('Hue', 'Saturation', 'Value'); hold off;
            switch(neighbor)
                case 4
                    %for neighbors (x,y) and (x+1,y) 
                    img_hsv_x1 = [img_hsv(:, 2:end,3) zeros(ht,1)];
                    diff = ((image)-(img_hsv_x1)).^2; %calculate squared difference between original image and image in img_x1
                    diff1 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3); %add difference for rgb. (Sum of squared difference)
                    %for neighbors (x,y) and (x,y+1) 
                    img_hsv_y1 = [img_hsv(2:end, :,3); zeros(1, wd)];   %squared difference between neighboring 'values'
                    diff = ((image)-(img_hsv_y1)).^2; %calculate squared difference between original image and image in img_x1
                    diff2 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3); %add difference for rgb. (Sum of squared difference)
                case 8
                    %for neighbors (x,y) and (x+1,y+1) 
                    img_hsv_x1 = [img_hsv(2:end, 2:end,3) zeros(ht-1,1); zeros(1,wd)];  
                    diff = ((image)-(img_hsv_x1)).^2; %calculate squared difference between original image and image in img_x1
                    diff1 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3); %add difference for rgb. (Sum of squared difference)
                    %for neighbors (x,y) and (x-1,y-1) 
                    img_hsv_y1 = zeros(ht, wd, 'double');
                    img_hsv_y1(2:end, 2:end,3) = img_hsv(1:end-1, 1:end-1,3);   
                    diff = ((image)-(img_hsv_y1)).^2; %calculate squared difference between original image and image in img_x1
                    diff2 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3); %add difference for rgb. (Sum of squared difference)
                otherwise
                    disp('Please select 4/ 8 neighbor pairs');
            end
        case 'La*b*'
            img_lab = rgb2lab(image);   %convert to La*b*
            %plot La*b* image and its histogram
            subplot(211); 
            imshow(img_lab);
            subplot(212); 
            bar(imhist(img_lab(:,:,1)), 'm'); hold on;
            bar(imhist(img_lab(:,:,2)), 'g'); hold on;
            bar(imhist(img_lab(:,:,3)), 'c'); hold on; legend('L', 'a*', 'b*'); hold off;
            switch(neighbor)
                case 4
                    %for neighbors (x,y) and (x+1,y) 
                    img_lab_x1 = [img_lab(:, 2:end,1) zeros(ht,1)];
                    diff = ((image)-(img_lab_x1)).^2; %calculate squared difference between original image and image in img_x1
                    diff1 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3); %add difference for rgb. (Sum of squared difference)
                    %for neighbors (x,y) and (x,y+1) 
                    img_lab_y1 = [img_lab(2:end, :,1); zeros(1, wd)];
                    diff = ((image)-(img_lab_y1)).^2; %calculate squared difference between original image and image in img_x1
                    diff2 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3); %add difference for rgb. (Sum of squared difference)
                case 8
                    %for neighbors (x,y) and (x+1,y+1) 
                    img_lab_x1 = [img_lab(2:end, 2:end,1) zeros(ht-1,1); zeros(1,wd)];
                    diff = ((image)-(img_lab_x1)).^2; %calculate squared difference between original image and image in img_x1
                    diff1 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3); %add difference for rgb. (Sum of squared difference)
                    %for neighbors (x,y) and (x-1,y-1) 
                    img_lab_y1 = zeros(ht, wd, 'double');
                    img_lab_y1(2:end, 2:end,3) = img_lab(1:end-1, 1:end-1,3);
                    diff = ((image)-(img_lab_y1)).^2; %calculate squared difference between original image and image in img_x1
                    diff2 = diff(:,:,1)+diff(:,:,2)+diff(:,:,3); %add difference for rgb. (Sum of squared difference)
                otherwise
                    disp('Please select 4/ 8 neighbor pairs');
            end
        otherwise
    end
end