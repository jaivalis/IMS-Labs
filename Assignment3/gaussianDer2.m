% function Gdd = gaussianDer2(G,sigma)
% Computes the second derivative of a given gaussian
%
% INPUT
% G: Gaussian function
% sigma: sigma of the gaussian G
%
% OUTPUT
% Gdd:  Gaussian second derivative
function Gdd = gaussianDer2(G, sigma)
  Gdd = zeros(1, 2*sigma + 1); % Compute second derivative
  
  index = 1;
  for x = -sigma:sigma,
    Gdd(index) = G(index) * ( ( x^2 - sigma^2 ) / (sigma^4) );
    index = index + 1;
  end
end