left = single(rgb2gray(imread('../left.jpg')));
right = single(rgb2gray(imread('../right.jpg')));

[ frames_left, desc_left ]    = vl_sift( left );
[ frames_right, desc_right ]  = vl_sift( right );
[ matches, ~ ] = vl_ubcmatch(desc_left, desc_right);
[ transImg1, x] = Ransac(left, right, matches, frames_left, frames_right, 200, 0);

[ frames_trans, desc_trans ]  = vl_sift( single(transImg1) );

outputImg = zeros(500, 500);

[ height, width ] = size(left);
outputImg(100:height + 99, 1:width) = left;

[ tHeight, tWidth ] = size(transImg1);
xOffset = round(x(3,1));
yOffset = round(x(3,2));
for i = 1:tHeight,
  for j = 1:tWidth,
    if (transImg1(i, j) ~= 0),
      outputImg ( i - xOffset - 100, j - xOffset ) = transImg1(i, j);
    end
  end
end
    
figure;
imshow(outputImg/255);    

% minx = 
% miny = 
% maxx = 
% maxy = 
% offset(1) = abs(ceil(transCorners(3, 1)));
% offset(2) = ceil(transCorners(2, 2));
% transCorners =  ceil(transCorners);
% transCorners(1, 2) = ceil(transCorners( 1, 2)) + offset(1);
% transCorners(2, 1) = ceil(transCorners( 2, 1)) + offset(1);
% transCorners(3, 1) = ceil(transCorners( 3, 1) + offset(1));
% % transCorners(4, 2) = ceil(transCorners( 4, 2) + offset(2));
% transCorners(4, 1) = ceil(transCorners( 4, 1) + offset(1));