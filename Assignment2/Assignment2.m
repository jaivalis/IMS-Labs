%Assignment2
sigma_x = 4;
sigma_y = 4;

imagePath = 'img1.jpg';
ourOutput = gaussianConv(imagePath, sigma_x, sigma_y);

%compare implementation to matlabbuilt-in function
matlabG = fspecial('gaussian', sigma_x, 4);

img = im2double(imread(imagePath));

matlabOutput = conv2(img, matlabG, 'same');

% 1.3
figure; imshowpair(matlabOutput, ourOutput, 'montage');

% 1.4
[magnitude, orientation]  = gradmag(img, 0);

% 1.5.1
figure; imshow ( orientation ,[ -pi , pi ]);
figure; imshow ( magnitude );
colormap ( hsv );
colorbar;
