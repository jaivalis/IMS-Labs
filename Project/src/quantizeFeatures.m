function bag_of_words = quantizeFeatures( voc , descs)
% QUANTISIZEFEATURES 
%   represent each image as a collection of visual words
%   extracts feature descriptors (SIFT) and then assign each descriptor to
%   the closest visual word from the vocabulary.
  
  [pCount, ~, descCount] = size(descs);
  vocabulary_size = size(voc, 2);
  bag_of_words = zeros(pCount, descCount);
  for p=1:pCount,
    
    % assign each descriptor to closest visual word
    for d=1:descCount,
      closest_word = 0;
      best_error = Inf('single');
      for j=1:vocabulary_size,
        desc = single(reshape(descs(p, :, d), 128, 1));
        word = single(round(voc(:, j)));
        % computing squared error
        error = (word - desc).^2;
        if sum(error) < best_error
          closest_word = j;
          best_error = sum(error);
          % store the bag of visual words
          bag_of_words(p, d) = closest_word;
        end
      end
    end
    strcat('Image ', num2str(p), 'done')
  end
end