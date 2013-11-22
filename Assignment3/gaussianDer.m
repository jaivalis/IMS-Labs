% function Gd = gaussianDer(G,sigma)
% Computes the derivative of a given gaussian
%
% INPUT
% G: Gaussian function
% sigma: sigma of the gaussian G
%
% OUTPUT
% Gd:   Gaussian derivative
function Gd = gaussianDer(G, sigma)
  Gd = zeros(1, 2*sigma + 1);
  
  index = 1;
  for x = -sigma:sigma,
    Gd(index) = G(index) * (-x / sigma^2);
    index = index + 1;
  end
end