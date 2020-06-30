a = im2double(rgb2gray(imread('TestImages4Project\butterfly.jpg')));
g = fspecial('gaussian', 100, 70);
tic; 
c = convfreq(a,g);
toc;
imshow(c);
