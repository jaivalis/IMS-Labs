% function H = gaussianDer2(G,sigma)
% Computes the second derivative of a given gaussian
%
% INPUT
% img: image to detect edges
%
% OUTPUT
% H
function [ H, r, c ] = Harris(img)
  k = .04;
  threshold = 0.0000001;
  n = 9; % window size
  
  sigmas = [2];
  
  for sIndex = 1:length(sigmas),
    sigma = sigmas(sIndex);
    
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
  end
  r = 0;
  c = 0;
end