function transfrm = transformImg( img, x )
%TRANSFORMIMG Performs a transformation of an image according to x vector
%   Detailed explanation goes here
%
% INPUT
% - img:    image to be transformed
% - x:      vector containing the transformations to be made
% 
% OUTPUT not sure yet
% - transfrmdImg: the most accurate transformation of the image achieved.

% m1 = x(1, 1);
% m2 = x(1, 2);
% m3 = x(1, 3);
% m4 = x(1, 4);
% t1 = x(1, 5);
% t2 = x(1, 6);

transfrm = img .* x;

end

