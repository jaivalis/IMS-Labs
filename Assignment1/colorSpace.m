function colorSpace(imageName, colorSpace)
   
img = imread(imageName);
imageSize = size(img);
width = imageSize(1);
height = imageSize(2);

redValue = img(:, :, 1);
greenValue = img(:, :, 2);
blueValue = img(:, :, 3);
%imshow(redValue);

%opponent color space
opp = zeros(width,height,3);
if (colorSpace == 1),
    for x=1:width,
        for y=1:height,
            opp1(x, y) = ((redValue(x, y) - greenValue(x, y)) / sqrt(2));
            opp2(x, y) = ((redValue(x, y) + greenValue(x, y) - 2 * blueValue(x, y))/ sqrt(6));
            opp3(x, y) = ((redValue(x, y) + greenValue(x, y) + blueValue(x, y))/ sqrt(3));
        end
    end
    figO = figure('name', 'Opponent color space');
    set(figO, 'name','Opponent color space');
    subplot(2, 2, 1);
    imshow(img);
    subplot(2, 2, 2);
    imshow(opp1);
    subplot(2, 2, 3);
    imshow(opp2);
    subplot(2, 2, 4);
    imshow(opp3);
end

%rgb color space
rgb = zeros(width,height,3);
if (colorSpace == 2),
    norm = img(:,:,1) + img(:,:,2) + img(:,:,3);
    rgb1 = double(img(:,:,1)./norm);
    rgb2 = double(img(:,:,2)./norm);
    rgb3 = double(img(:,:,3)./norm);
    figure('name', 'RGB color space');
    subplot(2, 2, 1);
    imshow(img);
    subplot(2, 2, 2);
    imshow(rgb1);
    subplot(2, 2, 3);
    imshow(rgb2);
    subplot(2, 2, 4);
    imshow(rgb3);
end


%hsv color space
if (colorSpace == 3),
    hsv_image = rgb2hsv(img);
    figure('name', 'HSV color space');
    subplot(2, 2, 1);
    imshow(hsv_image);
    subplot(2, 2, 2);
    imshow(hsv_image(:, :, 1));
    subplot(2, 2, 3);
    imshow(hsv_image(:, :, 2));
    subplot(2, 2, 4);
    imshow(hsv_image(:, :, 3));
end