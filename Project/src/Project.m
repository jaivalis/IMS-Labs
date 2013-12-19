backupFolderPath = './backupVariables/';

%% Experiment settings
vocImgRatio = .20; % The percentage of images used for the vocabulary TODO make use of this later
descCount = 300;
siftTypes = {'dense' 'keyPoints' 'rgb_' 'RGB' 'opponent' 'all'};
voc_sizes = [400, 800, 1600, 2000, 4000];

siftType  = siftTypes{1};
vocSize   = voc_sizes(1);

settingsPrefix = strcat( num2str(vocImgRatio*100), num2str(vocSize), siftType);

%% Create vocabulary, obtain used descriptors

% Look for possible backed up visual vocabulary:
possibleVocPath = strcat( backupFolderPath, settingsPrefix, 'VOC.mat' );

if exist(possibleVocPath, 'file') % load from file  
  fprintf( 'Found backup .voc file, loading from disk\n' );
  tmp = load(possibleVocPath);
  voc = tmp.voc;
  
else                              % generate and save to disk  
  fprintf( 'No backup .voc file exists\n' );
  [ voc, ~ ] = visualVocabulary ( vocImgRatio, descCount, vocSize, siftType );
  % DEBUG mode: [ voc, ~ ]  = visualVocabulary ( 0.01, descCount, vocSize, siftType );
  save( strcat( possibleVocPath ), 'voc');
  fprintf( 'Backup .voc file created\n' );
  
end

%% 2.5 classification / Training the svm
possibleSvmPath = strcat( backupFolderPath, settingsPrefix, 'SVM.mat' );

if exist(possibleSvmPath, 'file') % load from file  
  fprintf( 'Found backup svm file, loading from disk\n' );
  tmp = load(possibleSvmPath);
  svm = tmp.svm;
  
else                              % generate and save to disk  
  fprintf( 'No backup svm file exists\n' );
  % load the training images from all folders
  trainingImages = readTrainingImages( vocImgRatio, descCount, siftType );
  % fprintf( 'training images read\n' );

  % create the required labels for training the svms
  vocabImages = quantizeFeatures ( voc , trainingImages );
  histograms = generateHistogram( vocabImages, vocSize, 1 );
  fprintf( 'Histograms generated\n' );
  labels = zeros(1, length(trainingImages));
  for i=1:length(trainingImages),
    labels(i) = trainingImages(i).classLabel;
  end
  % train the multiclass svm
  svm = svmtrain(labels', histograms, '-b 1 -q' );

  % save the svm to file for reusing
  save( strcat( backupFolderPath, settingsPrefix, 'SVM.mat' ), 'svm');
  fprintf( 'Model trained and saved\n' );
end

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

fprintf( 'Model performance measured.\n' );