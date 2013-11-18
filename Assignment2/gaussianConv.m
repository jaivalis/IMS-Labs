% Part 1.2
function inOut = gaussianConv(imagePath, sigma_x, sigma_y)
  img = im2double(imread(imagePath));

  G_x = gaussian(sigma_x);
  G_y = gaussian(sigma_y);

  G = G_x.' *  G_y;
  % if rgb convolve for every channel
  if size(img, 3) == 3
      inOut = zeros(size(img));
      for i=1:3
        inOut = conv2(img(:,:,i), G, 'same');
      end
  % if grayscale convolve only grayscale image
  else
      inOut = conv2(img, G, 'same');
  end
  
  % what's that?
  % Gd = gaussianDer(G_x, sigma_x);
end