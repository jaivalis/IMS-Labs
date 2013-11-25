function H = findCorners( h, N, threshold )
% FINDCORNERS Will check use NxN windows to determine if the given pixel is
% an edge.
  h_size = size(h);
  H = zeros(h_size);
  
  n = floor(N/2);
  for x = 1:h_size(1),
    for y = 1:h_size(2),
      xUpLeft    = x-n;  yUpLeft    = x-n;
      xDownRight = x+n;  yDownRight = x+n;
      
      % Sanitize window borders
      if xUpLeft < 1,   xUpLeft = 1;   end
      if yUpLeft < 1,   yUpLeft = 1;   end
      if xDownRight > h_size(2), xDownRight = h_size(2);  end
      if yDownRight > h_size(2), yDownRight = h_size(2);  end
      
      window = h(xUpLeft:yUpLeft, xDownRight:yDownRight);
      window_size = size(window);
      flag = 1; % Assume it is an edge, flag = 1;
      for xx = 1:window_size(1),
        for yy = 1:window_size(2),
          if h(x,y) < window(xx, yy),
            flag = 0; % not an edge
            break;
          end
        end
        if flag == 0,
          break % check next pixel
        end
      end
%       imregionalmax()
      H(x, y) = flag;
    end
  end
  H = ~H; % Negate
end