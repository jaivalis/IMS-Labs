%(type : 'x', 'y', 'xx', 'yy', 'xy', 'yx')
function F= ImageDerivatives ( img , sigma , type )
  G = gaussian(sigma);
   
switch type
    case {'x', 'y', 'xy','yx'}
        Gd = gaussianDer(G, sigma);
    case {'xx', 'yy'}
        filterRange = -sigma:sigma;
        index = 1;
        Gdd = zeros(1, 2*sigma + 1);
        for x = filterRange,
            Gdd(index) = ( ( -(sigma^2) + (x^2) ) / (sigma^4) ) * G(index);
            index = index + 1;
        end
end

switch type
    case 'x'
        F = conv2(img, Gd, 'same');
    case 'y'
        F = conv2(img, Gd', 'same');
    case 'xx'
        F = conv2(img, Gdd, 'same');
    case {'xy', 'yx'}
        F = conv2(Gd, Gd, img, 'same');
    case 'yy'
        F = conv2(img, Gdd', 'same');
    otherwise
        error('Unknown type: type must be in {x, y, xx, xy, yx, yy}');
end
end