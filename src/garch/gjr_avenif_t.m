function yAve = gjr_avenif_t(x, Theta)
% yAve = gjr_avenif_t(x, Theta) computes the values of the news impact
% function by averaging over those given by sampled parameters.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 20, 2014

    nTheta = size(Theta, 1);
    ySum = zeros(size(x));
    for i = 1:nTheta
        alpha1 = Theta(i, 4);
        alpha2 = Theta(i, 5);
        beta = Theta(i, 6);
        y = nif(x, alpha1, alpha2, beta);
        ySum = ySum + y;
    end
    yAve = ySum ./ nTheta;
end

function y = nif(x, alpha1, alpha2, beta)
    y = ...
        alpha1 .* (x .^ 2) + ...
        alpha2 .* (x .^ 2) .* double(x < 0) + ...
        beta;
end
