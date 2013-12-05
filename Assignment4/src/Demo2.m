clear;
left = single(rgb2gray(imread('../left.jpg')));
right = single(rgb2gray(imread('../right.jpg')));

[ f1,   desc1 ] = vl_sift( left );
[ f2,   desc2 ] = vl_sift( right );
[ m,        ~ ] = vl_ubcmatch(desc1, desc2);
[ trfrmd, ~,   x ] = Ransac(left, right, m, f1, f2, 200, 0);

[ frames_trans, desc_trans ]  = vl_sift( single(trfrmd) );

% compute the offsets of transformed image 'right'
xOffset = round(x(3,1));
yOffset = round(x(3,2));

% Stitch the two images
[ tH, tW ] = size( trfrmd );
[ lH, lW ] = size( left );
corners    = findCorners( trfrmd );

% % solution 1:
% outputImg = trfrmd;
% % append necessary space above transformed image
% outputImg = cat(1, zeros(corners(1,2), tW), outputImg);
% [ oH, oW ] = size( outputImg );
% % append necessary space left of the transformed image
% outputImg = cat ( 2, zeros ( oH, lW + yOffset - 40 ), outputImg );
% % write the left image on top of the outputImg
% outputImg(1:lH, 1:lW) = left;

% solution 2:
outputImg = zeros(lH, 480);
outputImg(1:lH, 1:lW) = left;

[ tHeight, tWidth ] = size(trfrmd);

for i = 1:tHeight,
  for j = 1:tWidth,
    
    if (trfrmd(i, j) ~= 0),
      outputImg ( i - yOffset - 40, j - xOffset ) = trfrmd(i, j);
    end
  end
end


%     
fig = figure;
subplot(2,2,1);
imshow(left/255);
subplot(2,2,2);
imshow(right/255);
subplot(2,2,3);
imshow(outputImg/255);
saveas(fig, '../report/stich.jpg');