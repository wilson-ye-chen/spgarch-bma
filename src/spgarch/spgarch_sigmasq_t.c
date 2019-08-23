/**
 * File: spgarch_sigmasq_t.c
 * Purpose:
 * Evaluates the conditional variances of the SPGARCH-t model.
 *
 * Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
 * Date:   January 19, 2014
 */

#include <math.h>
#include "matrix.h"

#define SQUARE(x) ((x) * (x))

bool eval_sigmasq(
    double* sigmaSq,
    const int nReturns,
    const double* a,
    const int nKnots,
    const double* k,
    const double sigmaSq0,
    const double nu,
    const double omega,
    const double* spCoef);

void mexFunction(int nlhs, mxArray** plhs, int nrhs, const mxArray** prhs)
{
    double* sigmaSq;
    bool    allPos;
    
    /* Input arguments */
    int     nReturns   = mxGetNumberOfElements(prhs[0]);
    double* a          = mxGetPr(prhs[0]);
    int     nKnots     = mxGetNumberOfElements(prhs[1]);
    double* k          = mxGetPr(prhs[1]);
    double  sigmaSq0   = mxGetScalar(prhs[2]);
    double  nu         = mxGetScalar(prhs[3]);
    double  omega      = mxGetScalar(prhs[4]);
    double* spCoef     = mxGetPr(prhs[5]);
    
    /* Allocate output memory */
    plhs[0] = mxCreateDoubleMatrix((nReturns + 1), 1, mxREAL);
    sigmaSq = mxGetPr(plhs[0]);
    
    /* Evaluate conditional variances */
    allPos = eval_sigmasq(
        sigmaSq,
        nReturns,
        a,
        nKnots,
        k,
        sigmaSq0,
        nu,
        omega,
        spCoef);
    
    /* Output positivity flag */
    plhs[1] = mxCreateLogicalScalar(allPos);
    
    return;
}

bool eval_sigmasq(
    double* sigmaSq,
    const int nReturns,
    const double* a,
    const int nKnots,
    const double* k,
    const double sigmaSq0,
    const double nu,
    const double omega,
    const double* spCoef)
{
    int    i;
    int    j;
    double tempSum;
    double tempDif;
    double prevEps;
    
    /* Evaluate conditional variances */
    sigmaSq[0] = sigmaSq0;
    for (i = 1; i <= nReturns; i++)
    {
        /* Evaluate standardized return */
        prevEps = a[i - 1] / sqrt(sigmaSq[i - 1] * (nu - 2) / nu);
        /* Evaluate quadratic-spline */
        tempSum = spCoef[0] +
                  spCoef[1] * prevEps +
                  spCoef[2] * SQUARE(prevEps);
        for (j = 0; j < nKnots; j++)
        {
            tempDif = prevEps - k[j];
            tempSum += spCoef[3 + j] *
                       SQUARE(tempDif) *
                       (double)(tempDif >= 0.0);
        }
        /* Evaluate conditional variance */
        sigmaSq[i] = omega + (sigmaSq[i - 1] * tempSum);
        /* Check for positivity */
        if (sigmaSq[i] <= 0.0)
        {
            return false;
        }
    }
    return true;
}
