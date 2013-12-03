left = single(rgb2gray(imread('../left.jpg')));
right = single(rgb2gray(imread('../right.jpg')));

[ frames_left, desc_left ]    = vl_sift( left );
[ frames_right, desc_right ]    = vl_sift( right );
[ matches, scores ] = vl_ubcmatch(desc_left, desc_right);
transImg = Ransac(left, right, matches, frames_left, frames_right, 2, 0);
figure;
imshowpair(right, transImg, 'montage')
size(transImg)
size(left)
figure;
left = left / 255;
imshow(left)