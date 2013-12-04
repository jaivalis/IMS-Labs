% load all 6 images
image_count = 6;
for i=1:image_count,  
  path = strcat('../img',num2str(i),'.pgm');  
  img = imread(path);
  
  ss = SiftSingle(img);
  
  I(i) = ss;
end

for i=1:image_count,
  img = I(i).grayImg;
  [ frames, desc ]    = vl_sift( img );
  I(i).frames         = frames;
  I(i).desc           = desc;
end

% % TESTING images (2,3)
% desc1 = I(2).desc;
% frame1 = I(2).frames;
% desc2 = I(3).desc;
% frame2 = I(3).frames;
% [ matches, scores ] = vl_ubcmatch(desc1, desc2);
% img1 = I(2).grayImg;
% img2 = I(3).grayImg;
% Ransac(img1, img2, matches, frame1, frame2, 2, 1);


comparissons = 1:length(I);
for i = comparissons,
  
  desc1 = I(i).desc;
  % compare with the rest
  for j = i+1:length(I),
    msg = strcat('Comparing',num2str(i),'_',num2str(j));
    fprintf( msg );
    desc2 = I(j).desc;
    
    [ matches, scores ] = vl_ubcmatch(desc1, desc2);
    [ transImg, builtin, ~ ] = Ransac(I(i).grayImg, I(j).grayImg, matches, I(i).frames, I(j).frames, 4, 0);
    fig = figure;
    title(msg);
    a = subplot(2,1,1);
    imshowpair(I(i).grayImg, transImg, 'montage');
    b = subplot(2,1,2);
    imshowpair(I(i).grayImg, builtin, 'montage');
    saveas(fig,strcat('../out/', msg),'jpg');
    
  end
  
  % remove i from set
  comparissons = comparissons(comparissons ~= i);
end