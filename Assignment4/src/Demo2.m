left = single(rgb2gray(imread('../left.jpg')));
right = single(rgb2gray(imread('../right.jpg')));

[ frames_left, desc_left ]    = vl_sift( left );
[ frames_right, desc_right ]    = vl_sift( right );
[ matches, scores ] = vl_ubcmatch(desc_left, desc_right);
[transImg, x] = Ransac(left, right, matches, frames_left, frames_right, 2, 0);
figure;
[height, width] = size(right);
upleft = [1 1];
upright = [height 1];
downleft = [1 width];
downright = [height width];
corners = [upleft; upright; downleft; downright];
for i=1:length(corners)
  temp = x * [corners(i, 1); corners(i, 2); 1];
  transCorners(i, :) = [temp(1) temp(2)];
end

% offset(1) = abs(ceil(transCorners(3, 1)));
% offset(2) = ceil(transCorners(2, 2));
% transCorners =  ceil(transCorners);
% transCorners(1, 2) = ceil(transCorners( 1, 2)) + offset(1);
% transCorners(2, 1) = ceil(transCorners( 2, 1)) + offset(1);
% transCorners(3, 1) = ceil(transCorners( 3, 1) + offset(1));
% % transCorners(4, 2) = ceil(transCorners( 4, 2) + offset(2));
% transCorners(4, 1) = ceil(transCorners( 4, 1) + offset(1));
transImg = transImg / 255;
imshow(transImg)
size(transImg)
size(left)
figure;
left = left / 255;
imshow(left)