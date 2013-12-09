function b_o_w = quantizeFeatures( voc , descs )
% QUANTIZEFEATURES Represent each image as a collection of visual words
%   For each descriptor per image a word from the vocabulary will be
%   assigned.
%
% INPUT
% - voc:   The visual vocabulary as extracted from "visualVocabulary.m"
% - descs: Matrix containing randomly selected descriptors for all pictures
%
% OUTPUT
% - b_o_w: Bag of words
  
  [pCount, ~, descCount] = size(descs);
  vocabulary_size = size(voc, 2);
  b_o_w = zeros(pCount, descCount);
  
  for p=1:pCount, % for each picture    
    
    for d = 1:descCount, % for each descriptor of that picture
      least_error = Inf('single');
      
      for j = 1:vocabulary_size, % for each word from the vocabulary
        
        % computing squared error
        desc = single(reshape(descs(p, :, d), 128, 1));
        word = single(round(voc(:, j)));
        error = sum( (word - desc).^2 );
        
        if error < least_error
          % update the closest word assigned to the descriptor
          least_error = error;
          b_o_w(p, d) = j;
        end
        
      end
    end
    fprintf( strcat( 'Image ', num2str(p), 'done\n') );
  end
end