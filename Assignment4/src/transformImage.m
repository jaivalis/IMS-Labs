function trnsfrmd = transfomrImage( img, x )
%TRANSFORMIMAGE Performs a transformation of an image given the parameters
%   Detailed explanation goes here
%
% INPUT
% - img:      Image to be transformed
% - x:        Transformation parameters
% 
% OUTPUT
% - trnsfrmd: Transformed image

% reshape bestSolution
Sol_reshaped = [x(1), x(2) 0;...
                x(3), x(4) 0;...
                x(5), x(6) 1];
  
  size_img = size(img1);
  im_translated = zeros(size_img(1), size_img(2), 1);
  
  for x=1:size_img(1)
    for y =1:size_img(2)
      temp = double([img2(x) img2(y) 1]) * double(Sol_reshaped);
%       [u, v] = getNearestPixel(temp(1),temp(2));
      im_translated(round(temp(1)),round(temp(2))) = img2(x,y);
    end
  end


trnsfrmd = im_translated;

end

