vocImgRatio = .20; % The percentage of images used for the vocabulary TODO make use of this later
descCount = 100;

%% Create vocabulary, obtain used descriptors
vocabulary_sizes = [400, 800, 1600, 2000, 4000];
siftType = 'keyPoints';
% TODO: Use this line:
[ voc, ~ ] = visualVocabulary ( vocImgRatio, descCount, vocabulary_sizes(2), siftType );
% DEBUG:
% [ voc, ~ ]  = visualVocabulary ( 0.01, descCount, vocabulary_sizes(1), siftType );
[ ~, vocSize ] = size(voc);
fprintf( 'visual vocabulary built\n' );

% vocabImages = quantizeFeatures ( voc , vocabImages );
% fprintf( 'quantizing features done\n' );

% histo = generateHistogram( vocabImages, vocSize, 1);

%% 2.5 classification / Training the svm
% load the training images from all folders
trainingImages = readTrainingImages( vocImgRatio, descCount, siftType );
% fprintf( 'training images read\n' );

% create the required labels for training the svms
vocabImages = quantizeFeatures ( voc , trainingImages );
histograms = generateHistogram( vocabImages, vocSize, 1 );
for i=1:length(trainingImages),
  tImg = trainingImages(i);
  labels(i) = tImg.classLabel;
  switch(tImg.classLabel)
    case 1
      labelsAir(i)=1;  labelsCar(i)=0;  labelsFac(i)=0;  labelsMot(i)=0;
    case 2
      labelsAir(i)=0;  labelsCar(i)=1;  labelsFac(i)=0;  labelsMot(i)=0;
    case 3
      labelsAir(i)=0;  labelsCar(i)=0;  labelsFac(i)=1;  labelsMot(i)=0;
    case 4
      labelsAir(i)=0;  labelsCar(i)=0;  labelsFac(i)=0;  labelsMot(i)=1;
  end
end
% train the four svms + 1 multiclass svm
modelAir = svmtrain( labelsAir', histograms , '-b 1 -q' );
modelCar = svmtrain( labelsCar', histograms , '-b 1 -q' );
modelFac = svmtrain( labelsFac', histograms , '-b 1 -q' );
modelMot = svmtrain( labelsMot', histograms , '-b 1 -q' );

svm = svmtrain(labels', histograms, '-b 1 -q' );
% save the svms to files for fast debugging
save './svmBak/modelAir.mat' modelAir;
save './svmBak/modelCar.mat' modelCar;
save './svmBak/modelFac.mat' modelFac;
save './svmBak/modelMot.mat' modelMot;
fprintf( 'Models trained and saved\n' );

% Keep these comments, might be incorporated in the report
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


%% 2.6 Evaluate

testFolders = dir( fullfile('..', 'data', '*_test') );

pIndex = 1;
for fNum = 1:length( testFolders ), % for each testing folder
  classLabel = fNum;
  folderName = testFolders( fNum ).name;
  pictures = dir( fullfile('..', 'data', folderName, '*.jpg') );

  picturesInFolder = length(pictures);
  
  fprintf( strcat('\tImages in test folder #', num2str(fNum), ...
                                   ':',  num2str(picturesInFolder), '\n'));
  for pNum = 1:picturesInFolder,
    pPath = fullfile('..', 'data', folderName, pictures(pNum).name );
    
    img = imread( pPath );
    si = SiftImage(img, classLabel, descCount, siftType);
    
    testingImgs( pIndex ) = si;    
    testLabels( pIndex )  = classLabel;
    
    pIndex = pIndex + 1;
  end
end
testingImgs = quantizeFeatures( voc, testingImgs );
histo = generateHistogram( testingImgs, vocSize, 1 );

[labl, acc_msq_sqcc, prob_est] = svmpredict(testLabels', histo, svm, '-b 1 -q');