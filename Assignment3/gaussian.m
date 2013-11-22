% Part 1.1
function G = gaussian(sigma)
  filterSize = 2 * sigma + 1;

  G = zeros(1, filterSize);
  filterRange = -sigma:sigma;
  
  index = 1;
  for x = filterRange,
    G(index) = ( 1/( sigma*sqrt( 2*pi ) ) * exp ( -(x^2) / ( 2 * sigma^2 )));
    index = index + 1;
  end
end