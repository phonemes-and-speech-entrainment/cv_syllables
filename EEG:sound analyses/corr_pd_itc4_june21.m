close all; clearvars; clc;

load('/Volumes/Seagate Portable Drive/Speech EEG/Experiment 2/Experiment 2 datasets 3/Itc_for_stats.mat');
load('/Volumes/Seagate Portable Drive/Speech EEG/Experiment 2/Experiment 2 syllables/Short/Sound_properties_may21.mat');

peakder_cond = sound_prop2_cond(:,1);
time_peakder_cond = sound_prop2_cond(:,2);
sharp_doe_cond = sound_prop2_cond(:,3);
sharp_norm_cond = sound_prop2_cond(:,4);
gini_cond = sound_prop2_cond(:,5);
max_amp_cond = sound_prop2_cond(:,6);
time_ma_cond = sound_prop2_cond(:,7);
interval_ma_cond = sound_prop2_cond(:,8);
interval_peakder_cond = sound_prop2_cond(:,9);
interval_plateau_cond = sound_prop2_cond(:,10);
time80_cond = sound_prop2_cond(:,11);


meanitc4_cond = mean(meanitc4,2);
meanitc8_cond = mean(meanitc8,2);
meanitc12_cond = mean(meanitc12,2);
meanitc16_cond = mean(meanitc16,2);

fprintf('ITPC 4 Hz \nCorrelation with time of peak derivative\n');
[rho,pval]=corr(meanitc4_cond,time_peakder_cond)
fprintf('Correlation with peak derivative\n');
[rho,pval]=corr(meanitc4_cond,peakder_cond)
fprintf('Correlation with sharpness\n');
[rho,pval]=corr(meanitc4_cond,sharp_doe_cond)
fprintf('Correlation with normalised sharpness\n');
[rho,pval]=corr(meanitc4_cond,sharp_norm_cond)
fprintf('Correlation with gini index\n');
[rho,pval]=corr(meanitc4_cond,gini_cond)
fprintf('Correlation with maximum amplitude\n');
[rho,pval]=corr(meanitc4_cond,max_amp_cond)
fprintf('Correlation with time of maximum amplitude\n');
[rho,pval]=corr(meanitc4_cond,time_ma_cond)
fprintf('Correlation with interval to maximum amplitude\n');
[rho,pval]=corr(meanitc4_cond,interval_ma_cond)
fprintf('Correlation with interval to peak derivative\n');
[rho,pval]=corr(meanitc4_cond,interval_peakder_cond)
fprintf('Correlation with plateau interval\n');
[rho,pval]=corr(meanitc4_cond,interval_plateau_cond)
fprintf('Correlation with time to 80 MA\n');
[rho,pval]=corr(meanitc4_cond,time80_cond)
fprintf('Correlation with time to 80 PD\n');
[rho,pval]=corr(meanitc4_cond,80/100*time_peakder_cond)

fprintf('ITPC 8 Hz \nCorrelation with time of peak derivative\n');
[rho,pval]=corr(meanitc8_cond,time_peakder_cond)
fprintf('Correlation with peak derivative\n');
[rho,pval]=corr(meanitc8_cond,peakder_cond)
fprintf('Correlation with sharpness\n');
[rho,pval]=corr(meanitc8_cond,sharp_doe_cond)
fprintf('Correlation with normalised sharpness\n');
[rho,pval]=corr(meanitc8_cond,sharp_norm_cond)
fprintf('Correlation with gini index\n');
[rho,pval]=corr(meanitc8_cond,gini_cond)
fprintf('Correlation with maximum amplitude\n');
[rho,pval]=corr(meanitc8_cond,max_amp_cond)
fprintf('Correlation with time of maximum amplitude\n');
[rho,pval]=corr(meanitc8_cond,time_ma_cond)
fprintf('Correlation with interval to maximum amplitude\n');
[rho,pval]=corr(meanitc8_cond,interval_ma_cond)
fprintf('Correlation with interval to peak derivative\n');
[rho,pval]=corr(meanitc8_cond,interval_peakder_cond)
fprintf('Correlation with plateau interval\n');
[rho,pval]=corr(meanitc8_cond,interval_plateau_cond)
fprintf('Correlation with time to 80 MA\n');
[rho,pval]=corr(meanitc8_cond,time80_cond)
fprintf('Correlation with time to 80 PD\n');
[rho,pval]=corr(meanitc8_cond,80/100*time_peakder_cond)

