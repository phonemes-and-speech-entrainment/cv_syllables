%{

The first component of the PCA run on the ITC at 4, 8, 12 and 16 Hz is
correlated with each of the edge markers.

(c) Oana Cucu 2019. oana.cucu@bristol.ac.uk

%}

clearvars;clc;

load('itc_pca1_for_stats.mat');
%load('evoked_pow_for_corr.mat');
itc_corr=mean(mean_itc_pca1,2);
%pow_corr=mean(evokedpow4_2,2);
load('sound_properties_short_syllables.mat');
load('peakder_prop_cond.mat');

%itc
fprintf('Correlation with time of peak derivative\n');
[rho,pval]=corr(itc_corr,cv_all)
fprintf('Correlation with peak derivative\n');
[rho,pval]=corr(itc_corr,peakder_all)
fprintf('Correlation with sharpness\n');
[rho,pval]=corr(itc_corr,sharp_all)
fprintf('Correlation with normalised sharpness\n');
[rho,pval]=corr(itc_corr,nsharp_all)
fprintf('Correlation with gini index\n');
[rho,pval]=corr(itc_corr,gini_all)
fprintf('Correlation with maximum amplitude\n');
[rho,pval]=corr(itc_corr,amp_all)
fprintf('Correlation with time of maximum amplitude\n');
[rho,pval]=corr(itc_corr,time_all)


%{
%pow
fprintf('Correlation with time of peak derivative\n');
[rho,pval]=corr(pow_corr,cv_all)
fprintf('Correlation with peak derivative\n');
[rho,pval]=corr(pow_corr,peakder_all)
fprintf('Correlation with variance of time of peak derivative\n');
[rho,pval]=corr(pow_corr,var_all)
fprintf('Correlation with st dev of time of peak derivative\n');
[rho,pval]=corr(pow_corr,sqrt(var_all))
fprintf('Correlation with sharpness\n');
[rho,pval]=corr(pow_corr,sharp_all)
fprintf('Correlation with normalised sharpness\n');
[rho,pval]=corr(pow_corr,nsharp_all)
fprintf('Correlation with gini index\n');
[rho,pval]=corr(pow_corr,gini_all)
fprintf('Correlation with maximum amplitude\n');
[rho,pval]=corr(pow_corr,amp_all)
fprintf('Correlation with time of maximum amplitude\n');
[rho,pval]=corr(pow_corr,time_all)
fprintf('Correlation with variance of time of maximum amplitude\n');
[rho,pval]=corr(pow_corr,tvar_all)
%}