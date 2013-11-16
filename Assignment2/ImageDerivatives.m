%(type : 'x', 'y', 'xx', 'yy', 'xy', 'yx')
function F=ImageDerivatives(img,sigma ,type)
  G = gaussian(sigma);
  switch type
      case 'x'
          
      case 'y'
          
      case 'xx'
          
      case 'yy'
          
      case 'xy'
          
      case 'yx'
          
  end
  filterRange = -sigma:sigma;
  index = 1;
  Gd = zeros(1, 2*sigma + 1);
  for x = filterRange,
    Gd(index) = G(index) * ((-sigma^2 + x^2) / sigma^4);
    index = index + 1;
  end
  
  
end