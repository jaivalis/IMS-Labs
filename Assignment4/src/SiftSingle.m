classdef SiftSingle
  %SIFTSINGLE Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    grayImg
    img_size
    frames
    desc
    matches
  end
  
  methods
    % default constructor
    function obj = SiftSingle(img)
      obj.grayImg = zeros(size(img));
      if size(img, 3) ~= 3,
        obj.grayImg = single( img );
      else
        obj.grayImg = single(rgb2gray( img ));
      end
      obj.img_size = size( obj.grayImg );
    end
    
    
  end  
end