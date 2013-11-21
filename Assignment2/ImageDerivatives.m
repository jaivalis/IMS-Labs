%(type : 'x', 'y', 'xx', 'yy', 'xy', 'yx')
function F= ImageDerivatives ( img , sigma , type )
  % Compute gaussian
  G = gaussian(sigma);

  % Compute first derivative
  Gd = gaussianDer(G, sigma);
  
  % Compute second derivative
  index = 1;
  Gdd = zeros(1, 2*sigma + 1);
  for x = -sigma:sigma,
    Gdd(index) = G(index) * ( ( x^2 - sigma^2 ) / (sigma^4) );
    index = index + 1;
  end
    
  switch type
    case 'x'
      F = conv2(img, Gd, 'same');
      
    case 'y'
      F = conv2(img, Gd.', 'same');
      
    case 'xx'
      F = conv2(img, Gdd, 'same');
      
    case 'yy'
      F = conv2(img, Gdd.', 'same');
      
    case {'xy', 'yx'}
      F = conv2(img, Gd, 'same');
      
    otherwise
      error('Invalid type.');
  end
end