function colorSpace(imageName, colorSpace)
   
img = imread(imageName);
imageSize = size(img);
width = imageSize(1);
height = imageSize(2);

redValue = img(:,:,1);
greenValue = img(:, :, 2);
blueValue = img(:, :, 3);
%imshow(redValue);

%opponent color space
opp = zeros(width,height,3);
if (colorSpace == 1),
    for x=1:width,
        for y=1:height,
            opp1(x,y) = (redValue(x, y) - greenValue(x, y) / sqrt(2));
            opp2(x,y) = (redValue(x, y) + greenValue(x, y) - 2 * blueValue(x, y)/ sqrt(6));
            opp3(x,y) = (redValue(x, y) + greenValue(x, y) + blueValue(x, y)/ sqrt(3));
        end
    end
    subplot(2,2,1);
    imshow(img);
    subplot(2,2,2);
    imshow(opp1);
    subplot(2,2,3);
    imshow(opp2);
    subplot(2,2,4);
    imshow(opp3);
end

%rgb color space
rgb = zeros(width,height,3);
if (colorSpace == 2),
    for x=1:width,
        for y=1:height,
            rgb1(x,y) = redValue(x, y) / redValue(x, y) + greenValue(x, y) + blueValue(x, y);
            rgb2(x,y) = greenValue(x, y) / redValue(x, y) + greenValue(x, y) + blueValue(x, y);
            rgb3(x,y) = blueValue(x, y) / redValue(x, y) + greenValue(x, y) + blueValue(x, y);
        end
    end
    subplot(2,2,1);
    imshow(img);
    subplot(2,2,2);
    imshow(rgb1);
    subplot(2,2,3);
    imshow(rgb2);
    subplot(2,2,4);
    imshow(rgb3);
end


%hsv color space
if (colorSpace == 3),
    hsv_image = rgb2hsv(img); 
    subplot(1,2,1);
    imshow(img);
    subplot(1,2,2);
    imshow(hsv_image);
end