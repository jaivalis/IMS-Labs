%Assignment2
sigma_x = 4;
sigma_y = 4;

global imagePath;
imagePath = 'zebra.png';
ourOutput = gaussianConv(imagePath, sigma_x, sigma_y);

%compare implementation to matlabbuilt-in function
matlabG = fspecial('gaussian', 4, 4);

img = rgb2gray(imread(imagePath));

% if rgb, convolve for every channel
if size(img, 3) == 3
  matlabOutput = zeros(size(img));
  for i=1:3
        matlabOutput = conv2(img(:,:,i), matlabG, 'same');
  end
% if grayscale, convolve only grayscale image
else
    matlabOutput = conv2(double(img), matlabG, 'same');
end

% 1.3
figure;
imshowpair(matlabOutput, ourOutput, 'montage');
title('Comparison of the Matlab built-in function of the gaussian filter (left) and our implementation (right). Both filters use sigma = 4');

% 1.4
[magnitude, orientation]  = gradmag(img, 1);

%1.5.1 TODO delete this ?
%imshow(img,[]);
% img1 = fspecial('gaussian', 50, 5);
% figure;
% splot = 1;
% for sigma=[1,3,5,7,9]
%     G = gaussian(sigma);
%     kernel = gaussianDer(G, sigma);
%     Gx = conv2(double(img1), kernel, 'same');
%     Gy = conv2(double(img1), kernel', 'same');
%     subplot(5,1,splot);
%     quiver(Gx,Gy);
%     title(strcat('Quiver for sigma = ', sigma));
%     splot = splot + 1;
% end

% 1.5.2.1
f = figure;
for i=1:4,
    [magnitude, orientation]  = gradmag(img, i);
    subplot(2, 2, i);
    imshow( magnitude);
    colormap (hsv);
    colorbar;
    title(strcat('sigma = ', num2str(i)));
end
saveas(f,'magnitude.png')

% 1.5.2.2
f = figure;
for i=1:4,
    [magnitude, orientation] = gradmag(img, i);
    subplot(2, 2, i);
    imshow(orientation, [-pi, pi]);
    title(strcat('sigma = ', num2str(i)));
end
saveas(f,'orientation.png')

% 1.5.3
f = figure;
thresholds  = [1 5 10 15];
sigmas      = [1 2 4 8];

img_size = size(img);
plotNumber = 1;
for s = 1:length(sigmas),
  sigma = sigmas(s);
  
  for t = 1:length(thresholds),
    threshold = thresholds(t);
    
    [magnitude, orientation]  = gradmag(img, sigma);
    for i = 1:img_size(1),
      for j = 1:img_size(2),
        if magnitude(i,j) < threshold,
           magnitude(i,j) = 255;
        else 
           magnitude(i,j) = 0;
        end
      end
    end
    subplot(length(thresholds), length(sigmas), plotNumber);
    imshow(magnitude);
    %colormap(hsv);
    %colorbar;
    title(strcat('threshold = ', num2str(threshold),', sigma = ', num2str(sigma)));
    plotNumber = plotNumber + 1;
  end
end
saveas(f,'threshold.png')
% Create impulse image
impulse_size = 11;
impulse = zeros(impulse_size, impulse_size);

impulse(ceil(impulse_size/2), ceil(impulse_size/2)) = 255;
impulse = double(impulse);

figure;  imshow(impulse); title('Impulse Image');
it = 0;

sigmas = [1 ceil(impulse_size/2)];
sindex = 1;
subplots = length(sigmas)*2;

% f = figure;
% for sindex = 1:length(sigmas),
%   sigma = sigmas(sindex);
%   
%   img = ImageDerivatives(impulse, sigma, 'x');
%   subplot(subplots, 3, (sindex-1)*6 + 1);
%   imshow(img);  title(strcat('x, sigma = ', num2str(sigma)));
%   
%   
%   img = ImageDerivatives(impulse, sigma, 'y'); 
%   subplot(subplots, 3, (sindex-1)*6 + 2);
%   imshow(img);  title(strcat('y, sigma = ', num2str(sigma)));
%   
%   img = ImageDerivatives(impulse, sigma, 'xx'); 
%   subplot(subplots, 3, (sindex-1)*6 + 3);
%   imshow(img);  title(strcat('xx, sigma = ', num2str(sigma)));
%   
%   img = ImageDerivatives(impulse, sigma, 'yy'); 
%   subplot(subplots, 3, (sindex-1)*6 + 4);
%   imshow(img);  title(strcat('yy, sigma = ', num2str(sigma)));
%   
%   img = ImageDerivatives(impulse, sigma, 'xy'); 
%   subplot(subplots, 3, (sindex-1)*6 + 5);
%   imshow(img);  title(strcat('xy, sigma = ', num2str(sigma)));
%   
%   img = ImageDerivatives(impulse, sigma, 'yx'); 
%   subplot(subplots, 3, (sindex-1)*6 + 6);
%   imshow(img);  title(strcat('yx, sigma = ', num2str(sigma)));
%   it = it + 1;
% end
% saveas(f,'last.png')
last();