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
  trnsfrmd = zeros( height, width, 1 );
  
  for i = 1:height
    for j = 1:width
      % Applying affine transformation
      new_coord = Sol_reshaped * [i; j; 1];

      % Nearest-Neighbor interpolation for placing new pixels
      if(round(new_coord(1)) > 0 && round(new_coord(2)) > 0)
          trnsfrmd(round(new_coord(1)), round(new_coord(2))) = img(i,j);
      end
    end
  end
  
end