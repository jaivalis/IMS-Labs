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
if (colorSpace == 1),
    opp1 = img;
    opp2 = img;
    opp3 = img;
    for x=1:width,
        for y=1:height,
            opp1(x, y ,1) = ((redValue(x, y) - greenValue(x, y)) / sqrt(2));
            opp2(x, y, 2) = ((redValue(x, y) + greenValue(x, y) - 2 * blueValue(x, y))/ sqrt(6));
            opp3(x, y ,3) = ((redValue(x, y) + greenValue(x, y) + blueValue(x, y))/ sqrt(3));
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
if (colorSpace == 2),
    rgb1 = img;
    rgb2 = img;
    rgb3 = img;
    for x=1:width,
        for y=1:height,
            norm = redValue(x, y) + greenValue(x, y) + blueValue(x, y);
            rgb1(x, y, 1) = double (redValue(x, y) / norm);
            rgb2(x, y, 2) = double (greenValue(x, y) / norm);
            rgb3(x, y, 3) = double (blueValue(x, y) / norm);
        end
    end
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
    hsvimage = rgb2hsv(img);
    hsv1 = img;
    hsv2 = img;
    hsv3 = img;
    hsv1(:,:,1) = hsvimage(:,:,1);
    hsv2(:,:,2) = hsvimage(:,:,2);
    hsv3(:,:,3) = hsvimage(:,:,3);
    figure('name', 'HSV color space');
    subplot(2, 2, 1);
    imshow(img);
    subplot(2, 2, 2);
    imshow(hsv1);
    subplot(2, 2, 3);
    imshow(hsv2);
    subplot(2, 2, 4);
    imshow(hsv3);
end