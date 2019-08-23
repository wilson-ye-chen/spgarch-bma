/**
 * File: spgarch_sigmasq.c
 * Purpose:
 * Evaluates the conditional variances of the Semi-parametric GARCH model.
 *
 * Author: Wilson Y. Chen
 * Date:   August 12, 2013
 */

#include <math.h>
#include "matrix.h"

#define SQUARE(x) ((x) * (x))

bool eval_sigmasq(
    double* sigmaSq,
    double* epsilon,
    const int nReturns,
    const double* a,
    const int nKnots,
    const double* k,
    const double sigmaSq0,
    const double omega,
    const double* spCoef);

void mexFunction(int nlhs, mxArray** plhs, int nrhs, const mxArray** prhs)
{
    double* sigmaSq;
    double* epsilon;
    bool    allPos;
    
    /* Input arguments */
    int     nReturns   = mxGetNumberOfElements(prhs[0]);
    double* a          = mxGetPr(prhs[0]);
    int     nKnots     = mxGetNumberOfElements(prhs[1]);
    double* k          = mxGetPr(prhs[1]);
    double  sigmaSq0   = mxGetScalar(prhs[2]);
    double  omega      = mxGetScalar(prhs[3]);
    double* spCoef     = mxGetPr(prhs[4]);
    
    /* Allocate output memory */
    plhs[0] = mxCreateDoubleMatrix((nReturns + 1), 1, mxREAL);
    sigmaSq = mxGetPr(plhs[0]);
    
    /* Allocate temporary working memory */
    epsilon = malloc(nReturns * sizeof(double));
    
    /* Evaluate conditional variances */
    allPos = eval_sigmasq(
        sigmaSq,
        epsilon,
        nReturns,
        a,
        nKnots,
        k,
        sigmaSq0,
        omega,
        spCoef);
    
    /* Output positivity flag */
    plhs[1] = mxCreateLogicalScalar(allPos);
    
    /* Free temporary working memory */
    free(epsilon);
    
    return;
}

bool eval_sigmasq(
    double* sigmaSq,
    double* epsilon,
    const int nReturns,
    const double* a,
    const int nKnots,
    const double* k,
    const double sigmaSq0,
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
        epsilon[i - 1] = a[i - 1] / sqrt(sigmaSq[i - 1]);
        prevEps = epsilon[i - 1];
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
