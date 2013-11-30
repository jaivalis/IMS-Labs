function pairs = getRandomPairs(matches, f1, f2)
% GETRANDOMPAIRS returns a matrix of size Px4 (P being random)
%   
% INPUT
% - matches: matches between img1, img2 as calculated by vl_sift
% - f1:      frames of image1
% - f2:      frames of image2
%
% OUTPUT
% - pairs:   matrix containing random pairs of matching points

matches_upperBound = length(matches);
random = ceil(rand(1, floor(rand(1) * matches_upperBound)) * 10);
P = length(random);
pairs = zeros(P, 4);
random_matches = matches(:, random);

desc_frame1 = random_matches(1, :);
desc_frame2 = random_matches(2, :);
pairs(:, 1) = f1(1, desc_frame1);
pairs(:, 2) = f1(2, desc_frame1);
pairs(:, 3) = f2(1, desc_frame2);
pairs(:, 4) = f2(2, desc_frame2);

end