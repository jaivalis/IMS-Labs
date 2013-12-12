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
    function obj = SiftImage( img, classLabel, descCount,  siftType)
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
      switch siftType
        case 'dense'
          [~, descs] = vl_dsift( obj.grayImg );
        case 'keyPoints'
          [~, descs] = vl_sift( single(obj.grayImg) );
        case 'rgb'
          [~, descs] = vl_sift( single(obj.img(:, :, 1)) );
          [~, temp] = vl_sift( single(obj.img(:, :, 2)) );
          descs = cat(2, descs, temp);
          [~, temp] = vl_sift( single(obj.img(:, :, 3)) );
          descs = cat(2, descs, temp);
        case 'RGB'
          % normalized rgb?
        case 'opponent'
          opp1(:, :) = ( obj.img(:, :, 1) - obj.img(:, :, 2) ) / sqrt(2);
          opp2(:, :) = ( ( obj.img(:, :, 1) + obj.img(:, :, 2) ) - 2 * obj.img(:, :, 3) ) / sqrt(6);
          opp3(:, :) = ( ( obj.img(:, :, 1) + obj.img(:, :, 2) ) + obj.img(:, :, 3) ) / sqrt(3);
          [~, descs] = vl_sift( single(opp1) );
          [~, temp] = vl_sift( single(opp2) );
          descs = cat(2, descs, temp);
          [~, temp] = vl_sift( single(opp3) );
          descs = cat(2, descs, temp);
      end 
      rand       = randi(size(descs, 2), 1, descCount);   
      
%       obj.allDescs    = single( descs );
      obj.sampleDescs = single( descs(:, rand) );
      obj.bagOfWords  = zeros( 1, size(obj.sampleDescs, 2) );
    end
      
  end
  
end

