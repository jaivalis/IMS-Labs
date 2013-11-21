function last
  % TODO Play around with these values and find the 'best' output
  sigmas = [1 20 40];
  impulse = zeros(41, 41);
  impulse(20, 20) = 1;
  f = figure;
  for i = 1:length(sigmas),
    sigma = sigmas(i);
      
    img = ImageDerivatives(impulse, sigma, 'x');
    subplot(3,6,(i-1) + 1);
    imshow(img);  title(strcat('x, sigma = ', num2str(sigma)));
  
    img = ImageDerivatives(impulse, sigma, 'y');
    subplot(3,6,(i-1) + 2);
    imshow(img,[]);  title(strcat('y, sigma = ', num2str(sigma)));

    img = ImageDerivatives(impulse, sigma, 'xx');
    subplot(3,6,(i-1) + 3);
    imshow(img,[]);  title(strcat('xx, sigma = ', num2str(sigma)));

    img = ImageDerivatives(impulse, sigma, 'yy');
    subplot(3,6,(i-1) + 4);
    imshow(img,[]);  title(strcat('yy, sigma = ', num2str(sigma)));

    img = ImageDerivatives(impulse, sigma, 'xy');
    subplot(3,6,(i-1) + 5);
    imshow(img,[]);  title(strcat('xy, sigma = ', num2str(sigma)));

    img = ImageDerivatives(impulse, sigma, 'yx');
    subplot(3,6,(i-1) + 6);
    i
    imshow(img,[]);  title(strcat('yx, sigma = ', num2str(sigma)));
  end
  saveas(f, 'impulse.png');
end