%Assignment2
imagePath = 'img1.jpg';
inOut = gaussianConv(imagePath, 3, 3);

%compare implementation to matlabbuilt-in function
G = fspecial('gaussian', 1, 2);
img = im2double(imread(imagePath));
imOut = conv2(img ,G,'same');
subplot(2, 1, 1);
imshow(inOut);
subplot(2, 1, 2);
imshow(imOut);














%trying to figure out which n and sigma to use:
% figure;
% for n=1:10,
%     for sigma=1:10,
%         G = fspecial('gaussian', n, sigma);
%         imOut = conv2(img ,G,'same');
%         subplot(10, 10, ((n-1)*10) + sigma);
%         imshow(imOut);
%     end
% end