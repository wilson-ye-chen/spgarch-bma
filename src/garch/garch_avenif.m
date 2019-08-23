function yAve = garch_avenif(x, Theta)
% yAve = garch_avenif(x, Theta) computes the values of the news impact
% function by averaging over those given by sampled parameters.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   December 7, 2013

    nTheta = size(Theta, 1);
    ySum = zeros(size(x));
    for i = 1:nTheta
        alpha = Theta(i, 3);
        beta = Theta(i, 4);
        y = nif(x, alpha, beta);
        ySum = ySum + y;
    end
    yAve = ySum ./ nTheta;
end

function y = nif(x, alpha, beta)
    y = alpha .* (x .^ 2) + beta;
end
