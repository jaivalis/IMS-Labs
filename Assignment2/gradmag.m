% Part 1.5

% Returns two images with the magnitude and orientation of the gradient for
% each pixel of the input image.

% http://www.seas.upenn.edu/~cse399b/Lectures/CSE399b-04-edge.pdf
% http://www.swarthmore.edu/NatSci/mzucker1/e27/filter-slides.pdf (from page 23 on)
function [magnitude, orientation] = gradmag(img, sigma) 
  % taking derivatives of an image produces noise.
  % solution: first smooth by gaussian and then derivative
  
  % supposed to be the same
  G_x = gaussian(sigma);
  G_y = gaussian(sigma);
  %G = G_x.' *  G_y;
  Gd_x = gaussianDer(G_x, sigma);
  Gd_y = gaussianDer(G_y, sigma);
  
  % taking the derivative in x of the image can be done by convolution
  % with the derivative of a Gaussian
  if size(img, 3) == 3    % if rgb convolve for every channel
      filter_imx_x = zeros(size(img));
      filter_imx_y = zeros(size(img));
      for i = 1:3
          filter_imx_x(:,:,i) = conv2(img(:,:,i), Gd_x, 'same');
          filter_imx_y(:,:,i) = conv2(img(:,:,i), Gd_y, 'same');
      end
  else       % if grayscale convolve only grayscale image
      filter_imx_x = conv2(double(img), Gd_x, 'same');
      filter_imx_y = conv2(double(img), Gd_y, 'same');
  end
  magnitude = sqrt(filter_imx_x.*filter_imx_x + filter_imx_y.*filter_imx_y);
  orientation = atan2(filter_imx_x, filter_imx_y);
end