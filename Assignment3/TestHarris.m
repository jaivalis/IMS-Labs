

img1 = double(rgb2gray(imread('person_toy/00000001.jpg')));
[ H, r, c ] = Harris(img1);
figure; imshow(H);

img2 = double(rgb2gray(imread('sphere1.ppm')));
[ H, r, c ] = Harris(img2);
figure; imshow(H);