function generateHistogram( images )
%GENERATEHISTOGRAM Visualization of the bag of words
%   Makes use of MATLAB 'hist' function to visualize a given bag of words
%
% INPUT
% - b_o_w: Bag of words

  imageCount = length( images );
  catCount   = 4;
  imgs_per_cat = imageCount / catCount;
  figure;
  hold on;
  for i = 1:imageCount,
    image = images(i);
    subplot( catCount, imgs_per_cat, i);
    hist( image.bagOfWords );
  end
  hold off;
end

