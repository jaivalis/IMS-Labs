function Ransac(n, matches, frame1, frame2)
% Each column of F is a feature frame and has the
% format [X;Y;S;TH], where X,Y is the (fractional)
% center of the frame, S is the scale and TH is the
% orientation (in radians). 

  for i=1:n, % repeat N times
    % pick p matches at random from matches
    matches_count = length(matches);
    r = ceil(rand(1, floor(rand(1) * 10)) * 10);
    random_matches = matches(r);
    % construct matrix A and vector b
    % matches has shape [X,Y - Value, matches_count] 
    X = frame1(1, :);
    Y = frame1(2, :);
    X_prime = frame2(1, :);
    Y_prime = frame2(2, :);
    A = zeros(2 * r, 6);
    b = zeros(2 * r, 1);
    for i=1:r,
      % first value of frame is x-value
      % second value of frame is y-value
      x = X(i);
      y = Y(i);
      x_prime = X_prime(i);
      y_prime = Y_prime(i);
      A(2 * (i-1) + 1, 1) = x;
      A(2 * (i-1) + 1, 2) = y;
      A(2 * (i-1) + 1, 3) = 0;
      A(2 * (i-1) + 1, 4) = 0;
      A(2 * (i-1) + 1, 5) = 1;
      A(2 * (i-1) + 1, 6) = 0;
      A(2 * i, 1) = 0;
      A(2 * i, 2) = 0;
      A(2 * i, 3) = x;
      A(2 * i, 4) = y;
      A(2 * i, 5) = 0;
      A(2 * i, 6) = 1;
      b((i-1) + 1, 1) = x_prime;
      b(2 * i, 1) = y_prime;
    % possible without loop?
    end
    x = pinv(A) * b;
    size(x)
  end
  