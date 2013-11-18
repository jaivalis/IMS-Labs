%Assignment2
sigma_x = 4;
sigma_y = 4;

global imagePath;
imagePath = 'Portrait_of_a_Proboscis_Monkey.jpg';
ourOutput = gaussianConv(imagePath, sigma_x, sigma_y);

%compare implementation to matlabbuilt-in function
matlabG = fspecial('gaussian', sigma_x, 4);

img = im2double(imread(imagePath));

% if rgb convolve for every channel
if size(img, 3) == 3
  matlabOutput = zeros(size(img));
  for i=1:3
        matlabOutput = conv2(img(:,:,i), matlabG, 'same');
  end
% if grayscale convolve only grayscale image
else
    matlabOutput = conv2(img, matlabG, 'same');
end

% 1.3
figure;
imshowpair(matlabOutput, ourOutput, 'montage');
title('Comparison of the Matlab built-in function of the gaussian filter (left) and our implementation (right). Both filters use sigma = 4');

% 1.4
[magnitude, orientation]  = gradmag(img, 1);

% 1.5.1
figure; imshow ( orientation ,[ -pi , pi ]);
figure; imshow ( magnitude );
colormap ( hsv );
colorbar;
% Visualize your result using Matlab quiver function.
%figure;
%quiver(X,Y,orientation(1),orientation(2));
%title('quiver');

% 1.5.2.1
for i=1:4,
    [magnitude, orientation]  = gradmag(img, i);
    subplot(2, 2, i);
    imshow( magnitude);
    title(strcat('sigma = ', num2str(i)));
    colormap ( hsv );
    colorbar;
end
% Answer: As sigma increases the pictures get darker(more redish, less
% orangish) and smoother.

% 1.5.2.2
figure;
for i=1:4,
    [magnitude, orientation]  = gradmag(img, i);
    subplot(2, 2, i);
    imshow( orientation ,[ -pi , pi ]);
    title(strcat('sigma = ', num2str(i)));
end
% ??? Answer: As sigma increases the images have less noise(less small,
% black dots). ??? really difficult to see

% 1.5.3
figure;
tresholds = [0.03 0.06 0.1];
sigma = 0.5;
img_size = size(img);
ind = 1;
for sigma=1:3,
    for tre=1:3
        [magnitude, orientation]  = gradmag(img, sigma);
        for i=1:img_size(1),
            for j=1:img_size(2),
                if magnitude(i,j) < tresholds(tre),
                    magnitude(i,j) = 0;
                end
            end
        end
        subplot(3,3, ind);
        imshow(magnitude);
        title(strcat('treshold = ', num2str(tresholds(tre)),', sigma = ', num2str(sigma)));
        ind = ind + 1;
    end
end
    