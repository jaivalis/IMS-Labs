function photometricStereo()
  global img_size;
  img_size = 512;
  k = sqrt(1/3);
  % Obtain many images in a fixed view under different illuminants
  img1 = im2single(imread('sphere1.png')); % S center        [256 256]
  img2 = im2single(imread('sphere2.png')); % S lower right   [512 512]
  img3 = im2single(imread('sphere3.png')); % S lower left    [1 512]
  img4 = im2single(imread('sphere4.png')); % S upper right   [512 1]
  img5 = im2single(imread('sphere5.png')); % S upper left    [1 1]

  S1_pos = [ 0  0  1];
  S2_pos = [ k  k  k];
  S3_pos = [-k  k  k];
  S4_pos = [ k -k  k];
  S5_pos = [-k -k  k];

  % Determine the matrix V from source and camera information
  V = [k * S1_pos; k * S2_pos; k * S3_pos; k * S4_pos; k * S5_pos;];

  I = zeros(img_size, img_size, 5);

  % Create arrays for albedo, normal (3 components),
  albedo = zeros(512,512);
  normal = zeros(512, 512, 3);
  % p (measured value of ∂f/∂x )
  p = zeros(512,512);
  % q (measured value of ∂f/∂y )
  q = zeros(512,512);

  % For each point in the image array
  for i = 1:img_size,
    for j = 1:img_size,
      % Stack image values into a vector I
      I(i, j, :) = [img1(i,j); img2(i,j); img3(i,j); img4(i,j); img5(i,j);];

      % Construct the diagonal matrix T
      II =  reshape(I(i,j,:), 1, 5);
      T = diag(II);

      % Solve TVg = TI to obtain g for this point
      A = T*V;
      if A == zeros(5,3),   % avoiding linsolve warnings
        g = zeros(1, 3);
      else
        B = T*II.';
        g = linsolve(A, B);
      end
      
      % albedo at this point is norm(g)
      normG = norm(g);
      albedo(i, j) = normG;

      if normG == 0,  normG = 1;  end
      
      % normal at this point is g / norm(g)
      normal(i, j, :) = g ./ normG;

      if normal(i, j, 3) == 0, % avoiding division by 0
        normal(i, j, 3) = 0.00001;
      end
      % p at this point is N1 / N3
      p(i,j) = normal(i, j, 1) / normal(i, j, 3);
      % q at this point is N2 / N3
      q(i,j) = normal(i, j, 2) / normal(i, j, 3);
    end
  end
  
  %reconstruct the surface
  heightMap = getHeightMap(q, p);
  figure(1);
  surf(heightMap(1:25:end, 1:25:end));

  figure(2);
  imshow(albedo);

  stepsize = 25;
  range = 1:stepsize:img_size;
  u = normal(range, range, 1);
  v = normal(range, range, 2);
  w = normal(range, range, 3);

  figure(3);
  quiver3(heightMap(range,range),u,v,w);
end

function map = getHeightMap(Q, P)
  global img_size;
  center = ceil(img_size / 2);
  map = zeros(img_size);

  % center column:
  for i = 1:center-1
    map(center, center-i) = map(center, center-i+1) + P(center, center-i);
    map(center, center+i) = map(center, center+i-1) - P(center, center+i);
  end
  % Rest of the heightmap, starting from center column:
  for i = 1:img_size
    for j = 1:center-1
      map(center-j, i) = map(center-j+1, i) + Q(center-j, i);
      map(center+j, i) = map(center+j-1, i) - Q(center+j, i);
    end
  end
end