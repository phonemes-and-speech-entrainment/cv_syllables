close all; clearvars;clc;

load('/Volumes/Seagate Portable Drive/Speech EEG/Experiment 2/Experiment 2 stimuli/Power_envs_4hz_harmonics.mat');
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



sounds={'Vow';'/b/';'/d/';'/g/';'/k/';'/p/';'/t/';'/m/';'/n/';'/s/';'/z/';'/l/';'/r/';'/f/';'/v/'};
edge_corr = [itc4_cond,pow4_sounds_mean];
[r_matrix,p_matrix]=corrcoef(edge_corr);
r=r_matrix(1,2);
p=p_matrix(1,2);

%fig=figure('Renderer', 'painters', 'Position', [10 10 500 450]);

gsounds = {'Vowels';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Nasals';'Nasals';'Sibilants';'Sibilants';'Rhotics';'Rhotics';'Fricatives';'Fricatives'};
h1=gscatter(itc4_cond,pow4_sounds_mean,gsounds,'k','o',7.5);
hold on;
mdl = fitlm(itc4_cond,pow4_sounds_mean);
h2 = plot(mdl) ;
delete(h2(1));
delete(h2(3));
delete(h2(4));
set(h2(2),'LineStyle','--','Color',[0.5 0.5 0.5],'LineWidth',1);
text(itc4_cond,pow4_sounds_mean,sounds,'horizontal','right','vertical','bottom');
title('ITPC vs envelope power at 4 Hz','FontSize',14,'FontWeight','bold');
xlabel('ITPC 4 Hz','FontWeight','bold');
ylabel('Envelope Power 4 Hz','FontWeight','bold');
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
legend('Vowels','Voiced Stops','Unvoiced Stops','Nasals','Sibilants','Liquids','Fricatives','Location','Northwest');%'Position',[0.2 0.513 0.05 0.03]
%legend('Position',[0.75 0.78 0.05 0.03]);
s1=['r = ',num2str(round(r,2))];
s2=', n.s.';
T = text(0.15, 15500000, strcat(s1,s2)); 
set(T, 'fontsize', 13,'fontweight','bold');
%ylim([0 110]);
box on;
