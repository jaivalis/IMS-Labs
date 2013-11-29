function inliers = countInliers( T, matches, f2, base )
%COUNTINLIERS counts the number of inliers
%   Inliers are defined as the number of transformed points from image T 
% that lie within a 10 pixel radius from their pair in img.
%
% INPUT not sure yet
% - T:       transformation of some image
% - matches: matches between two images as calculated by vl_sift
% - f2:      frames of image2
% 
% OUTPUT
% - inliers: scalar, count of inliers

sizeT = size( T );
inliers = 0;

for i = 1:T,
  % sort matches, so that points of img1 are in order
  % [X;Y;S;TH], where X,Y is the (fractional) center of the frame, S is the 
  % scale and TH is the orientation (in radians).
  xt     = T( i, 1 );
  yt     = T( i, 2 );
  xCntr  = f2(1, matches(2, i));
  yCntr  = f2(2, matches(2, i));
  radius = f2(3, matches(2, i));
  
  dist   = sqrt( (xt - xCntr)^2 + (yt - yCntr)^2 );
  
  if dist - radius < 10,
    inliers = inliers + 1;
  end
end

end