function [ voc, images ] = visualVocabulary( V_IMG_RATIO, descCount, vocSize, siftType )
% VISUALVOCABULARY2
% INPUT
% - picCount:  count of sample pictures (if -1 will take all folder contents)
% - descCount: count of descriptors to take per sample image
% - vocSize:   count of visual words the vocabulary will contain
%
% OUTPUT
% - voc:   
% - descs: Matrix containing randomly selected descriptors for all pictures
% - 
% algorithm: http://cs.brown.edu/courses/cs143/2011/results/proj3/georgem/
desc_all = zeros(128, 0);
trainingFolders = dir ( fullfile ('..', 'data', '*_train') );

classLabel = 1; imgIndex = 1;
for fNum = 1:length( trainingFolders ), % for each training folder

  folderName   = trainingFolders( fNum ).name;
  pictures     = dir( fullfile('..', 'data', folderName, '*.jpg') );
  picsInFolder = length(pictures);

  v_img_bound = floor(V_IMG_RATIO * picsInFolder);
  fprintf( strcat('\tImages to generate vocabulary from in folder #', ...
                    num2str(fNum), ':', num2str(v_img_bound), '\n'));
  for pNum = 1:v_img_bound,
    pPath = fullfile('..', 'data', folderName, pictures(pNum).name );
    img = imread( pPath );

    si = SiftImage(img, classLabel, descCount, siftType);

    images( imgIndex ) = si;

    desc_all = cat(2, desc_all, double( si.sampleDescs ));

    imgIndex = imgIndex + 1;
  end
  classLabel = classLabel + 1; % new folder > new class
end
% run k-means clustering
voc = vl_kmeans(desc_all, vocSize);

end