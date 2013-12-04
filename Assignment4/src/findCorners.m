function C = findCorners( trnsfrmd )
%FINDCORNERS Finds the image corners of a given image's transformation
%   Given the transformation parameters, the transformation of the corner
%   points can be found.
% INPUT
% - trnsfrmd: Transformed image
% 
% OUTPUT
% - C:        Corners in this order: <ul, ur, dl, dr>

  [ H, W ] = size( trnsfrmd );
  C = zeros( 4, 2 );
  % up left:
  breakFlag = 0;
  for y = 1:H,
    for x = 1:W,    
      if trnsfrmd(x,y) ~= 0,
        C(1,1) = y;   C(1,2) = x;   breakFlag = 1;
        break;
      end
    end
    if breakFlag,   break;    end
  end
  % up right:
  breakFlag = 0;
  for x = 1:H,
    for y = W:-1:1,    
      if trnsfrmd(x,y) ~= 0,
        C(2,1) = y;   C(2,2) = x;   breakFlag = 1;
        break;
      end
    end
    if breakFlag,   break;    end
  end
  % down left:
  breakFlag = 0;
  for x = H:-1:1,
    for y = 1:W,    
      if trnsfrmd(x,y) ~= 0,
        C(3,1) = y;   C(3,2) = x;   breakFlag = 1;
        break;
      end
    end
    if breakFlag,   break;    end
  end
  % down right:
  breakFlag = 0;
  for y = W:-1:1, 
    for x = H:-1:1,   
      if trnsfrmd(x, y) ~= 0,
        C(4,1) = y;   C(4,2) = x;   breakFlag = 1;
        break;
      end
    end
    if breakFlag,   break;    end
  end

end

