function I = lucas_kanade(img)
    
    % 1. divide picture in non-overlapping regions
    % region = 15x15
    original = img / 255;
    img_size = size(img);
    figure(1);
    imshow(original);
    region_size = 15;
    nr_region = [floor(img_size(1) / region_size), floor(img_size(2) / region_size)];
    optical_flow = zeros(nr_region, nr_region);
    A = zeros(nr_region, region_size^2, 2);
    b = zeros(nr_region, region_size^2, 1);
    I = zeros(nr_region, region_size, region_size);
    for i=1:nr_region,
        k = ((i-1) * region_size) + 1;
        I(i, :, :) = original(k : i * region_size, k : i * region_size);
    end
    figure(2);
    for i=1:nr_region,
        subplot(4, 4, i);
        imshow(I(i));
    end
    
    %partial derivatives of regions
    I_x = zeros(nr_region, region_size, region_size);
    I_y = zeros(nr_region, region_size, region_size);
    I_t = zeros(nr_region, region_size, region_size);
    
    % 
    for i=1:nr_region,
        [I_x(i, :, :),I_y(i, :, :)] = gradient(I(i, :, :));
    end
    index = 1;
    for l=1:nr_region,
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