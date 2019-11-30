clc; close all;

image = imread('TestImages4Project\sunflowers.jpg');
grayImg = im2double(rgb2gray(image));
sigma=sqrt(1/2); %1.4 dinesh
k=sqrt(2);
octaves = 3;
intervals = 3;
% for oct = 1:octaves
%     [rows,columns]=size(grayImg);
%     l = cell(oct,1);
%     for i=1:intervals+1
%         filter = ((sigma)^2)*genKernel('log',(2*ceil(3*sigma)+1),sigma);
%         %image_gauss = padarray(image_gauss,[2 2],'constant');
% %         response=((imfilter(gray,filter)).^2);
%         l{oct}(:,:,i) = convolve(grayImg, filter, 2);
%         figure;
%         imshow(l{oct}(:,:,i));
%         sigma=sigma*k;
%     end
%     grayImg = downscale(grayImg, 0.5);
% end
l = cell(octaves,1);
d = cell(octaves, 1);
sigma_op = sigma;
for oct = 1:octaves
    [rows,columns]=size(grayImg);
    for i=1:intervals+3
        filter = genKernel('gaussian',(2*ceil(3*sigma_op)+1),sigma_op);
        %image_gauss = padarray(image_gauss,[2 2],'constant');
%         response=((imfilter(gray,filter)).^2);
        l{oct}(:,:,i) = convolve(grayImg, filter, 2);
        try 
            d{oct}(:,:,i-1) = l{oct}(:,:,i) - l{oct}(:,:,i-1);
            figure;
            imshow(d{oct}(:,:,i-1));
        catch
            continue
        end
        sigma_op=sigma*(k^i);
    end
    grayImg = downscale(l{oct}(:,:,end-2), 0.5);
end