function [ H, r, c ] = Harris(img)
% HARRIS Corner Detector implementation
%
% INPUT
% img: image to detect edges
%
% OUTPUT
% H - binary corner matrix (1 if corner 0 otherwise)
% r - corner row vector (contains the x-coordinate of all the corners)
% c - corner column vector (contains the y-coordinate of all the corners)

  grayImg = double(rgb2gray(img));
  k = .04;
  threshold = 0.0000001;
  n = 9; % window size
  
  sigma = 2;  
    
  % compute Gaussian & Gaussian derivative
  G  = gaussian(sigma);
  Gd = gaussianDer(G, sigma);

  % compute derivatives of image
  % I_x: the derivative over the x direction
  % I_y: the derivative over the y direction
  I_x = conv2(G, Gd, grayImg);
  I_y = conv2(Gd, G, grayImg);

  % Q matrix
  % A can be obtained by squaring Ix then convolving it with a Gaussian
  A = conv2(I_x .^ 2,   G, 'same');
  B = conv2(I_x .* I_y, G, 'same');
  C = conv2(I_y .^ 2,   G, 'same');

  % compute Q matrix components > compute H
  det_Q = (A .* C) - (B .^ 2);
  trace_Q = (A .* C);
  H = det_Q - k * trace_Q .^ 2;

  % make use of threshold
  H = (H > threshold);
  H = findCorners(H, n, threshold);
  
  % Populate r & c
  H_size = size(H);
  h_out = img;
  index = 1;
  for x = 1:H_size(1),
    for y = 1:H_size(2),
      if H(x, y) == 1, % edge case
        r(index) = x;
        c(index) = y;
%         if x - 4 > 1 && y - 4 > 1,
        h_out(x, y) = 1; % add highlight
%         end
        index = index + 1;
      end
    end
  end
  
  % Plot
  figure; imshow(I_x); title('Partial derivative of I(x, y) w.r.t x');
  figure; imshow(I_y); title('Partial derivative of I(x, y) w.r.t y');
  figure; imshow(h_out); 
  title('Original image with corner points plotted on it');
end