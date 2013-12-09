
% Create vocabulary, get used descriptors
vocabulary_sizes = [400, 800, 1600, 2000, 4000];
[ voc, images ]  = visualVocabulary ( 4, 100, vocabulary_sizes(1) );
fprintf( 'visual vocabulary built\n' );

images = quantizeFeatures ( voc , images );
fprintf( 'quantizing features done\n' );

generateHistogram( images );

% use sift for every channel and evaluate best way to use sift
%
% take 100 dense descriptors randomly or k-sift
% use the best(fastest) one