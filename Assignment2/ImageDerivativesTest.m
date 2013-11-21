function ImageDerivativesTest
  % TODO Play around with these values and find the 'best' output
  sigmas = [1 10 20];
  impulse = zeros(40, 40);
  impulse(20, 20) = 255;
  f = figure;
  for i = 1:length(sigmas),
    sigma = sigmas(i);
      
    img = ImageDerivatives(impulse, sigma, 'x');
    subplot(length(sigmas), 6, (i-1)*6 + 1);
    imshow(img, []);  title(strcat('x, sigma = ', num2str(sigma)));
  
    img = ImageDerivatives(impulse, sigma, 'y');
    subplot(length(sigmas), 6, (i-1)*6 + 2);
    imshow(img, []);  title(strcat('y, sigma = ', num2str(sigma)));

    img = ImageDerivatives(impulse, sigma, 'xx');
    subplot(length(sigmas), 6, (i-1)*6 + 3);
    imshow(img, []);  title(strcat('xx, sigma = ', num2str(sigma)));

    img = ImageDerivatives(impulse, sigma, 'yy');
    subplot(length(sigmas), 6, (i-1)*6 + 4);
    imshow(img, []);  title(strcat('yy, sigma = ', num2str(sigma)));

    img = ImageDerivatives(impulse, sigma, 'xy');
    subplot(length(sigmas), 6, (i-1)*6 + 5);
    imshow(img, []);  title(strcat('xy, sigma = ', num2str(sigma)));

    img = ImageDerivatives(impulse, sigma, 'yx');
    subplot(length(sigmas), 6, (i-1)*6 + 6);
    imshow(img, []);  title(strcat('yx, sigma = ', num2str(sigma)));
  end
  saveas(f, 'impulse.png');
end