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
  Sol_reshaped = [x(1), x(2), 0; x(3), x(4), 0; x(5), x(6), 1];
  
  [ height, width ] = size(img);
  trnsfrmd = zeros( height, width, 1 );
  
  shiftedPixels = 0;
  for i = 1:height,
    for j = 1:width,
      % Applying affine transformation
      new_coord = Sol_reshaped * [i; j; 1];

      % Nearest-Neighbor interpolation for placing new pixels
      xTarget = round( new_coord(1) );
      yTarget = round( new_coord(2) ) + shiftedPixels;

      if xTarget > 0 && yTarget > 0
        trnsfrmd( xTarget, yTarget ) = img( i, j );
      else
        [ currHeight, ~ ] = size( trnsfrmd );        
        shiftedPixels  = shiftedPixels + abs(yTarget);
        % Shift the picture to the right & resize
        trnsfrmd = cat( 2, zeros( currHeight, abs(yTarget) ), trnsfrmd );        
        trnsfrmd( xTarget, 1 ) = img( i, j );
      end
    end
  end
end