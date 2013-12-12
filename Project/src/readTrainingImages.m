function trainingImgs = readTrainingImages( ignoreRatio, descCount, siftType )
%READTRAININGIMAGES Returns a set of images to train from
%   Detailed explanation goes here
%
% INPUT
% - ignoreRatio: The percentage of pictures used for vocabulary (to ignore)
% - descCount:   Number of descriptors (TODO remove)
% - siftType:  string of type of sift descriptors
%
% OUTPUT
% - trainingImgs: Matrix of training image instances.

trainingFolders = dir( fullfile('..', 'data', '*_train') );

classLabel = 1;
imgIndex   = 1;
for fNum = 1:length( trainingFolders ), % for each training folder    
  folderName = trainingFolders( fNum ).name;
  pictures = dir( fullfile('..', 'data', folderName, '*.jpg') );

  picsToIgnore = ceil( ignoreRatio * length(pictures) );
  picturesInFolder = length(pictures);
  
  fprintf( strcat('\tImages to train from in folder #', num2str(fNum), ...
                ':',  num2str(picturesInFolder - picsToIgnore + 1), '\n'));
  for pNum = (picsToIgnore + 1):picturesInFolder, % ignore first [...]
    pPath = fullfile('..', 'data', folderName, pictures(pNum).name );
    img = imread( pPath );

    si = SiftImage(img, classLabel, descCount, siftType);
    trainingImgs( imgIndex ) = si;

    imgIndex = imgIndex + 1;
  end
  classLabel = classLabel + 1;
end
end