% in the equation in the assignment there's a x, where is it from?
% i just added it to arguments of the function
function G = gaussian(sigma, x)
    G = ( 1 / ( sigma * sqrt( 2 * pi ) ) * exp ( - ( x ^ 2 ) / ( 2 * sigma ^ 2 ) ) );
end