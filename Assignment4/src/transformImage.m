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
  
  sShiftedPixels = 0; % sideways shifted pixels
  vShiftedPixels = 0; % vertical shifted pixels
  for i = 1:height,
    for j = 1:width,
      % Applying affine transformation
      new_coord = Sol_reshaped * [i; j; 1];

      % Nearest-Neighbor interpolation for placing new pixels
      xTarget = round( new_coord(1) ) + vShiftedPixels;
      yTarget = round( new_coord(2) ) + sShiftedPixels;

      if xTarget > 0 && yTarget > 0
        trnsfrmd( xTarget, yTarget ) = img( i, j );
      else
        if ~(yTarget > 0)
          [ currHeight, ~ ] = size( trnsfrmd );        
          sShiftedPixels  = sShiftedPixels + abs(yTarget);
          % Shift the picture to the right & resize
          trnsfrmd = cat( 2, zeros( currHeight, abs(yTarget) ), trnsfrmd );        
          trnsfrmd( xTarget, 1 ) = img( i, j );
%           continue;
        end
        if ~(xTarget > 0)
          [ ~ , currWidth ] = size( trnsfrmd );        
          vShiftedPixels  = vShiftedPixels + abs(xTarget);
          % Shift the picture downwards & resize
          trnsfrmd = cat( 1, zeros( abs(xTarget), currWidth ), trnsfrmd );        
          trnsfrmd( 1, yTarget ) = img( i, j );
%           continue;
        end
      end
    end
  end
end