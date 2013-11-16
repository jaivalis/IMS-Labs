% Part 1.4

% Function that implements the first order derivative
function Gd = gaussianDer(G, sigma)
  filterRange = -sigma:sigma;
  index = 1;
  Gd = zeros(1, 2*sigma + 1);
  for x = filterRange,
    Gd(index) = G(index) * (-x / sigma^2);
    index = index + 1;
  end
end