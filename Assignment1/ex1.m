img_size = 512;
k = 512;
% Obtain many images in a fixed view under different illuminants
img1 = imread('sphere1.png'); % S center        [256 256]
img2 = imread('sphere2.png'); % S lower right   [512 512]
img3 = imread('sphere3.png'); % S lower left    [1 512]
img4 = imread('sphere4.png'); % S upper right   [512 1]
img5 = imread('sphere5.png'); % S upper left    [1 1]

S1 = zeros(512, 512, 3);
S2 = zeros(512, 512, 3);
S3 = zeros(512, 512, 3);
S4 = zeros(512, 512, 3);
S5 = zeros(512, 512, 3);

S1_pos = [0  0  -1];
S2_pos = [1  1  -1];
S3_pos = [-1 1  -1];
S4_pos = [1  -1 -1];
S5_pos = [-1 -1 -1];

% Determine the matrix V from source and camera information
V = [k * S1_pos; k * S2_pos; k * S3_pos; k * S4_pos; k * S5_pos;];

I = zeros(img_size, img_size, 5);

% g = zeros(512, 512, 3);

% Create arrays for albedo, normal (3 components),
albedo = zeros(512,512);
normal = zeros(512, 512, 3);
% p (measured value of ∂f/∂x )
p = zeros(512,512);
% q (measured value of ∂f/∂y )
q = zeros(512,512);

opts.RECT = true;
% For each point in the image array
for i = 1:img_size,
  for j = 1:img_size,
    S1(i, j, :) = [(i - S1_pos(1)) (j - S1_pos(2)) (100)];
    S2(i, j, :) = [(i - S2_pos(1)) (j - S2_pos(2)) (100)];
    S3(i, j, :) = [(i - S3_pos(1)) (j - S3_pos(2)) (100)];
    S4(i, j, :) = [(i - S4_pos(1)) (j - S4_pos(2)) (100)];
    S5(i, j, :) = [(i - S5_pos(1)) (j - S5_pos(2)) (100)];

    % Stack image values into a vector I
    I(i, j, :) = [img1(i,j); img2(i,j); img3(i,j); img4(i,j); img5(i,j);];

    % Construct the diagonal matrix T
    II =  reshape(I(i,j,:), 5, 1);
    T = diag(II);

    % Solve TVg = TI to obtain g for this point
    TV = T*V;
    if TV == zeros(5,3),  linsolv = zeros(3,1);
    else                  linsolv = linsolve(TV, T*II, opts);
                        % linsolv = (T*II')\(T*V);
    end
    g = linsolv;

    % albedo at this point is norm(g)
    albedo(i,j) = norm(g);

    if albedo(i,j) ~= 0,
        % normal at this point is | g |
        normal(i,j,:) = g / albedo(i,j);
        p(i,j) = normal(i,j,1) / normal(i,j,3);
        q(i,j) = normal(i,j,2) / normal(i,j,3);
    end
    % p at this point is N1 / N3
    p(i, j) = normal(i, j, 1) / normal(i, j, 3);

    % q at this point is N2 / N3
    q(i, j) = normal(i, j, 2) / normal(i, j, 3);
  end
end


%top left corner of height map is zero
height = zeros(512, 512);
%for each pixel in the left column of height map
for i = 1:img_size,
  % height value=previous height value + corresponding q value
  height(1, i) = height(1, i) + q(1, i);
end

%for each row
for i = 1:img_size,
  %for each element of the row except for leftmost
  for j = 2:img_size,
    %height value = previous height value + corresponding p value
    height(j, i) = height(j, i) + p(j, i);
  end
end

figure(1);
imshow(albedo);

stepsize = 30;
range = 1:stepsize:512;
u = normal(range, range, 1);
v = normal(range, range, 2);
w = normal(range, range, 3);

[x,y] = meshgrid(range, range);
z = zeros(ceil(img_size / stepsize), ceil(img_size / stepsize));

figure(2);
quiver3(x,y,z,u,v,w);