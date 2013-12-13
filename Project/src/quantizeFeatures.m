function images = quantizeFeatures( voc, images )
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
  
  for p = 1:pCount, % for each picture
    siftImg   = images( p );
    descs     = siftImg.sampleDescs;
    descCount = size( descs, 2 );
    
    for d = 1:descCount, % for each descriptor of that picture
      desc = single(descs(:, d));
      
      % find the closest word
      images(p).bagOfWords(d) = dsearchn(voc', desc');
      
    end
    fprintf( strcat( '\tquantizeFeatures(): Image ', num2str(p), 'done\n') );
  end
end