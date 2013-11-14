%Factors into product of two 1D Gaussians
%slide 105 of lecture 3
%shape of output?

function inOut = gaussianConv(imagePath, sigma_x, sigma_y)
    img = im2double(imread(imagePath));
    imgSizeX = size(img, 1);
    imgSizeY = size(img, 2);
    G = zeros(imgSizeX, imgSizeY);
    for x=1:imgSizeX,
        for y=1:imgSizeY,
            G(x,y) = gaussian(sigma_x, x) * gaussian(sigma_y, y);
        end
    end
    inOut = conv2(img, G, 'same');
end