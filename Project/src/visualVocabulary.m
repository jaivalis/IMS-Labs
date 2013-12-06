function voc = visualVocabulary( sampleCount )
  % VISUALVOCABULARY
  % INPUT
  % - folderPath:   The path to be indexed
  % - sampleCount:  How many samples to index (if -1 then will take all folder contents)
  %
  % OUTPUT
  % - 
  % algorithm: http://cs.brown.edu/courses/cs143/2011/results/proj3/georgem/
  % subset of training images
  desc_all = zeros(128, 0);
  
  trainingFolders = dir ( fullfile ('..', 'data', '*_train') );
  
  for fNumber = 1:length( trainingFolders ), % for each training folder
    
    folderName = trainingFolders( fNumber ).name;
    pictures = dir( fullfile('..', 'data', folderName, '*.jpg') );
    if sampleCount == -1,
      sampleCount = length( pictures );
    end
    
    for pNumber = 1:sampleCount,
      pPath = fullfile('..', 'data', folderName, pictures(pNumber).name );
      img = imread( pPath );
      % extract SIFT descriptors
      % image must be of class SINGLE and grayscale
      [ frames, desc ] = vl_dsift(im2single(rgb2gray(img)));
      % append features
      size_desc = size(desc, 2);
      % select 100 dense descriptors randomly
      r = randi(size_desc, 1, 100);
      desc_all = cat(2, desc_all, double(desc(:, r)));
      size(desc_all)
    end
    
  end
  % run k-means clustering
  % vocabulary size = 400, 800, 1600, 2000, 4000
  voc = vl_kmeans(desc_all, 400);






end