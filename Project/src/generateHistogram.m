function generateHistogram( b_o_w )
%GENERATEHISTOGRAM Visualization of the bag of words
%   Makes use of MATLAB 'hist' function to visualize a given bag of words
%
% INPUT
% - b_o_w: Bag of words

  pCount = size(b_o_w, 1);
  catCount = 4;
  imgs_per_cat = pCount / catCount;
  figure;
  
  for p=1:pCount,
    subplot( catCount, imgs_per_cat, p);
    hist( b_o_w(p, : ) );
  end
  
end

