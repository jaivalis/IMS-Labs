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
  if size(img, 3) == 3    % if img is rgb
    xMagn = zeros(size(img));
    yMagn = zeros(size(img));
    for i = 1:3         %  convolve for every channel
      xMagn(:,:,i) = conv2(img(:,:,i), Gd_x, 'same');
      yMagn(:,:,i) = conv2(img(:,:,i), Gd_y, 'same');
    end
  else                    % if grayscale convolve only grayscale image
    xMagn = conv2(double(img), Gd_x, 'same');
    yMagn = conv2(double(img), Gd_y, 'same');
  end
  magnitude = sqrt(xMagn .* xMagn + yMagn .* yMagn);
  orientation = atan2(xMagn, yMagn);
  
  % quiver plot should be rotated vertically. Screws up the rest of the
  % plots for some reason. To be commented if unnecesary. 
  %
  % CTRL + C to stop the rest of the program from running.
%   stepsize = 5;
%   figure;
%   quiver(stepsize+1:stepsize:size(img,2), 5+1:stepsize:size(img,1), ...
%                           xMagn(5+1:stepsize:end,5+1:stepsize:end), ...
%                           yMagn(5+1:stepsize:end,5+1:stepsize:end),2);
  title('Quiver plot');

end