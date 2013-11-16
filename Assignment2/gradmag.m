% Part 1.5

% Returns two images with the magnitude and orientation of the gradient for
% each pixel of the input image.

% http://www.seas.upenn.edu/~cse399b/Lectures/CSE399b-04-edge.pdf

% http://www.swarthmore.edu/NatSci/mzucker1/e27/filter-slides.pdf (from page 23 on)
function [magnitude, orientation] = gradmag(img, sigma) 
  % taking derivatives of an image produces noise.
  % solution: first smooth by gaussian and then derivative
  
  imgPath = 'img1.jpg';
  smoothed_image = gaussianConv(imgPath, sigma, sigma);
  [gx,gy] = gradient(smoothed_image);
  magnitude = sqrt(gx.*gx+gy.*gy);
  orientation = atan2(gx, gy);
  
  % supposed to be the same
  G_x = gaussian(sigma);
  G_y = gaussian(sigma);
  %G = G_x.' *  G_y;
  Gd_x = gaussianDer(G_x, sigma);
  Gd_y = gaussianDer(G_y, sigma);
  
  % taking the derivative in x of the image can be done by convolution
  % with the derivative of a Gaussian
  grad_filtered_img_x = conv2(img, Gd_x, 'same');
  grad_filtered_img_y = conv2(img, Gd_y, 'same');
  magnitude2 = sqrt(grad_filtered_img_x.*grad_filtered_img_x+grad_filtered_img_y.*grad_filtered_img_y);
  orientation2 = atan2(grad_filtered_img_x,grad_filtered_img_y);
  
  % Test:
  isequal(magnitude, magnitude2)
  isequal(orientation, orientation2)
  
  
  
  
  
  
  
  
  
  
  
  
  
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