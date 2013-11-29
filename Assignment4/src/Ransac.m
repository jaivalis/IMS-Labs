function Ransac(I, imgnmb1, imgnmb2, n, matches, frame1, frame2)
% Each column of F is a feature frame and has the
% format [X;Y;S;TH], where X,Y is the (fractional)
% center of the frame, S is the scale and TH is the
% orientation (in radians). 

  for i=1:n, % repeat N times
    % pick p matches at random from matches
    matches_count = length(matches);
    r = ceil(rand(1, floor(rand(1) * 10)) * 10);
    random_matches = matches(r);
    random_frame1 = frame1(random_matches(:, 1));
    random_frame2 = frame2(random_matches(:, 2));
    % construct matrix A and vector b
    % matches has shape [X,Y - Value, matches_count] 
    %X = random_frame1(1, :);
    %Y = random_frame1(2, :);
    %X_prime = random_frame2(1, :);
    %Y_prime = random_frame2(2, :);
    A = zeros(2 * r, 6);
    b = zeros(2 * r, 1);
    for j=1:r,
      % first value of frame is x-value
      % second value of frame is y-value
      desc_frame1 = matches(j,1);
      desc_frame2 = matches(j,2);
      x = frame1(1, desc_frame1);
      y = frame1(2, desc_frame1);
      x_prime = frame1(1, desc_frame2);
      y_prime = frame1(2, desc_frame2);
      A(2 * (j-1) + 1, 1) = x;
      A(2 * (j-1) + 1, 2) = y;
      A(2 * (j-1) + 1, 3) = 0;
      A(2 * (j-1) + 1, 4) = 0;
      A(2 * (j-1) + 1, 5) = 1;
      A(2 * (j-1) + 1, 6) = 0;
      A(2 * j, 1) = 0;
      A(2 * j, 2) = 0;
      A(2 * j, 3) = x;
      A(2 * j, 4) = y;
      A(2 * j, 5) = 0;
      A(2 * j, 6) = 1;
      b((j-1) + 1, 1) = x_prime;
      b(2 * j, 1) = y_prime;
    % possible without loop?
    end
    x = pinv(A) * b;
    figure;
    imshowpair(I(imgnmb1).grayImg, I(imgnmb2).grayImg);
    hold on
    
    hold off
  end
  