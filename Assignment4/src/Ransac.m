function Ransac(n, matches)
  for i=1:n, % repeat N times
    % pick p matches at random from matches
    matches_count = length(matches);
    r = ceil(rand(1, floor(rand(1) * matches_count)) * matches_count)
    random_matches = matches(r);
    % construct matrix A and vector b
    % assuming matches has shape [indexMatch, Point, X/Y - Valaue] 
    for i=1:matches_count,
      A(2 * (i-1) + 1, 1) = matches(i,1,1);
      A(2 * (i-1) + 1, 2) = matches(i,1,2);
      A(2 * (i-1) + 1, 3) = 0;
      A(2 * (i-1) + 1, 4) = 0;
      A(2 * (i-1) + 1, 5) = 1;
      A(2 * (i-1) + 1, 6) = 0;
      A(2 * i, 1) = 0;
      A(2 * i, 2) = 0;
      A(2 * i, 3) = matches(i,1,1);
      A(2 * i, 4) = matches(i,1,2);
      A(2 * i, 5) = 0;
      A(2 * i, 6) = 1;
      b((i-1) + 1, 1) = matches(i,2,1);
      b(2 * i, 1) = matches(i,2,1);
      b(2 * i, 2) = matches(i,2,2);
    % possible without loop?
    end
    x = pinv(A) * b;