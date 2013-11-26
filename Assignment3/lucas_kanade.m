function regions1 = lucas_kanade(img1, img2)
    img1 = img1 / 255;    
    img2 = img2 / 255;
    img_size = size(img1);
    region_size = 15;
    region_count = floor(img_size(1) / region_size);
    figure(1);    imshow(img1);
    
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
    
    % 
    optical_flow = zeros(region_count, region_count);
    
    %partial derivatives of regions
    I_t = zeros(region_count, region_size, region_size);
    
    
    
    % step 2: compute A, A_t and b
%     [I_x,I_y] = gradient(regions);
%     A = [I_x,I_y];
    [A1, regions1] = createRegion(img1, region_size);
    [A2, regions2] = createRegion(img2, region_size);
    
    % not equal...
    isequal(A1, A2);
    
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
    % siz2(v) is supposed to be (:,2)
    % size(v)
%     for i=1:region_count,
%         [I_x(i, :, :),I_y(i, :, :)] = gradient(regions(i, :, :));
%     end
%     index = 1;
%     for l=1:region_count,
%         for i=1:region_size,
%             for j=1:region_size,
%                 A(l, index, :) = [I_x(l, i, j), I_y(l, i, j)];
%                 b(l, index) = - I_t(l, i, j);
%                 index = index + 1;
%             end
%         end
%     end
%     %A_t = A.';
    
    
end