fprintf('ITPC 12 Hz \nCorrelation with time of peak derivative\n');
[rho,pval]=corr(meanitc12_cond,time_peakder_cond)
fprintf('Correlation with peak derivative\n');
[rho,pval]=corr(meanitc12_cond,peakder_cond)
fprintf('Correlation with sharpness\n');
[rho,pval]=corr(meanitc12_cond,sharp_doe_cond)
fprintf('Correlation with normalised sharpness\n');
[rho,pval]=corr(meanitc12_cond,sharp_norm_cond)
fprintf('Correlation with gini index\n');
[rho,pval]=corr(meanitc12_cond,gini_cond)
fprintf('Correlation with maximum amplitude\n');
[rho,pval]=corr(meanitc12_cond,max_amp_cond)
fprintf('Correlation with time of maximum amplitude\n');
[rho,pval]=corr(meanitc12_cond,time_ma_cond)
fprintf('Correlation with interval to maximum amplitude\n');
[rho,pval]=corr(meanitc12_cond,interval_ma_cond)
fprintf('Correlation with interval to peak derivative\n');
[rho,pval]=corr(meanitc12_cond,interval_peakder_cond)
fprintf('Correlation with plateau interval\n');
[rho,pval]=corr(meanitc12_cond,interval_plateau_cond)
fprintf('Correlation with time to 80 MA\n');
[rho,pval]=corr(meanitc12_cond,time80_cond)
fprintf('Correlation with time to 80 PD\n');
[rho,pval]=corr(meanitc12_cond,80/100*time_peakder_cond)

fprintf('ITPC 16 Hz \nCorrelation with time of peak derivative\n');
[rho,pval]=corr(meanitc16_cond,time_peakder_cond)
fprintf('Correlation with peak derivative\n');
[rho,pval]=corr(meanitc16_cond,peakder_cond)
fprintf('Correlation with sharpness\n');
[rho,pval]=corr(meanitc16_cond,sharp_doe_cond)
fprintf('Correlation with normalised sharpness\n');
[rho,pval]=corr(meanitc16_cond,sharp_norm_cond)
fprintf('Correlation with gini index\n');
[rho,pval]=corr(meanitc16_cond,gini_cond)
fprintf('Correlation with maximum amplitude\n');
[rho,pval]=corr(meanitc16_cond,max_amp_cond)
fprintf('Correlation with time of maximum amplitude\n');
[rho,pval]=corr(meanitc16_cond,time_ma_cond)
fprintf('Correlation with interval to maximum amplitude\n');
[rho,pval]=corr(meanitc16_cond,interval_ma_cond)
fprintf('Correlation with interval to peak derivative\n');
[rho,pval]=corr(meanitc16_cond,interval_peakder_cond)
fprintf('Correlation with plateau interval\n');
[rho,pval]=corr(meanitc16_cond,interval_plateau_cond)
fprintf('Correlation with time to 80 MA\n');
[rho,pval]=corr(meanitc16_cond,time80_cond)
fprintf('Correlation with time to 80 PD\n');
[rho,pval]=corr(meanitc16_cond,80/100*time_peakder_cond)


sounds={'Vow';'/b/';'/d/';'/g/';'/k/';'/p/';'/t/';'/m/';'/n/';'/s/';'/z/';'/l/';'/r/';'/f/';'/v/'};
edge_corr = [meanitc4_cond,time_peakder_cond];
[r_matrix,p_matrix]=corrcoef(edge_corr);
r=r_matrix(1,2);
p=p_matrix(1,2);

fig=figure('Renderer', 'painters', 'Position', [10 10 500 450]);

gsounds = {'Vowels';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Nasals';'Nasals';'Sibilants';'Sibilants';'Rhotics';'Rhotics';'Fricatives';'Fricatives'};
h1=gscatter(meanitc4_cond,time_peakder_cond,gsounds,'k','o',7.5);
hold on;
mdl = fitlm(meanitc4_cond,time_peakder_cond);
h2 = plot(mdl) ;
delete(h2(1));
delete(h2(3));
delete(h2(4));
set(h2(2),'LineStyle','--','Color',[0.5 0.5 0.5],'LineWidth',1);
text(meanitc4_cond,time_peakder_cond,sounds,'horizontal','right','vertical','bottom');
title('ITPC 4 Hz vs latency of peak derivative','FontSize',14,'FontWeight','bold');
xlabel('ITPC 4 Hz','FontWeight','bold');
ylabel('Time to PD','FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
vowels=h1(1);
vstops=h1(2);
ustops=h1(3);
fricatives=h1(7);
rhotics=h1(6);
nasals=h1(4);
sibilants=h1(5);
vowels.MarkerFaceColor=[0.02 0.8 0.18];
vstops.MarkerFaceColor=[1 0.5 0];
ustops.MarkerFaceColor=[0.93 0.69 0.13];
fricatives.MarkerFaceColor=[0.57 0.04 0.75];
rhotics.MarkerFaceColor=[0.13 0.67 0.9];
nasals.MarkerFaceColor=[0.2857 0 1];
sibilants.MarkerFaceColor=[1 0 1];
set(gca,'LineWidth',1);
legend('Vowels','Voiced Stops','Unvoiced Stops','Nasals','Sibilants','Liquids','Fricatives','Location','Southeast');%'Position',[0.2 0.513 0.05 0.03]
legend('Position',[0.75 0.78 0.05 0.03]);
s1=['r = ',num2str(round(r,2))];
s2='***';
T = text(0.16, 75, strcat(s1,s2)); 
set(T, 'fontsize', 13,'fontweight','bold');
ylim([0 110]);
box on;
