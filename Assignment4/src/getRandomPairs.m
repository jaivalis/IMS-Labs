function pairs = getRandomPairs(matches, f1, f2)
% GETRANDOMPAIRS returns a matrix of size Px4 (P being random)
%   
% INPUT
% - matches: matches between img1, img2 as calculated by vl_sift
% - f1:      frames of image1
% - f2:      frames of image2
%
% OUTPUT
% - pairs:   matrix containing 3 random pairs of matching points

P = 3;% 3 random samples are enough to determine the rotation required.
pairs = zeros( P, 4 );

matches_upperBound = length( matches );
random = randi( matches_upperBound, 1, P );

random_matches = matches(:, random);

desc_frame1 = random_matches(1, :);
desc_frame2 = random_matches(2, :);

pairs(:, 1) = f1( 1, desc_frame1 ); % x
pairs(:, 2) = f1( 2, desc_frame1 ); % y
pairs(:, 3) = f2( 1, desc_frame2 ); % x'
pairs(:, 4) = f2( 2, desc_frame2 ); % y'

end