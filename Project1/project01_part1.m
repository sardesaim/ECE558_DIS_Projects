clc; close all; 
tic;
wolves = imread('wolves.png'); 
wolves_gray = rgb2gray(wolves);
wolves_hsv = rgb2hsv(wolves);
wolves_lab = rgb2lab(wolves);
subplot(221);
imshow(wolves);
subplot(222);
imshow(wolves_gray);
subplot(223);
imshow(wolves_hsv);
subplot(224);
imshow(wolves_lab); 

figure; 

subplot(4,1,1)
bar(imhist(wolves(:,:,1)), 'r'); hold on;
bar(imhist(wolves(:,:,2)), 'g'); hold on;
bar(imhist(wolves(:,:,3)), 'b'); hold on; legend('Red channel', 'Green Channel', 'Blue Channel'); hold off;
subplot(4,1,2)
imhist(wolves_gray);
subplot(4,1,3)
bar(imhist(wolves_hsv(:,:,1)), 'y'); hold on;
bar(imhist(wolves_hsv(:,:,2)), 'm'); hold on;
bar(imhist(wolves_hsv(:,:,3)), 'c'); hold on; legend('Hue', 'Saturation', 'Value'); hold off;
subplot(4,1,4)
bar(imhist(wolves_lab(:,:,1)), 'm'); hold on;
bar(imhist(wolves_lab(:,:,2)), 'g'); hold on;
bar(imhist(wolves_lab(:,:,3)), 'c'); hold on; legend('L', 'a*', 'b*'); hold off;

image_type = input('Which image you want to consider\na. RGB\nb. Grayscale\nc. HSV\nd. La*b*\n');
neighbor_type = input('Which neighbor type you want to consider\na. 4 - Neighbors\nb. 8 - Neighbors\nc. m - Neighbors\n'); 
switch(neighbor_type)
    case 4
        switch(image_type)
            case 'RGB'
                wolves_xplus1 = [wolves(:,2:end, :) zeros(size(wolves,1),1,size(wolves,3))];
                diff = (wolves-wolves_xplus1).^2;
                figure;
                subplot(2,2,1);
                imshow(diff);
                subplot(2,2,2);
                imhist(diff);
                wolves_xplus1 = [wolves(2:end,:, :) zeros(1,size(wolves,2),size(wolves,3))];
                diff = (wolves-wolves_yplus1).^2;
                subplot(2,2,3);
                imshow(diff);
                subplot(2,2,4);
                imhist(diff);
            case 'Grayscale' 
                wolves_gray_xplus1 = [wolves_gray(:, 2:end) zeros(size(wolves_gray, 1),1)];
                diff = (wolves_gray-wolves_gray_xplus1).^2;
                figure;
                subplot(2,2,1);
                imshow(diff);
                subplot(2,2,2);
                imhist(diff);
                wolves_gray_yplus1 = [wolves_gray(2:end, :) ;zeros(1,size(wolves_gray, 2))];
                diff = (wolves_gray-wolves_gray_yplus1).^2;
                subplot(2,2,3);
                imshow(diff);
                subplot(2,2,4);
                imhist(diff);
            case 'HSV' 
            case 'La*b*'
            otherwise
        end
    case 8 
    case 'm' 
    otherwise
end
toc;