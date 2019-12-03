clc 
clear
close all
image=im2double(imread('TestImages4Project\butterfly.jpg'));
gray=rgb2gray(image);
imshow(gray)
image_gauss=gray;
[rows,columns]=size(gray);
sigma=1.2;
k=sqrt(2);
level=4;
gPyr={};
for i=1:level
    filter=((sigma)^2)*fspecial('log',(2*ceil(3*sigma)+1),sigma);
    response=((imfilter(image_gauss,filter,'same','replicate')).^2)*255;
    scale_space_temp(:,:,i) = response;
    figure;
    imshow(uint8(response));
    sigma=sigma*k^(i);
end
gPyr=[gPyr;scale_space_temp];
x=scale_space_temp(:,:,3);
%mx = ordfilt2(scale_space_temp(:,:,3),9,ones(3,3)) ;
%imshow(uint8(mx))
k=2;
for i = 2:size(gray,1)-3
    for j = 2:size(gray,2)-3
        z=max(max(max(scale_space_temp(i-1:i+1,j-1:j+1,k-1:k+1))));
        scale_space_temp1(i,j,1)=z;
    end
end
figure;
imshow(uint8(scale_space_temp1(:,:,1)))
