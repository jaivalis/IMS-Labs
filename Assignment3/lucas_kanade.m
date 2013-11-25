function regions = lucas_kanade(img)
    original = img / 255;    
    figure(1);    imshow(original);
    img_size = size(original);
    
    % 1. divide picture in non-overlapping regions
    % region = region_size x region_size;
    region_size = 15;    
    region_count = floor(img_size(1) / region_size);
    regions = zeros(region_count, region_size, region_size);
    for i = 1:region_count,
        xUpLeft = ((i-1) * region_size) + 1;
        xUpRight = xUpLeft + region_size - 1;        
        yUpLeft = xUpLeft;
        yDownRight = yUpLeft + region_size - 1;
        region = original(xUpLeft:xUpRight, yUpLeft:yDownRight);
        regions(i, :, :) = region;
    end
    
    figure(2);
    for i=1:region_count,
      region = reshape(regions(i,:,:), 15, 15);
      size(region)
      subplot(4, 4, i);
      imshow(region);
    end
    
    % 
    optical_flow = zeros(region_count, region_count);
    A = zeros(region_count, region_size^2, 2);
    b = zeros(region_count, region_size^2, 1);
    
    %partial derivatives of regions
    I_x = zeros(region_count, region_size, region_size);
    I_y = zeros(region_count, region_size, region_size);
    I_t = zeros(region_count, region_size, region_size);
    
    % 
    for i=1:region_count,
        [I_x(i, :, :),I_y(i, :, :)] = gradient(regions(i, :, :));
    end
    index = 1;
    for l=1:region_count,
        for i=1:region_size,
            for j=1:region_size,
                A(l, index, :) = [I_x(l, i, j), I_y(l, i, j)];
                b(l, index) = - I_t(l, i, j);
                index = index + 1;
            end
        end
    end
    %A_t = A.';
    
    
end