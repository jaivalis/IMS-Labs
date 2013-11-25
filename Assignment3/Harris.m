% function H = Harris(img)
% Harris Corner Detector implementation
%
% INPUT
% img: image to detect edges
%
% OUTPUT
% H - binary corner matrix (1 if corner 0 otherwise)
% r - corner row vector (contains the x-coordinate of all the corners)
% c - corner column vector (contains the y-coordinate of all the corners)
function [ H, r, c ] = Harris(img)
  original = img / 255;
  k = .04;
  threshold = 0.0000001;
  n = 9; % window size
  
  sigma = 2;  
%   for sIndex = 1:length(sigmas),
%     sigma = sigmas(sIndex);
    
  % compute Gaussian & Gaussian derivative
  G  = gaussian(sigma);
  Gd = gaussianDer(G, sigma);

  % compute derivatives of image
  % I_x: the derivative over the x direction
  % I_y: the derivative over the y direction
  I_x = conv2(G, Gd, img);
  I_y = conv2(Gd, G, img);

  % Q matrix
  % A can be obtained by squaring Ix then convolving it with a Gaussian
  A = conv2(I_x .^ 2,   G, 'same');
  B = conv2(I_x .* I_y, G, 'same');
  C = conv2(I_y .^ 2,   G, 'same');

  % compute det_Q
  det_Q = (A .* C) - (B .^ 2);
  % compute trace_Q
  trace_Q = (A .* C);

  H = det_Q - k * trace_Q .^ 2;

  H = (H > threshold);
  H = findCorners(H, n, threshold);
  
  % Populate r & c
  H_size = size(H);
  h_out = original;
  index = 1;
  for x = 1:H_size(1),
    for y = 1:H_size(2),
      if H(x, y) == 1, % edge case
        r(index) = x;
        c(index) = y;
        h_out(x, y) = 1; % add highlight
        index = index + 1;
      end
    end
  end
  
  % Plotting
  figure; imshow(I_x); title('Partial derivative of I(x, y) w.r.t x');
  figure; imshow(I_y); title('Partial derivative of I(x, y) w.r.t y');
  figure; imshow(h_out); 
  title('Original image with corner points plotted on it');
end