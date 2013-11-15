%Assignment2
sigma_x = 1;
sigma_y = 1;

imagePath = 'img1.jpg';
inOut = gaussianConv(imagePath, sigma_x, sigma_y);

%compare implementation to matlabbuilt-in function
matlabG = fspecial('gaussian', sigma_x, 4);

img = im2double(imread(imagePath));
imOut = conv2(img, matlabG, 'same');
subplot(2, 1, 1);
imshow(inOut);
subplot(2, 1, 2);
imshow(imOut);