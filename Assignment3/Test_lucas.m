img = double(rgb2gray(imread('sphere1.ppm')));
size(img);
I = lucas_kanade(img);