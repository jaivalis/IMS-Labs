classdef SiftImage
  %SIFTIMAGE Image class containing the required properties for images
  %   All images read from the input folders will be mapped to a SiftImage
  %   instance
  
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
      
      % http://web.njit.edu/~sb256/research_files/CACS.pdf
      % generate sampleDescs, choose 'descCount' descriptors to keep (randomly)
      switch siftType
        case 'dense'
          [~, descs] = vl_dsift( obj.grayImg );
        case 'keyPoints'
          [~, descs] = vl_sift( single(obj.grayImg) );
        case 'rgb'
          intensity = obj.grayImg;
          threshold = max(max(intensity())) / 2;
          filter = intensity>threshold;
          r = filter .* single(obj.img(:, :, 1));
          g = filter .* single(obj.img(:, :, 2));
          b = filter .* single(obj.img(:, :, 3));
          [~, descs1] = vl_sift( r );
          [~, temp] = vl_sift( g );
          descs = cat(2, descs1, temp);
          [~, temp] = vl_sift( b );
          descs = cat(2, descs, temp);
        case 'RGB'
          % normalized rgb
          intensity = obj.grayImg;
          threshold = max(max(intensity())) / 2;
          filter = intensity>threshold;
          r = filter .* single(obj.img(:, :, 1));
          g = filter .* single(obj.img(:, :, 2));
          b = filter .* single(obj.img(:, :, 3));
          r_norm = r ./ (r + g + b);
          g_norm = g ./ (r + g + b);
          b_norm = b ./ (r + g + b);
          r_norm(isnan(r_norm)) = 1/sqrt(3);
          g_norm(isnan(g_norm)) = 1/sqrt(3);
          b_norm(isnan(b_norm)) = 1/sqrt(3);
          [~, descs1] = vl_sift( r_norm );
          [~, temp] = vl_sift( g_norm );
          descs = cat(2, descs1, temp);
          [~, temp] = vl_sift( b_norm );
          descs = cat(2, descs, temp);
        case 'opponent'
          intensity = obj.grayImg;
          threshold = max(max(intensity())) / 2;
          filter = intensity>threshold;
          opp1(:, :) = filter .* single(( obj.img(:, :, 1) - obj.img(:, :, 2) ) / sqrt(2));
          opp2(:, :) = filter .* single(( ( obj.img(:, :, 1) + obj.img(:, :, 2) ) - 2 * obj.img(:, :, 3) ) / sqrt(6));
          opp3(:, :) = filter .* single(( ( obj.img(:, :, 1) + obj.img(:, :, 2) ) + obj.img(:, :, 3) ) / sqrt(3));
          [~, descs] = vl_sift( single(opp1) );
          [~, temp] = vl_sift( single(opp2) );
          descs = cat(2, descs, temp);
          [~, temp] = vl_sift( single(opp3) );
          descs = cat(2, descs, temp);
        case 'all'
          % TOTO ???
      end
      
      % if siftType is dense, only select 100 descriptors randomly, since
      % size of all descriptors for one image is 130.000 otherwise
      if strcmp(siftType,'dense')
        rand            = randi(size(descs, 2), 1, descCount);   
        obj.sampleDescs = single( descs(:, rand) );
      else
        obj.sampleDescs = descs;
      end
      
      obj.bagOfWords  = zeros( 1, size(obj.sampleDescs, 2) );
      
    end
      
  end
  
end

