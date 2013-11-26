
imagesDir = 'pingpong/';
outputDir = '/out/';

workingDir = pwd;

images = dir(fullfile(workingDir, imagesDir, '*.jpeg'));
imageNames = {images.name}';

img1Path = strcat(imagesDir, char(imageNames(1)));
img1 = imread( img1Path );

% Locate feature points on the first frame by using Harris Corner Detector
[ H, r, c ] = Harris( img1, 1 );

% Then, track these points with Lucas-Kanade method for optical flow
% estimation

baselineImg = img1;
for i = 1:length(r),
  x = r(i);
  y = c(i);
  baselineImg(x, y) = 1; % add highlight
end

imshow(baselineImg);

img1 = baselineImg;
for i = 2:length(imageNames),
  imgPath = strcat(imagesDir, char(imageNames(i)));
  img2 = imread(imgPath);
  
  [ centers, V ] = Kanade( img1, img2, 1 );
  
  f = figure;
  set(gcf, 'Visible', 'off');
  imshow(img1);
  hold on
  quiver(centers(:, :, 1), centers(:, :, 2), V(:, :, 1), V(:, :, 2));
  hold off
  set(gca,'YDir','reverse');
  saveas(f, strcat(workingDir, outputDir, char( imageNames(i) )));
  
  img1 = img2;
end