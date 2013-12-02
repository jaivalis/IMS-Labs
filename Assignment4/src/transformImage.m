function trnsfrmd = transformImage( img, x )
%TRANSFORMIMAGE Performs a transformation of an image given the parameters
%   Detailed explanation goes here
%
% INPUT
% - img:      Image to be transformed
% - x:        Transformation parameters
% 
% OUTPUT
% - trnsfrmd: Transformed image
% reshape bestSolution
  Sol_reshaped = [x(1), x(2), 0; ...
                  x(3), x(4), 0; ...
                  x(5), x(6), 1];
  
  [ height, width ] = size(img);
  im_translated = zeros( height, width, 1 );
  
  for x = 1:height,
    for y = 1:width,
      xOrigin = x;
      yOrigin = y;

      tmp = double([img(x) img(y) 1]) * double( Sol_reshaped );
      xDest = round( tmp(1) );
      yDest = round( tmp(2) );
      
      if xDest < 1 || yDest < 1% || xDest > 2 * height || yDest > 2 * width
        continue;
      end
      im_translated( xDest, yDest ) = img( xOrigin, yOrigin );
    end
  end

  trnsfrmd = im_translated;% / 255;

end