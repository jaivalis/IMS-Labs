T_IMG_RATIO = .99; % The percentage of images used for the vocabulary TODO make use of this later
descCount = 100;
% Create vocabulary, get used descriptors
vocabulary_sizes = [400, 800, 1600, 2000, 4000];
[ voc, ~ ]  = visualVocabulary ( 4, descCount, vocabulary_sizes(1) );
fprintf( 'visual vocabulary built\n' );

% vocabImages = quantizeFeatures ( voc , vocabImages );
% fprintf( 'quantizing features done\n' );

% histo = generateHistogram( vocabImages , 1 );

% 2.5 classification / Training the svm
trainingImages = readTrainingImages( 1 - T_IMG_RATIO, descCount );
vocabImages = quantizeFeatures ( voc , trainingImages );
histograms = generateHistogram( vocabImages , 1 );
for i=1:length(vocabImages),
  tImg = vocabImages(i);
  switch(tImg.classLabel)
    case 1
      labelsAir(i) = 1;
      labelsCar(i) = 0;
      labelsFac(i) = 0;
      labelsMot(i) = 0;
    case 2
      labelsAir(i) = 0;
      labelsCar(i) = 1;
      labelsFac(i) = 0;
      labelsMot(i) = 0;
    case 3
      labelsAir(i) = 0;
      labelsCar(i) = 0;
      labelsFac(i) = 1;
      labelsMot(i) = 0;
    case 4
      labelsAir(i) = 0;
      labelsCar(i) = 0;
      labelsFac(i) = 0;
      labelsMot(i) = 1;
  end
end
modelAir = svmtrain( histograms , labelsAir );
modelCar = svmtrain( histograms , labelsCar );
modelFac = svmtrain( histograms , labelsFac );
modelMot = svmtrain( histograms , labelsMot );

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