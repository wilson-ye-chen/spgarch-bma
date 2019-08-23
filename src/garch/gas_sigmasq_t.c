/**
 * File: gas_sigmasq_t.c
 * Purpose:
 * Evaluates the conditional variances of the GAS-t model.
 *
 * Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
 * Date:   April 1, 2014
 */

#include <math.h>
#include "matrix.h"

#define SQUARE(x) ((x) * (x))

void eval_sigmasq(
    double* sigmaSq,
    const int nReturns,
    const double* a,
    const double sigmaSq0,
    const double nu,
    const double omega,
    const double alpha1,
    const double alpha2,
    const double beta);

void mexFunction(int nlhs, mxArray** plhs, int nrhs, const mxArray** prhs)
{
    double* sigmaSq;
    
    /* Input arguments */
    int     nReturns = mxGetNumberOfElements(prhs[0]);
    double* a        = mxGetPr(prhs[0]);
    double  sigmaSq0 = mxGetScalar(prhs[1]);
    double  nu       = mxGetScalar(prhs[2]);
    double  omega    = mxGetScalar(prhs[3]);
    double  alpha1   = mxGetScalar(prhs[4]);
    double  alpha2   = mxGetScalar(prhs[5]);
    double  beta     = mxGetScalar(prhs[6]);
    
    /* Allocate output memory */
    plhs[0] = mxCreateDoubleMatrix((nReturns + 1), 1, mxREAL);
    sigmaSq = mxGetPr(plhs[0]);
    
    /* Evaluate conditional variances */
    eval_sigmasq(
        sigmaSq,
        nReturns,
        a,
        sigmaSq0,
        nu,
        omega,
        alpha1,
        alpha2,
        beta);
    
    return;
}

void eval_sigmasq(
    double* sigmaSq,
    const int nReturns,
    const double* a,
    const double sigmaSq0,
    const double nu,
    const double omega,
    const double alpha1,
    const double alpha2,
    const double beta)
{
    int    i;
    double prevEps;
    double prevU;
    
    /* Evaluate conditional variances */
    sigmaSq[0] = sigmaSq0;
    for (i = 1; i <= nReturns; i++)
    {
        /* Evaluate standardised return */
        prevEps = a[i - 1] / sqrt(sigmaSq[i - 1]);
        /* Evaluate the score */
        prevU = (nu + 1) * SQUARE(prevEps) / (nu - 2 + SQUARE(prevEps));
        /* Evaluate conditional variance */
        sigmaSq[i] =
            omega +
            alpha1 * sigmaSq[i - 1] * prevU +
            alpha2 * sigmaSq[i - 1] * prevU * (double)(a[i - 1] < 0) +
            beta * sigmaSq[i - 1];
    }
}
