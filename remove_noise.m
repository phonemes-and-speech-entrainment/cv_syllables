%{
Linear regression to 1/f remove noise from EEG power spectrum

Y = H*Astar + e 

describes a linear relationship between the dependent variables in Y and the independent variables in H.

Astar = vector of regression coefficients 
e = error

If we take the logarithms of both the EEG power and the frequency vectors, we can find what linear relationship exists between them using linear regression.

In this case:

Y = vector of the log of power
H = matrix of intercept and the log of frequency 

To find the linear relationship, we need to find the coefficients in Astar assuming that the error in e is zero, using the equation

Astar=inv(H'*H)*H'*Y

The linear relationship between the log of frequency and that of power will thus be described by:

Ytilde = H*Astar, not equal to Y

(C) Oana Cucu, 2017
%}

function F_pow=remove_noise(Pow,f)
logf=log(f);                      %take logarithm of frequency vector
logpow=log(Pow);                  %take logarithm of power vector
H=[ones(length(logf),1),logf];    %matrix containing the intercept and the independent log frequency variables
Astar=inv(H'*H)*H'*logpow;        %find regression coefficients assuming error is zero 
Ytilde=H*Astar;                   %multiply the log frequency variables by their regression coefficients to find linear relationship between these and the log of power
L_pow=logpow-Ytilde;              %remove the linear dependence of the log power on the log frequency from the existent log power
F_pow=exp(L_pow);                 %take the exponent of the result to obtain 1/f free power




