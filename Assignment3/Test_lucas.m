img1 = double(rgb2gray(imread('sphere1.ppm')));
img2 = double(rgb2gray(imread('sphere2.ppm')));
img3 = double(imread('synth1.pgm'));
img4 = double(imread('synth2.pgm'));
Kanade(img1, img2);
Kanade(img3, img4);