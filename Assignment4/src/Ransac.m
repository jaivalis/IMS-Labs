function transfrmdImg = Ransac(img1, img2, matches, f1, f2, N)
% RANSAC implementation of the Ransac algorithm
%
% INPUT
% - img1:    image to be transformed
% - img2:    image to be transformed into
% - matches: matches between img1, img2 as calculated by vl_sift
% - f1:      frames of image1
% - f2:      frames of image2
% - N:       the number of repetitions for the algorithm
% 
% OUTPUT not sure yet
% - transfrmdImg: the most accurate transformation of the image achieved

% Each column of F is a feature frame and has the
% format [X;Y;S;TH], where X,Y is the (fractional)
% center of the frame, S is the scale and TH is the
% orientation (in radians). 

bestInlierCount = 0;
bestSolution    = zeros(1, 6);

for n = 1:N, % repeat N times    

  % get P random pairs from matches.
  pairs = getRandomPairs(matches, f1, f2);  
  P = length(pairs);
  
  A = zeros(P * 2, 6);
  b = zeros(P * 2, 1);
  X  = pairs(:, 1);
  Y  = pairs(:, 2);
  X_ = pairs(:, 3);
  Y_ = pairs(:, 4);
  
  for i = 1: P,
    A(2 * (i-1) + 1, :) = [X(i), Y(i), 0, 0, 1, 0];
    A(2 * i, :) = [ 0, 0, X(i), Y(i), 0, 1 ];
    b(2 * (i-1) + 1) = X_(i);
    b(2 * i) = Y_(i);
  end
  xx = pinv(A) * b;

  % Using the transformation parameters, transform the locations of all
  % T points in image1
  T = transformLocations( matches, f1, xx );
  figure;
  %imshowpair(img1, img2, 'montage');
  img = cat(2, img1, img2);
  imshow(img);
  hold on
  % connecting line between original and transformed points
  originalPoints(:, 1) = f1(1, matches(1, :));
  originalPoints(:, 2) = f1(2, matches(1, :));
  size(originalPoints)
  size(T)
  transformedPoints = T + size(img1);
  plot(originalPoints, transformedPoints, 'b');
  hold off

  % plot transformation

  % count inliers
  inliers = countInliers( T, matches, f2 );
  
  if inliers > bestInlierCount,
    bestInlierCount = inliers;
    bestSolution    = xx;
  end
end
% end repeat

transfrmdImg = transformImage( img1, bestSolution );
figure;         imshowpair(img1, img2);

end


%     random_matches = matches(P);
%     random_frame1 = frame1(random_matches(:, 1));
%     random_frame2 = frame2(random_matches(:, 2));
%     % construct matrix A and vector b
%     % matches has shape [X,Y - Value, matches_count]
%     X = random_frame1(1, :);
%     Y = random_frame1(2, :);
%     X_prime = random_frame2(1, :);
%     Y_prime = random_frame2(2, :);
%     A = zeros(2 * P, 6);
%     b = zeros(2 * P, 1);
%     for j = 1:P,
%       % first value of frame is x-value
%       % second value of frame is y-value
%       desc_frame1 = matches(j,1);
%       desc_frame2 = matches(j,2);
%       x = frame1(1, desc_frame1);
%       y = frame1(2, desc_frame1);
%       x_prime = frame1(1, desc_frame2);
%       y_prime = frame1(2, desc_frame2);
%       A(2 * (j-1) + 1, 1) = x;
%       A(2 * (j-1) + 1, 2) = y;
%       A(2 * (j-1) + 1, 3) = 0;
%       A(2 * (j-1) + 1, 4) = 0;
%       A(2 * (j-1) + 1, 5) = 1;
%       A(2 * (j-1) + 1, 6) = 0;
%       A(2 * j, 1) = 0;
%       A(2 * j, 2) = 0;
%       A(2 * j, 3) = x;
%       A(2 * j, 4) = y;
%       A(2 * j, 5) = 0;
%       A(2 * j, 6) = 1;
%       b((j-1) + 1, 1) = x_prime;
%       b(2 * j, 1) = y_prime;
%     % possible without loop?
%     end
%     x = pinv(A) * b;
%     figure;
%     imshowpair(I(imgnmb1).grayImg, I(imgnmb2).grayImg);
%     hold on
%     
%     hold off

  