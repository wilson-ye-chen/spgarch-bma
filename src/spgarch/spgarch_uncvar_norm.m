function [uncVar, spExp] = spgarch_uncvar_norm(omega, spCoef, k)
% [uncVar, spExp] = spgarch_uncvar_norm(omega, spCoef, k) computes
% the unconditional-variance of the SPGARCH-Normal model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   August 14, 2013

    b0    = spCoef(1);
    b2    = spCoef(3);
    beta  = spCoef(4:end);
    c     = spgarch_cval(k);
    
    beta = reshape(beta, 1, length(beta));
    c    = reshape(c, length(c), 1);
    
    spExp  = b0 + b2 + (beta * c);
    uncVar = omega ./ (1 - spExp);
end
