function [uncVar, spExp] = spgarch_uncvar_tf(nu, omega, spCoef, C, nuC)
% [uncVar, spExp] = spgarch_uncvar_tf(nu, omega, spCoef, C, nuC) computes
% the unconditional-variance of the SPGARCH-t model. This is the "fast"
% version of the "spgarch_uncvar_t" function, where the "c" value is found
% via a table lookup instead of numerical integration.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   July 8, 2016

    b0   = spCoef(1);
    b2   = spCoef(3);
    beta = spCoef(4:end);
    
    [~, iC] = min(abs(nuC - nu));
    c = C(iC, :);
    
    beta = beta(:)';
    c = c(:);
    
    spExp = b0 + b2 + (beta * c);
    uncVar = omega ./ (1 - spExp);
end
