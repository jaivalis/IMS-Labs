% Part 1.5

% Returns two images with the magnitude and orientation of the gradient for
% each pixel of the input image.

% http://www.seas.upenn.edu/~cse399b/Lectures/CSE399b-04-edge.pdf

% http://www.swarthmore.edu/NatSci/mzucker1/e27/filter-slides.pdf (from page 23 on)
function [magnitude, orientation] = gradmag(img, sigma) 
  % taking derivatives of an image produces noise.
  % solution: first smooth by gaussian and then derivative
  
  global imagePath;
  smoothed_image = gaussianConv(imagePath, sigma, sigma);
  [gx,gy] = gradient(smoothed_image);
  magnitude = sqrt(gx.*gx + gy.*gy);
  orientation = atan2(gx, gy);
  
%   % supposed to be the same
%   G_x = gaussian(sigma);
%   G_y = gaussian(sigma);
%   %G = G_x.' *  G_y;
%   Gd_x = gaussianDer(G_x, sigma);
%   Gd_y = gaussianDer(G_y, sigma);
%   
%   % taking the derivative in x of the image can be done by convolution
%   % with the derivative of a Gaussian
%     % if rgb convolve for every channel
%   if size(img, 3) == 3
%       filter_imx_x = zeros(size(img));
%       filter_imx_y = zeros(size(img));
%       for i = 1:3
%           filter_imx_x(:,:,i) = conv2(img(:,:,i), Gd_x, 'same');
%           filter_imx_y(:,:,i) = conv2(img(:,:,i), Gd_y, 'same');
%       end
%   % if grayscale convolve only grayscale image
%   else
%       filter_imx_x = conv2(img, Gd_x, 'same');
%       filter_imx_y = conv2(img, Gd_y, 'same');
%   end
%   magnitude2 = sqrt(filter_imx_x.*filter_imx_x+filter_imx_y.*filter_imx_y);
%   orientation2 = atan2(filter_imx_x,filter_imx_y);
%   
%   % Test:
%   isequal(magnitude, magnitude2)
%   isequal(orientation, orientation2)



  
%   TODO test function and delete if correct
%   magnitud = zeros(size(img));
%   orientatio = zeros(size(img));

%   img_dim = size(img);  
%   for x = 2:img_dim(1),
%     for y = 2:img_dim(2),
%       mag_x = img(x) - img(x - 1);
%       mag_y = img(y) - img(y - 1);
%       
%       mag = sqrt(gx.*gx+gy.*gy);
%       
%       magnitud(x,y) = norm(mag_x, mag_y);
% %       magnitude(x,y) = sqrt(mag_x^2 + mag_y^2);
% 
%       orientatio(x,y) = atan2(mag_y, mag_x);
%     end
%   end
%   magnitude = magnitud;
%   orientation = orientatio;
end