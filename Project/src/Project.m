
% Create vocabulary, get used descriptors
vocabulary_sizes = [400, 800, 1600, 2000, 4000];
[ voc, images ]  = visualVocabulary ( 4, 100, vocabulary_sizes(1) );
fprintf( 'visual vocabulary built\n' );

images = quantizeFeatures ( voc , images );
fprintf( 'quantizing features done\n' );

histo = generateHistogram( images , 1 );

% 2.5 classification / Training the svm
% Step 1 : First positive classifier.
%          Generate positive examples (default : 50 histograms of size 400)
%
%   Take images from the training set of the related class (but which you did
%   not use for dictionary calculation), and represent them with histograms 
%   of visual words.

% Step 2: Remaining three negative classifiers.
%         Generate negative examples from other classes (default : 50 per
%                                                                    class)
%
% 	Take example images from other classes so as to represent the negative
% 	examples for each given class. (At least 150 negative examples)







% use sift for every channel and evaluate best way to use sift
%
% take 100 dense descriptors randomly or k-sift
% use the best(fastest) one