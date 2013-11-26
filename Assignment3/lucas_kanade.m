function regions1 = lucas_kanade(img1, img2)
    img1 = img1 / 255;    
    img2 = img2 / 255;
    img_size = size(img1);
    region_size = 15;
    region_count = floor(img_size(1) / region_size);
    figure(1);    imshow(img1);
    figure(2);    imshow(img2);
    
    % 1. divide picture in non-overlapping regions
    % region = region_size x region_size;
%        
%     region_count = floor(img_size(1) / region_size);
%     regions = zeros(region_count^2, region_size, region_size);
%     index = 1;
%     for j=1:region_count,
%         for i = 1:region_count,
%             xUpLeft = ((j-1) * region_size) + 1;
%             xUpRight = xUpLeft + region_size - 1;
%             yUpLeft = ((i-1) * region_size) + 1;
%             yDownRight = yUpLeft + region_size - 1;
%             region = img(xUpLeft:xUpRight, yUpLeft:yDownRight);
%             regions(index, :, :) = region;
%             index = index + 1;
%         end
%     end
%     figure(2);
%     for i=1:region_count^2,
%       region = reshape(regions(i,:,:), 15, 15);
%       subplot(13, 13, i);
%       imshow(region);
%     end  
    
    % step 2: compute A, A_t and b
    [A1, regions1] = createRegion(img1, region_size);
    [A2, regions2] = createRegion(img2, region_size);
    
    % compute I_t
    I_t = regions2 - regions1;
    A_t1 = permute(A1, [1 3 2]);
    A_t2 = permute(A2, [1 3 2]);
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
   
    for i=1:region_count^2,
        first = reshape(A_t1(i, :, :), 2, region_size ^ 2);
        second = reshape(A1(i, :, :),region_size ^ 2,2);
        c(i, :, :) = first * second;
        inverse(i, :, :) = inv(reshape(c(i, :, :), 2, 2));
        temp(i, :, :) = reshape(inverse(i, :, :), 2, 2) * reshape(A_t1(i, :, :), 2, region_size ^ 2);
        
        v(i, :, :) = reshape(temp(i, :, :), 2, 225) * reshape(b(i, :, :), 225,1);
    end
    % reshape v to 13x13 regions
    v_reshaped = zeros(region_count, region_count, 2);
    index = 1;
    for i = 1 : region_count,
        for j = 1 : region_count,
            v_reshaped(i, j, :) = v(index, :);
            index = index + 1;
        end
    end
    
    u = zeros(region_count, region_count, 2);
    % create matrix with the same size of v_reshaped, but with coordinates
    % of of center of regions
    for j=1:region_count,
        for i = 1:region_count,
            xCenter = ((j-1) * region_size) + region_size/2;
            yCenter = ((i-1) * region_size) + region_size/2;
            u(i, j, 1) = xCenter;
            u(i, j, 2) = yCenter;
        end
    end
    size(u)
    size(v_reshaped)
    figure(3);
    quiver(u(:, :, 1), u(:, :, 2), v_reshaped(:, :, 1), v_reshaped(:, :, 2));
    set(gca,'YDir','reverse');
end