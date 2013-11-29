function [r, c, V] = KanadeFlow(img1, img2, r, c)
% KANADE Optical flow estimation for important points
%
% INPUT
% img1: baseline image
% img2: second image to find optical flow
% r: important corners of input img1
% c: 
%
% OUTPUT
% out: original picture with optical flow vectors of important points
% r: tracked point r in the next picture
% c: tracked point r in the next picture
  
  if size(img1,3) ~= 3,
    img1Grey = img1;
    img2Grey = img2;
  else
    img1Grey = double(rgb2gray(img1));
    img2Grey = double(rgb2gray(img2));
  end

  img1Grey = img1Grey / 255;    
  img2Grey = img2Grey / 255;
  img_size = size(img1Grey);
  region_size = 15;

  % 1. divide picture in non-overlapping regions
  % region = region_size x region_size;
  [A1, regions1, ~, ~] = createRegionsFlow(img1Grey, r, c, region_size);
  [A2, regions2, r, c] = createRegionsFlow(img2Grey, r, c, region_size);
  regions_size = size(regions1);
  region_count = regions_size(1);
  
  % compute I_t, transpose(A)
  I_t = regions2 - regions1;
  A_t = permute(A1, [1 3 2]);
  b_temp = - I_t;
  
  % 
  b = zeros(region_count, region_size ^ 2, 1);

  % compute v according to equation 20
    inverse = zeros(region_count, 2, 2);
    temp1 = zeros(region_count, 2, 2);
%     temp = zeros(region_count ^ 2, region_size ^ 2, 2);
    V = zeros(region_count, 2); % wrong shape in this case
    for i=1:region_count,
      
      % reshape b
      index = 1;
      for j = 1 : region_size,
          for k = 1 : region_size,
              b(i, index, 1) = b_temp(i, j, k);
              index = index + 1;
          end
      end
      
      first = reshape(A_t(i, :, :), 2, region_size ^ 2);
      second = reshape(A1(i, :, :),region_size ^ 2,2);
      temp1(i, :, :) = first * second;
      inverse(i, :, :) = pinv(reshape(temp1(i, :, :), 2, 2));
      temp(i, :, :) = reshape(inverse(i, :, :), 2, 2) *...
          reshape(A_t(i, :, :), 2, region_size ^ 2);

      V(i, :, :) = reshape(temp(i, :, :), 2, region_size ^ 2) *...
          reshape(b(i, :, :), region_size ^ 2,1);
    end
end