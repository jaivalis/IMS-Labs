%Factors into product of two 1D Gaussians
%slide 105 of lecture 3
%shape of output?

function inOut = gaussianConv(imagePath, sigma_x, sigma_y)
  img = im2double(imread(imagePath));

  G_x = gaussian(sigma_x);
  G_y = gaussian(sigma_y);

  G = G_x.' *  G_y;

  inOut = conv2(img, G, 'same');
end