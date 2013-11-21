function last
  sigmas = [30];
  impulse = zeros(501,501);
  impulse(256,256) = 1;

  for i = 1:length(sigmas),
    sigma = sigmas(i);
      
    img = ImageDerivatives(impulse, sigma, 'x');
    figure((i-1) + 1);
    imshow(img);  title(strcat('x, sigma = ', num2str(sigma)));
  
    img = ImageDerivatives(impulse, sigma, 'y');
    figure((i-1) + 2);
    imshow(img,[]);  title(strcat('y, sigma = ', num2str(sigma)));

    img = ImageDerivatives(impulse, sigma, 'xx');
    figure((i-1) + 3);
    imshow(img,[]);  title(strcat('xx, sigma = ', num2str(sigma)));

    img = ImageDerivatives(impulse, sigma, 'yy');
    figure((i-1) + 4);
    imshow(img,[]);  title(strcat('yy, sigma = ', num2str(sigma)));

    img = ImageDerivatives(impulse, sigma, 'xy');
    figure((i-1) + 5);
    imshow(img,[]);  title(strcat('xy, sigma = ', num2str(sigma)));

    img = ImageDerivatives(impulse, sigma, 'yx');
    figure((i-1) + 6);
    imshow(img,[]);  title(strcat('yx, sigma = ', num2str(sigma)));
  end

end