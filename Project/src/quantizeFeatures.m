function images = quantizeFeatures( voc , images )
% QUANTIZEFEATURES Represent each image as a collection of visual words
%   For each descriptor per image a word from the vocabulary will be
%   assigned.
%
% INPUT
% - voc:    The visual vocabulary as extracted from "visualVocabulary.m"
% - images: Matrix containing randomly selected descriptors for all pictures
%
% OUTPUT
% - b_o_w: Bag of words
  
  pCount = length(images);
  vocabulary_size = size(voc, 2);
  
  for p = 1:pCount, % for each picture
    siftImg   = images( p );
    descs     = siftImg.sampleDescs;
    descCount = size( descs, 2 );
    
    for d = 1:descCount, % for each descriptor of that picture
      least_error = Inf('single');
      desc = single(descs(:, d));
      
      for j = 1:vocabulary_size, % for each word from the vocabulary
        word = single(round(voc(:, j)));
        
        % squared error computation:
        error = sum( (word - desc).^2 );
        
        if error < least_error
          % update the closest word assigned to the descriptor
          least_error = error;
          images(p).bagOfWords(d) = j;
        end
        
      end
    end
    fprintf( strcat( '\tquantizeFeatures(): Image ', num2str(p), 'done\n') );
  end
end