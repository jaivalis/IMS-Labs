% imagesDir = 'person_toy/';
imagesDir = 'pingpong/';
outputDir = '/out/';

workingDir = pwd;

images = dir(fullfile(workingDir, imagesDir, '*.jpeg'));
imageNames = {images.name}';

img1Path = strcat(imagesDir, char(imageNames(1)));
img1 = imread( img1Path );

for i = 2:length(imageNames),
  % Locate feature points on the first frame by using Harris Corner Detector
  [ H, r, c ] = Harris( img1, 1 );

  img2Path = strcat(imagesDir, char(imageNames(i)))
  img2 = imread(img2Path);
  
  % Then, track these points with Lucas-Kanade method for optical flow
  % estimation.
  [ r, c, V ] = KanadeFlow( img1, img2, r, c );
  
  f = figure;
  set(gcf, 'Visible', 'off');
  imshow(img1);
  hold on
  quiver(c(:), r(:), V(:, 1), V(:, 2));
  hold off
  set(gca, 'position', [0 0 1 1], 'units','normalized')
  saveas(f, strcat(workingDir, outputDir, char( imageNames(i) )));
  
  img1 = img2;
end