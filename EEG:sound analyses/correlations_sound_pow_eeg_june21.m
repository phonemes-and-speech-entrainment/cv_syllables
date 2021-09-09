close all; clearvars;clc;

load('/Volumes/Seagate Portable Drive/Speech EEG/Experiment 2/Experiment 2 stimuli/Power_sounds_4hz_harmonics.mat');
load('/Volumes/Seagate Portable Drive/Speech EEG/Experiment 2/Experiment 2 datasets 3/evoked_pow_for_stats.mat');
load('/Volumes/Seagate Portable Drive/Speech EEG/Experiment 2/Experiment 2 datasets 3/Itc_for_stats.mat');

pow4_sounds_cond = reshape(pow4_sounds,3,15);
pow4_sounds_mean = mean(pow4_sounds_cond,1)';

pow8_sounds_cond = reshape(pow8_sounds,3,15);
pow8_sounds_mean = mean(pow8_sounds_cond,1)';

pow12_sounds_cond = reshape(pow12_sounds,3,15);
pow12_sounds_mean = mean(pow12_sounds_cond,1)';

pow16_sounds_cond = reshape(pow16_sounds,3,15);
pow16_sounds_mean = mean(pow16_sounds_cond,1)';

evoked_pow4_stream = mean(evoked_pow4,2);
evoked_pow8_stream = mean(evoked_pow8,2);
evoked_pow12_stream = mean(evoked_pow12,2);
evoked_pow16_stream = mean(evoked_pow16,2);

evoked_pow4_cond = mean(meanevokedpow4,2);
evoked_pow8_cond = mean(meanevokedpow8,2);
evoked_pow12_cond = mean(meanevokedpow12,2);
evoked_pow16_cond = mean(meanevokedpow16,2);

itc4_stream = mean(Itc4,2);
itc8_stream = mean(Itc8,2);
itc12_stream = mean(Itc12,2);
itc16_stream = mean(Itc16,2);

itc4_cond = mean(meanitc4,2);
itc8_cond = mean(meanitc8,2);
itc12_cond = mean(meanitc12,2);
itc16_cond = mean(meanitc16,2);

%correlations between EEG and sound power
%condition
fprintf('Condition \nITPC \nCorrelation at 4 Hz\n');
[rho,pval]=corr(itc4_cond,pow4_sounds_mean)
fprintf('Correlation at 8 Hz\n');
[rho,pval]=corr(itc8_cond,pow8_sounds_mean)
fprintf('Correlation at 12 Hz\n');
[rho,pval]=corr(itc12_cond,pow12_sounds_mean)
fprintf('Correlation at 16 Hz\n');
[rho,pval]=corr(itc16_cond,pow16_sounds_mean)

fprintf('Evoked power \nCorrelation at 4 Hz\n');
[rho,pval]=corr(evoked_pow4_cond,pow4_sounds_mean)
fprintf('Correlation at 8 Hz\n');
[rho,pval]=corr(evoked_pow8_cond,pow8_sounds_mean)
fprintf('Correlation at 12 Hz\n');
[rho,pval]=corr(evoked_pow12_cond,pow12_sounds_mean)
fprintf('Correlation at 16 Hz\n');
[rho,pval]=corr(evoked_pow16_cond,pow16_sounds_mean)

%stream
fprintf('Stream \nITPC \nCorrelation at 4 Hz\n');
[rho,pval]=corr(itc4_stream,pow4_sounds)
fprintf('Correlation at 8 Hz\n');
[rho,pval]=corr(itc8_stream,pow8_sounds)
fprintf('Correlation at 12 Hz\n');
[rho,pval]=corr(itc12_stream,pow12_sounds)
fprintf('Correlation at 16 Hz\n');
[rho,pval]=corr(itc16_stream,pow16_sounds)

fprintf('Evoked power \nCorrelation at 4 Hz\n');
[rho,pval]=corr(evoked_pow4_stream,pow4_sounds)
fprintf('Correlation at 8 Hz\n');
[rho,pval]=corr(evoked_pow8_stream,pow8_sounds)
fprintf('Correlation at 12 Hz\n');
[rho,pval]=corr(evoked_pow12_stream,pow12_sounds)
fprintf('Correlation at 16 Hz\n');
[rho,pval]=corr(evoked_pow16_stream,pow16_sounds)