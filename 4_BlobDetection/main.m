clc; close all;
tic;
image = imread('TestImages4Project\fishes.jpg');
grayImg = im2double(rgb2gray(image));
sigma=0.707; %1.4 dinesh
k=sqrt(2);
octaves = 1;
intervals = 17;
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
% l = cell(octaves,1);
% d = cell(octaves, 1);
% maximas = cell(octaves,1);
% sigma_op = sigma;
% for oct = 1:octaves
%     [rows,columns]=size(grayImg);
%     for i=1:intervals+3
%         filter = genKernel('gaussian',(2*ceil(3*sigma_op)+1),sigma_op);
%         %image_gauss = padarray(image_gauss,[2 2],'constant');
% %         response=((imfilter(gray,filter)).^2);
%         l{oct}(:,:,i) = convolve(grayImg, filter, 2);
%         try 
%             d{oct}(:,:,i-1) = (l{oct}(:,:,i) - l{oct}(:,:,i-1)).^2;
%             figure;
%             imshow(d{oct}(:,:,i-1));
%         catch
%             continue
%         end
%         sigma_op=sigma*(k^i);
%     end
%     grayImg = downscale(l{oct}(:,:,end-2), 0.5);
% end

l = cell(octaves,1);
fsize = cell(octaves,1);
sigma_op = sigma;
for oct = 1:octaves
    [rows,columns]=size(grayImg);
    for i=1:intervals+1
        fsize{oct}(i) = 2*ceil(3*sigma_op)+1;
        sig{oct}(i) = sigma_op;
        filter = (sigma_op.^2)*log_kernel((2*ceil(3*sigma_op)+1),sigma_op);
        %image_gauss = padarray(image_gauss,[2 2],'constant');
%         response=((imfilter(gray,filter)).^2);
%         l{oct}(:,:,i) = convolve(grayImg, filter, 1);
        l{oct}(:,:,i) = convfreq(grayImg, filter);
        l{oct}(:,:,i) = l{oct}(:,:,i).^2;
%         try 
%             d{oct}(:,:,i-1) = (l{oct}(:,:,i) - l{oct}(:,:,i-1)).^2;
%             figure;
%             imshow(d{oct}(:,:,i-1));
%         catch
%             continue
%         end
%         figure;
%          imshow(l{oct}(:,:,i));
        sigma_op=sigma*(k^i);
    end
    sigma_oct = sigma*(2^oct);
%     grayImg = downscale(convolve(grayImg, genKernel('gaussian', (2*ceil(3*sigma_oct)+1), sigma_oct),1), 0.5);


% possible_maximas = [];
% 
% max_res = zeros(size(l{oct},1), size(l{oct},2),intervals+1);
% for i = 1:intervals+1
%     currImg = l{oct}(:,:,i);
%     threshold = 0.001;
%     mask_size = 5;
%     mx = ordfilt2(l{oct}(:,:,i), mask_size^2, ones(mask_size));   
%     max_res(:,:,i) = (l{oct}(:,:,i)==mx)&(l{oct}(:,:,i)>threshold);
%     [r,c] = find(max_res(:,:,i));
%     possible_maximas = [possible_maximas, {[r,c]}];
% end
% 
max_x = [];
max_y = [];
max_r = [];
% for intr = 2:intervals
%     currMaxLvl = possible_maximas(intr);
%     currentMaxCell = currMaxLvl{1};
%     numFound = size(currentMaxCell);
%     filterSize = fsize{oct}(intr);
%     current_radius = sig{oct}(intr)*sqrt(2);
%     image_size = size(l{oct},1:2);
%     ['level: ' num2str(intr) ' radius: ' num2str(current_radius) ' filter: ' num2str(filterSize)]
%     for i=1 : numFound(1)
%         current_point = currentMaxCell(i,:);
%         x = current_point(1);
%         y = current_point(2);
%         % drop the max positions that are too close to the edge of the image
%         if(x <= filterSize || x > image_size(1)-filterSize)
%             continue;
%         end
%         if(y <= filterSize || y > image_size(2)-filterSize)
%             continue;
%         end
%         local_max = l{oct}(x,y,intr);
%         upper_vals = [ l{oct}(x-filterSize:x+filterSize, y-filterSize:y+filterSize, intr+1) ];
%         upper_max = max(upper_vals(:));
% 
%         lower_vals = [ l{oct}(x-filterSize:x+filterSize, y-filterSize:y+filterSize, intr-1) ];
%         lower_max = max(lower_vals(:));
% 
%         if( (local_max > upper_max) && (local_max > lower_max))
%             max_x = [max_x, [x]];
%             max_y = [max_y, [y]];
%             max_r = [max_r, [current_radius]];
%         end
%     end
% end

% for intr = 1:intervals
%     figure(intr);
%     subplot(211);
%     imagesc(l{oct}(:,:,intr));
%     subplot(212)
%     imagesc(max_res(:,:,intr));
% end
[max_x, max_y, max_r] = nms(l, fsize, sig, oct, intervals, max_x, max_y, max_r);
figure(intr+1)
imshow(rgb2gray(image)); hold on;
for i = 1:length(max_x)
% drawcircle('Center', [max_x(i), max_y(i)], 'Radius', max_r(i), 'Color' , [1 0 0], 'Selected', false);
    circs(max_y(i), max_x(i), max_r(i));
end
% for oct = 1:octaves
%     for i = 2:length(d{oct})-1
%         
%     end
% end
end
toc