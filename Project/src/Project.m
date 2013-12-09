
% Create vocabulary, get used descriptors
vocabulary_sizes = [400, 800, 1600, 2000, 4000];
[ voc, descs ] = visualVocabulary( 4, 100, vocabulary_sizes(1) );



bag = quantizeFeatures ( voc , descs);
% img = imread('../data/airplanes_train/img001.jpg');
% img1 = rgb2gray(img(:,:,1));
% img2 = rgb2gray(img(:,:,2));
% img3 = rgb2gray(img(:,:,3));
% 
% figure;
% imshow(img1);
% figure;
% imshow(img2);
% figure;
% imshow(img3);

% use sift for every channel and evaluate best way to use sift

% take 100 dense descriptors randomly or k-sift
% use the best(fastest) one