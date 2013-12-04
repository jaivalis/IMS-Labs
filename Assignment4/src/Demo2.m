left = single(rgb2gray(imread('../left.jpg')));
right = single(rgb2gray(imread('../right.jpg')));

[ f1,   desc1 ] = vl_sift( left );
[ f2,   desc2 ] = vl_sift( right );
[ m,        ~ ] = vl_ubcmatch(desc1, desc2);
[ trfrmd,   x ] = Ransac(left, right, m, f1, f2, 200, 0);

[ frames_trans, desc_trans ]  = vl_sift( single(trfrmd) );

% Stitch the two images
corners = findCorners( trfrmd );
[ tH, tW ] = size( trfrmd );
[ lH, lW ] = size( left );
corners    = findCorners( trfrmd );

outputImg = trfrmd;
xOffset = round(x(3,1))
yOffset = round(x(3,2))
outputImg = cat ( 2, zeros ( tH, lW + yOffset ), outputImg );
outputImg(1:lH, 1:lW) = left;

% 
% outputImg = zeros(500, 500);
% [ height, width ] = size(left);
% outputImg(100:height + 99, 1:width) = left;
% 
% [ tHeight, tWidth ] = size(transImg1);

% for i = 1:tHeight,
%   for j = 1:tWidth,
%     
%     if (transImg1(i, j) ~= 0),
%       outputImg ( i - yOffset + 60, j - xOffset ) = transImg1(i, j);
%     end
%   end
% end


%     
figure;
imshow(outputImg/255);