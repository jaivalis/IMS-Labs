
imagesDir = 'pingpong/';
workingDir = pwd;

images = dir(fullfile(workingDir, imagesDir, '*.jpeg'));
imageNames = {images.name}';

img1Path = strcat(imagesDir, char(imageNames(1)));
img1 = imread( img1Path );

% Locate feature points on the first frame by using Harris Corner Detector
grayImg = double(rgb2gray( img1 ));
[ H, r, c ] = Harris( grayImg );

% Then, track these points with Lucas-Kanade method for optical flow
% estimation

