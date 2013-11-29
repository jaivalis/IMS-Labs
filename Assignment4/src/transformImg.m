function transfrm = transformImg( matches, f1, x )
%TRANSFORMIMG Performs a transformation of an image according to x vector
%   Detailed explanation goes here
%
% INPUT
% - matches: matches between two images as calculated by vl_sift
% - f1:      pairs to be transformed
% - x:       vector containing the transformations to be made
% 
% OUTPUT not sure yet
% - transfrmdImg: the most accurate transformation of the image achieved.

m1 = x(1, 1);   m2 = x(1, 2);
m3 = x(1, 3);   m4 = x(1, 4);

M = [ [ m1, m2 ]; [ m3, m4 ] ];

t1 = x(1, 5);   t2 = x(1, 6);

t = [ t1; t2 ];

transfrm = zeros (length(matches), 2);
for i = 1:length(matches),
  x = f1( 1, matches(1, i) );
  y = f1( 2, matches(1, i) );
  
  z = M .* [ x; y ] + t;
  
  transfrm(i, 1) = z( 1 );
  transfrm(i, 2) = z( 2 );  
end

end