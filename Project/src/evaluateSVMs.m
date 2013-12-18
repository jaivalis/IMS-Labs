function evaluateSVMs( backupFolderPath )
%EVALUATESVMS Evaluates svms stored in a given folder.
%
% for each model found in folder:
%   load vocabulary
%   fetch model settings (siftType, vocabularySize, etc)
%
%   load test images (using model settings)
%
%   calculate model accuracy
%   visualize model accuracy
% end
%
% INPUT
% - backupFolderPath: The path to the backup variables folder.
%
%
% Run as follows : evaluateSVMs( './backupVariables/' );

  svmNames = dir( fullfile(backupFolderPath, '*SVM.mat') );
  for i = 1:length(svmNames),              % For each svm.    
    %% Look for corresponding VOC file
    svmName = svmNames(i).name;
  	
    vocPath = strcat( backupFolderPath, svmName(1:end-7), 'VOC.mat' );

    if exist(vocPath, 'file') % load from file  
      fprintf( 'Found backup .voc file, loading from disk\n' );
      tmp = load(vocPath);
      voc = tmp.voc;
    else                      % VOC not found, skip given SVM
      fprintf( strcat('Could not find voc file:', vocPath,'skiping it\n'));
      continue;
    end
    %% Load SVM
    tmp = load( strcat( backupFolderPath, svmName ) );
    svm = tmp.svm;    
    %% Extract run settings from svmName:
    svmName(1:end-7);
    vocRatio = str2num( svmName(1:2) );    
    vocSize = svmName(3:5);
    if strcmp(vocSize, '160') || strcmp(vocSize, '200'),
      vocSize = svmName(3:6);
    elseif strcmp(vocSize, '400'), % 400 / 4000 ambiguity
      if strcmp(svmName(6), '0'),  % if next char is '0' it's 4000
        vocSize = '4000';
      else                         % it's 400
        vocSize = '400';
      end
    else
      vocSize = svmName(3:5);
    end
    
    siftType = svmName( 3 + length(vocSize):end-7 );
    vocSize = str2num( vocSize );
    descCount = 100;
    
    %% Read the test images with the svm settings and evaluate svm:
    
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
        si  = SiftImage(img, classLabel, descCount, siftType);

        testingImgs( pIndex ) = si;    
        testLabels( pIndex )  = classLabel;

        pIndex = pIndex + 1;
      end
    end
    
    testingImgs = quantizeFeatures( voc, testingImgs );
    histo       = generateHistogram( testingImgs, vocSize, 1 );

    [labl, acc_msq_sqcc, prob_est] = svmpredict(testLabels', histo, svm, '-b 1 -q');
    
    %% TODO: Do something with the results obtained
    %      + Simply print accuracy of model
    %      + Output the confusion matrix (save to file)
    fprintf( strcat('Model ', svmName, ':', num2str(acc_msq_sqcc(1)),'\n'));
  end  
end