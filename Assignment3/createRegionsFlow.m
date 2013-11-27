function [A, regions, r_rel, c_rel] = createRegionsFlow(img, r, c, region_size)
% GETRELEVANTREGIONS 
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
  img_size = size(img);
  sigma = 2;
  % compute Gaussian & Gaussian derivative
  G  = gaussian(sigma);
  Gd = gaussianDer(G, sigma);
  % compute gradient of the whole image
  Image_x = conv2(G, Gd, img);
  Image_x = Image_x(sigma:img_size(1) + sigma, sigma:img_size(2) + sigma);
  Image_y = conv2(Gd, G, img);
  Image_y = Image_y(sigma:img_size(1) + sigma, sigma:img_size(2) + sigma);

  index = 1;
  regions = zeros(length(r), region_size, region_size);
  r_rel = zeros(1, length(r));
  c_rel = zeros(1, length(c));
  I_x = zeros(length(r), region_size, region_size);
  I_y = zeros(length(r), region_size, region_size);
 
  for i=1:length(r),
    xCenter = r(i);
    yCenter = c(i);
    
    xUpLeft = xCenter - floor(region_size/2);
    xUpRight = xCenter + floor(region_size/2);
    yUpLeft = yCenter - floor(region_size/2);
    yDownLeft = yCenter + floor(region_size/2);
    
    % Edges are rendered unimportant
    if xUpLeft < 1 || yUpLeft < 1 || ... 
      xUpRight > img_size(1) || yDownLeft > img_size(2),
      continue;
    else
      % coordiates are valid
      r_rel(index) = xCenter;
      c_rel(index) = yCenter;
    end
    
    region = img(xUpLeft:xUpRight, yUpLeft:yDownLeft);
    Ixregion = Image_x(xUpLeft:xUpRight, yUpLeft:yDownLeft);
    Iyregion = Image_y(xUpLeft:xUpRight, yUpLeft:yDownLeft);
    
    regions(index, :, :) = region;
    I_x(index, :, :) = Ixregion;
    I_y(index, :, :) = Iyregion;
    index = index + 1;
  end
  
  region_count = index - 1;
    
    % compute A
  A = zeros(region_count, region_size ^ 2, 2);
    
  for i = 1 : region_count,
    index = 1;
    for j = 1 : region_size,
      for k = 1 : region_size,
        A(i, index, 1) = I_x(i, j, k);
        A(i, index, 2) = I_y(i, j, k);
        index = index + 1;
      end
    end
  end
  
  % filter out edges
  regions = regions(1:region_count, :, :);
  r_rel = r_rel(1:region_count);
  c_rel = c_rel(1:region_count);
end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    