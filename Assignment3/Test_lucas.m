img1 = imread('sphere1.ppm');
img2 = imread('sphere2.ppm');
img3 = double(imread('synth1.pgm'));
img4 = double(imread('synth2.pgm'));
[ centers, V ] = Kanade(img1, img2, 0);
[ centers, V ] = Kanade(img3, img4, 0);