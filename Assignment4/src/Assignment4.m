image_count = 6;

for i=1:image_count,  
  path = strcat('../img',num2str(i),'.pgm');  
  img = imread(path);
  
  ss = SiftSingle(img);
  
  I(i) = ss;
end

% figure;
% imshow(img1);

% frames = zeros(image_count, img_size(1), img_size(2));
% desc = zeros(image_count, img_size(1), img_size(2));
for i=1:image_count,
  img = I(i).grayImg;
  [ frames, desc ]    = vl_sift( img );
  I(i).frames         = frames;
  I(i).desc           = desc;
end

comparissons = 1:length(I);
for i = comparissons,
  
  desc1 = I(i).desc;
  % compare with the rest
  for j = i+1:length(I),
    msg = strcat('Comparing [',num2str(i),', ',num2str(j),']\n');
    fprintf( msg );
    desc2 = I(j).desc;
    
    [ matches, scores ] = vl_ubcmatch(desc1, desc2);
    I(i).matches(j) = matches;
    I(j).matches(i) = matches;
  end
  
  % remove i from set
  comparissons = comparissons(comparissons ~= i);
end