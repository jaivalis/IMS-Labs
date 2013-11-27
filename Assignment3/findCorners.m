function H = findCorners( h, N, threshold )
% FINDCORNERS Will check use NxN windows to determine if the given pixel is
% an edge.
  h_size = size(h);
  H = zeros(h_size);
  
  n = floor(N/2);
  
%   H = (h > threshold);
  for x = 1:h_size(1),
    for y = 1:h_size(2),
      if h(x, y) > threshold,
        H(x, y) = h(x, y);
      else
        H(x, y) = 0;
      end
    end
  end
  H = imregionalmax(H);
end