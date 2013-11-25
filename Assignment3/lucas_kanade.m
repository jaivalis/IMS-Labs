function I = lucas_kanade(img)
    
    %divide picture in non-overlapping regions
    %region = 15x15
    img_size = size(img);
    figure(1);
    imshow(img);
    A = zeros(225, 2);
    b = zeros(225, 1);
    region_size = 15;
    nr_region = [floor(img_size(1) / region_size), floor(img_size(2) / region_size)];
    optical_flow = zeros(nr_region, nr_region);
    I = zeros(nr_region, region_size, region_size);
    for i=1:nr_region,
        k = ((i-1) * region_size) + 1;
        I(i, :, :) = img(k : i * region_size, k : i * region_size);
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
    for i=1:nr_region,
        [I_x(i, :, :),I_y(i, :, :)] = gradient(I(i, :, :));
    end
    index = 1;
    for i=1:region_size^2,
        for j=1:region_size^2,
            A(index) = [I_x(i, j), I_y(i, j)];
            b(index) = - I_t(i, j);
            index = index + 1;
        end
    end
    A_t = A.';
    
    
end