function [ voc, descs ] = visualVocabulary( picCount, descCount, vocSize )
% VISUALVOCABULARY
% INPUT
% - picCount:  count of sample pictures (if -1 will take all folder contents)
% - descCount: count of descriptors to take per sample image
% - vocSize:   count of visual words the vocabulary will contain
%
% OUTPUT
% - voc:
% - descs: Matrix containing randomly selected descriptors for all pictures
% - 
% algorithm: http://cs.brown.edu/courses/cs143/2011/results/proj3/georgem/
  desc_all = zeros(128, 0);
  
  trainingFolders = dir ( fullfile ('..', 'data', '*_train') );
  
  descs = zeros ( length(trainingFolders) * picCount, 128, descCount );
  d = 1; % pictures processed (index for descs)
  
  for fNumber = 1:length( trainingFolders ), % for each training folder
    
    folderName = trainingFolders( fNumber ).name;
    pictures = dir( fullfile('..', 'data', folderName, '*.jpg') );
    
    if picCount == -1, % include all the pictures
      picCount = length( pictures );
    end
    
    for pNumber = 1:picCount,
      pPath = fullfile('..', 'data', folderName, pictures(pNumber).name );
      img = imread( pPath );
      % TODO split image into 3 channels and do the following 3 times
      
      % extract SIFT descriptors (image must be SINGLE and grayscale)
      [ ~, desc ] = vl_dsift(im2single(rgb2gray(img)));
      
      % select descCount dense descriptors randomly
      r = randi(size(descs(d, :, :), 2), 1, descCount);
      
      % store the descriptor
      descs(d, :, :) = desc(:, r);
      
      % append features
      desc_all = cat(2, desc_all, double( desc(:, r) ));
      
      d = d + 1;
    end
    
  end
  % run k-means clustering
  voc = vl_kmeans(desc_all, vocSize);
  
end