% Part 1.2
function inOut = gaussianConv(imagePath, sigma_x, sigma_y)
  img = im2double(imread(imagePath));

  G_x = gaussian(sigma_x);
  G_y = gaussian(sigma_y);

  G = G_x.' *  G_y;

  inOut = conv2(img, G, 'same');
  
  Gd = gaussianDer(G_x, sigma_x);
end