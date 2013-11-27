function [A, regions] = createRegion(img, region_size)
% CREATEREGION process given image to return compounds needed for flow
%
% INPUT
% img
% region_size: size of region in pixels
%
% OUTPUT
% A: matrix A of equation (18)
% regions: matrix containing region_size x region_size images (regions)
  img_size = size(img);
  sigma = 2;
  % compute Gaussian & Gaussian derivative
  G  = gaussian(sigma);
  Gd = gaussianDer(G, sigma);
  % compute derivatives of the whole image
  Image_x = conv2(G, Gd, img);
  Image_x = Image_x(sigma:img_size(1) + sigma, sigma:img_size(2) + sigma);
  Image_y = conv2(Gd, G, img);
  Image_y = Image_y(sigma:img_size(1) + sigma, sigma:img_size(2) + sigma);
  
  % divide picture in non-overlapping regions
  region_size = 15;
  region_count = floor(img_size / region_size);
  regions = zeros(region_count(1) * region_count(2), region_size, region_size);
  I_x = zeros(region_count(1) * region_count(2), region_size, region_size);
  I_y = zeros(region_count(1) * region_count(2), region_size, region_size);
  index = 1;
  for j=1:region_count(1),
    for i = 1:region_count(2),
      xUpLeft = ((j-1) * region_size) + 1;
      xUpRight = xUpLeft + region_size - 1;
      yUpLeft = ((i-1) * region_size) + 1;
      yDownRight = yUpLeft + region_size - 1;

      ixregion = Image_x(xUpLeft:xUpRight, yUpLeft:yDownRight);
      iyregion = Image_y(xUpLeft:xUpRight, yUpLeft:yDownRight);
      region = img(xUpLeft:xUpRight, yUpLeft:yDownRight);

      regions(index, :, :) = region;
      I_x(index, :, :) = ixregion;
      I_y(index, :, :) = iyregion;
      index = index + 1;
    end
  end
  % compute A
  A = zeros(region_count(1) * region_count(2), region_size ^ 2, 2);
    
  for i = 1 : region_count(1) * region_count(2),
    index = 1;
    for j = 1 : region_size,
      for k = 1 : region_size,
        A(i, index,1) = I_x(i, j, k);
        A(i, index,2) = I_y(i, j, k);
        index = index + 1;
      end
    end
  end
end