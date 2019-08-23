/**
 * File: garch_sigmasq.c
 * Purpose:
 * Evaluates the conditional variances of the GARCH model.
 *
 * Author: Wilson Y. Chen
 * Date:   November 27, 2013
 */

#include <math.h>
#include "matrix.h"

#define SQUARE(x) ((x) * (x))

void eval_sigmasq(
    double* sigmaSq,
    const int nReturns,
    const double* a,
    const double sigmaSq0,
    const double omega,
    const double alpha,
    const double beta);

void mexFunction(int nlhs, mxArray** plhs, int nrhs, const mxArray** prhs)
{
    double* sigmaSq;
    
    /* Input arguments */
    int     nReturns = mxGetNumberOfElements(prhs[0]);
    double* a        = mxGetPr(prhs[0]);
    double  sigmaSq0 = mxGetScalar(prhs[1]);
    double  omega    = mxGetScalar(prhs[2]);
    double  alpha    = mxGetScalar(prhs[3]);
    double  beta     = mxGetScalar(prhs[4]);
    
    /* Allocate output memory */
    plhs[0] = mxCreateDoubleMatrix((nReturns + 1), 1, mxREAL);
    sigmaSq = mxGetPr(plhs[0]);
    
    /* Evaluate conditional variances */
    eval_sigmasq(sigmaSq, nReturns, a, sigmaSq0, omega, alpha, beta);
    
    return;
}

void eval_sigmasq(
    double* sigmaSq,
    const int nReturns,
    const double* a,
    const double sigmaSq0,
    const double omega,
    const double alpha,
    const double beta)
{
    int i;
    
    /* Evaluate conditional variances */
    sigmaSq[0] = sigmaSq0;
    for (i = 1; i <= nReturns; i++)
    {
        /* Evaluate conditional variance */
        sigmaSq[i] = omega +
                     alpha * SQUARE(a[i - 1]) +
                     beta * sigmaSq[i - 1];
    }
}
