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
    % divide picture in non-overlapping regions
    region_size = 15;
    img_size = size(img);
    region_count = floor(img_size(1) / region_size);
    regions = zeros(region_count^2, region_size, region_size);
    index = 1;
    for j=1:region_count,
        for i = 1:region_count,
            xUpLeft = ((j-1) * region_size) + 1;
            xUpRight = xUpLeft + region_size - 1;
            yUpLeft = ((i-1) * region_size) + 1;
            yDownRight = yUpLeft + region_size - 1;
            region = img(xUpLeft:xUpRight, yUpLeft:yDownRight);
            regions(index, :, :) = region;
            index = index + 1;
        end
    end
    % compute A
    A = zeros(region_count ^ 2, region_size ^ 2, 2);
    [I_x,I_y] = gradient(regions);
    for i = 1 : region_count ^ 2,
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