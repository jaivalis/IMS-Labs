function [transfrmdImg, builtin, Sol_reshaped] = Ransac(img1, img2, matches, f1, f2, N, plotFig)
% RANSAC implementation of the Ransac algorithm
%
% INPUT
% - img1:    image to be transformed
% - img2:    image to be transformed into
% - matches: matches between img1, img2 as calculated by vl_sift
% - f1:      frames of image1
% - f2:      frames of image2
% - N:       the number of repetitions for the algorithm
% - plotFig: boolean to surpress plots
% 
% OUTPUT not sure yet
% - transfrmdImg: the most accurate transformation of the image achieved
% - builtin: image, transformed by matlab built-in function
% - Sol_reshaped: transformation parameters

% Each column of F is a feature frame and has the
% format [X;Y;S;TH], where X,Y is the (fractional)
% center of the frame, S is the scale and TH is the
% orientation (in radians). 
img_size = size( img1 );

bestInlierCount = 0;
bestSolution    = zeros(1, 6);

for n = 1:N, % repeat N times    

  % get P random pairs from matches.
  pairs = getRandomPairs(matches, f1, f2);  
  [ P, ~ ] = size(pairs); % P = 3
  
  % How many matches do we need to solve an affine transformation which
  % can be formulated as shown in Figure 1?
  % Answer: we need at least 3 points.
  
  A  = zeros(P * 2, 6);
  b  = zeros(P * 2, 1);
  X  = pairs(:, 1);
  Y  = pairs(:, 2);
  X_ = pairs(:, 3);
  Y_ = pairs(:, 4);

  for i = 1:P,
    A(2 * (i-1) + 1, :) = [ X(i), Y(i), 0, 0, 1, 0 ];
    A(2 * i, :)         = [ 0, 0, X(i), Y(i), 0, 1 ];
    b(2 * (i-1) + 1)    = X_(i);
    b(2 * i)            = Y_(i);
  end
  xx = pinv(A) * b;

  % Using the transformation parameters, transform the locations of all
  % T points in image1
  T = transformLocations( matches, f1, xx );
  
  % count inliers
  [inlierSet, inliers] = countInliers( T, matches, f2 );
  
  if inliers > bestInlierCount,
    bestInlierCount = inliers;
    bestSolution    = xx;
    bestInlierSet   = inlierSet;
  end
  
  if plotFig
    % plot transformation
    concat = cat(2, img1, img2);    concat = concat / 255;
    figure;    imshow(concat, 'InitialMagnification', 50);
    hold on
    % connecting line between original and transformed points
    originPoints(:, 1) = f1( 1, matches(1, :) ); % x coordinate
    originPoints(:, 2) = f1( 2, matches(1, :) ); % y coordinate

    destinationPoints       = T;
    destinationPoints(:, 1) = destinationPoints(:, 1) + img_size(2); % plus width

    plot(originPoints(1:25:end, 1), originPoints(1:25:end, 2), 'ro');
    plot(destinationPoints(1:25:end, 1), destinationPoints(1:25:end, 2), 'go');
    % maybe without loop?
    % only every 20th line, otherwise it's a mess
    for i=1:25:length(destinationPoints),
      plot([originPoints(i, 1) destinationPoints(i, 1)], [originPoints(i, 2) destinationPoints(i, 2) ], 'b');
    end
    hold off
  end
end
% end repeat

% our solution:
transfrmdImg = transformImage( img2, bestSolution );
% reshape bestSolution
  Sol_reshaped = [bestSolution(1), bestSolution(2) 0; ...
                  bestSolution(3), bestSolution(4) 0; ...
                  bestSolution(5), bestSolution(6) 1];
                
% built-in image transformation solution:
  form    = maketform('affine', Sol_reshaped);
  builtin = imtransform(img2, form);
if plotFig
  figure;         imshowpair(img1, transfrmdImg, 'montage');


  figure;         imshowpair(img1, builtin, 'montage');      
end

end