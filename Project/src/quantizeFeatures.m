function bag_of_words = quantizeFeatures( voc , picCount)
% QUANTISIZEFEATURES 
%   represent each image as a collection of visual words
%   extracts feature descriptors (SIFT) and then assign each descriptor to
%   the closest visual word from the vocabulary.

trainingFolders = dir ( fullfile ('..', 'data', '*_train') );
  
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
      
      % extract SIFT descriptors (image must be SINGLE and grayscale)
      [ ~, desc ] = vl_dsift(im2single(rgb2gray(img)));
      
      % assign each descriptor to closest visual word
      for i=1:size(desc, 2),
        closest_word = 0;
        best_error = Inf('single');
        for j=1:size(voc, 2),
          % computing squared error
          error = (single(round(voc(:, j))) - single(desc(:, i))).^2;
          if sum(error) < best_error
            closest_word = j;
            best_error = error;
          end
        end
        % store the bag of visual words
        bag_of_words(d, i, 1) = closest_word;
      end
      
      % store the bag of visual words
      d = d + 1;
    end
    
  end
end