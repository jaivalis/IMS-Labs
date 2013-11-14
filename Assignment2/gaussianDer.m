function Gd = gaussianDer(G,sigma)
    Gd = - (x / sigma ^ 2) * G; %Gd = - (x / sigma ^ 2) * gaussian(sigma);
end