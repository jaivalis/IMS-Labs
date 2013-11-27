

% img1 = imread('person_toy/00000001.jpg');
% [ H, r, c ] = Harris(img1, 0);

% img2 = imread('sphere1.ppm');
% [ H, r, c ] = Harris(img2, 0);

img2 = imread('synth1.pgm');
[ H, r, c ] = Harris(img2, 0);