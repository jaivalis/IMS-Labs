function transfrm = transformLocations( matches, frame, x )
%TRANSFORMLOCATIONS transforms the locations of a given image
%   Detailed explanation goes here
%
% INPUT
% - matches: matches between two images as calculated by vl_sift
% - f1:      pairs to be transformed
% - x:       vector containing the transformations to be made
% 
% OUTPUT not sure yet
% - transfrmdImg: the most accurate transformation of the image achieved.

m1 = x(1, 1);   m2 = x(2, 1);
m3 = x(3, 1);   m4 = x(4, 1);

M = [ [ m1, m2 ]; [ m3, m4 ] ];

t1 = x(5, 1);   t2 = x(6, 1);

t = [ t1; t2 ];

transfrm = zeros (length(matches), 2);
for i = 1:length(matches),
  x = frame( 1, matches(1, i) );
  y = frame( 2, matches(1, i) );
  
  z = M * [ x; y ];
  
  transfrm(i, 1) = z( 1 ) + t1;
  transfrm(i, 2) = z( 2 ) + t2;
end

end