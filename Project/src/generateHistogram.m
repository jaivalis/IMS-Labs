function histograms = generateHistogram( images , surpressPlots, vocSize)
%GENERATEHISTOGRAM Visualization of the bag of words
%   Makes use of MATLAB 'hist' function to visualize a given bag of words
%
% INPUT
% - images: Matrix containing instances of class image
% - vocSize: size of vocabulary
% - surpressPlots: boolean flag for plotting
%
% OUTPUT
% - histograms: Matrix containing histogram of each image

  imageCount = length( images );
  catCount   = 4;
  imgs_per_cat = imageCount / catCount;
  histograms = zeros(imageCount, vocSize);
  if ~surpressPlots
    figure;
  end
  for i = 1:imageCount,
    image = images(i);
    % normalize histograms
    normFactor = round (length(image.bagOfWords) / 100);
    histograms(i, :) = hist( image.bagOfWords , vocSize ) / normFactor;
    if ~surpressPlots
      subplot( catCount, imgs_per_cat, i);
      hist( image.bagOfWords );
    end
  end

end

