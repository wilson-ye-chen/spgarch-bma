function maxStuck = findmaxstuck(Chain)
% maxStuck = findmaxstuck(Chain) finds the maximum number of
% iterations that the Markov chain constructed by a MCMC algorithm
% gets stuck.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   October 20, 2013

    nIter = size(Chain, 1);
    nStuck = ones(nIter, 1);
    for i = 2:nIter
        if isequal(Chain(i, :), Chain(i - 1, :))
            nStuck(i) = nStuck(i - 1) + 1;
        end
    end
    maxStuck = max(nStuck);
end
