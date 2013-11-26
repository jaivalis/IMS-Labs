function [ centers, V ] = Kanade(img1, img2, supressPlots)
% KANADE Optical flow estimation
%
% INPUT
% img1: baseline image
% img2: second image to find optical flow
% suppressPlots: if true will not plot
%
% OUTPUT
% out: original picture with optical flow vectors
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
    region_count = floor(img_size(1) / region_size);
    
    % 1. divide picture in non-overlapping regions
    % region = region_size x region_size;
    [A1, regions1] = createRegion(img1Grey, region_size);
    [A2, regions2] = createRegion(img2Grey, region_size);
    
    % compute I_t, transpose(A)
    I_t = regions2 - regions1;
    A_t = permute(A1, [1 3 2]);
    b_temp = - I_t;
    
    % reshape b
    b = zeros(region_count ^ 2, region_size ^ 2, 1);
    for i = 1 : region_count ^ 2,
        index = 1;
        for j = 1 : region_size,
            for k = 1 : region_size,
                b(i, index,1) = b_temp(i, j, k);
                index = index + 1;
            end
        end
    end
   
    % compute v according to equation 20
    inverse = zeros(region_count ^ 2, 2, 2);
    c = zeros(region_count ^ 2, 2, 2);
%     temp = zeros(region_count ^ 2, region_size ^ 2, 2);
    v = zeros(region_count ^ 2, 2); % wrong shape in this case
    for i=1:region_count^2,
        first = reshape(A_t(i, :, :), 2, region_size ^ 2);
        second = reshape(A1(i, :, :),region_size ^ 2,2);
        c(i, :, :) = first * second;
        inverse(i, :, :) = inv(reshape(c(i, :, :), 2, 2));
        temp(i, :, :) = reshape(inverse(i, :, :), 2, 2) *...
            reshape(A_t(i, :, :), 2, region_size ^ 2);
        
        v(i, :, :) = reshape(temp(i, :, :), 2, region_size ^ 2) *...
            reshape(b(i, :, :), region_size ^ 2,1);
    end
    
    % reshape v to 13x13 regions
    V = zeros(region_count, region_count, 2);
    index = 1;
    for i = 1 : region_count,
        for j = 1 : region_count,
            V(i, j, :) = v(index, :);
            index = index + 1;
        end
    end
    
    % create matrix with the same size of v_reshaped, but with coordinates
    % of of center of regions
    
    % the region centers, used for plotting
    centers = zeros(region_count, region_count, 2); 
    for j = 1:region_count,
        for i = 1:region_count,
            xCenter = ((j-1) * region_size) + region_size/2;
            yCenter = ((i-1) * region_size) + region_size/2;
            centers(i, j, 1) = xCenter;
            centers(i, j, 2) = yCenter;
        end
    end
    
    % Plot
    if ~supressPlots,
      figure;
      imshow(img1Grey);
      hold on
      quiver(centers(:, :, 1), centers(:, :, 2), V(:, :, 1), V(:, :, 2));
      hold off
      set(gca,'YDir','reverse');
    end
end