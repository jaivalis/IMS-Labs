image_count = 6;

for i=1:image_count,  
  path = strcat('../img',num2str(i),'.pgm');  
  img = imread(path);
  
  if size(img, 3) ~= 3,
    grayImg = single( img );
  else
    grayImg = single(rgb2gray( img ));
  end
  img_size = size(grayImg);
  SiftSingle.grayImg = grayImg;
  I(i) = SiftSingle;
end

% figure;
% imshow(img1);

% frames = zeros(image_count, img_size(1), img_size(2));
% desc = zeros(image_count, img_size(1), img_size(2));
for i=1:image_count,
%   img = single(reshape(I(i, :, :), img_size(1), img_size(2)));
  img = I(i).grayImg;
  [ frames, desc ]    = vl_sift( img );
  
  
end

for i = 1:image_count,
  
end