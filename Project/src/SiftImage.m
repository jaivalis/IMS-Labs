classdef SiftImage
  %SIFTIMAGE Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    img
    grayImg
    sampleDescs
    allDescs
    imgSize
    classLabel
    bagOfWords % vector that contains one word per descriptor of this image
  end
  
  methods
    % default constructor
    function obj = SiftImage( img, classLabel, descCount )
      obj.img        = img;
      obj.grayImg    = zeros(size(img));
      obj.classLabel = classLabel;
      
      if size(img, 3) ~= 3,
        obj.grayImg = single( img );
      else
        obj.grayImg = single(rgb2gray( img ));
      end
      obj.imgSize = size( obj.grayImg );
      
      % generate sampleDescs, choose 'descCount' descriptors to keep (randomly)
      [~, descs] = vl_dsift( obj.grayImg );
      rand       = randi(size(descs, 2), 1, descCount);   
      
%       obj.allDescs    = single( descs );
      obj.sampleDescs = single( descs(:, rand) );
      obj.bagOfWords  = zeros( 1, size(obj.sampleDescs, 2) );
    end
      
  end
  
end

