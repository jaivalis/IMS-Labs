image_count = 6;
for i=1:image_count,
  path = strcat('img',num2str(i),'.pgm');
  if size(img, 3) ~= 3,
    grayImg = ;
  else
    grayImg = double(rgb2gray(img));
  end
  img_size = size(img); 
  img(i, :, :) = single(rgb2gray(imread(path)));
end
% figure;
% imshow(img1);
for i=1:image_count,
  [frames(i), desc(i)] = vl_sift(img(i));
end

