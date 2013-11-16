% Part 1.5

% Returns two images with the magnitude and orientation of the gradient for
% each pixel of the input image.

% http://www.seas.upenn.edu/~cse399b/Lectures/CSE399b-04-edge.pdf
function [magnitude, orientation] = gradmag(img, sigma)  
  [gx,gy] = gradient(img);
  magnitude = sqrt(gx.*gx+gy.*gy);
  
  orientation = atan2(gx, gy);
  
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