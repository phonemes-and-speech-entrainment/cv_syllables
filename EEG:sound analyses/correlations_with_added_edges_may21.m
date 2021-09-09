clearvars;clc;

load('Itc_for_pca_oana.mat');
load('/Volumes/Seagate Portable Drive/Speech EEG/Experiment 2/Experiment 2 syllables/Short/Sound_properties_may21.mat');

%perform pca on itpc and calculate the first two components, then average
%per stream and condition
Itc_pca=reshape(Itc_for_pca,1125,4);

[Coeff, Score, Latent, TSquared, Explained]=pca(Itc_pca);

score_stream = reshape(Score,45,25,4);

n=3;
score_cond=arrayfun(@(i) mean(score_stream(i:i+n-1,:,:)),1:n:size(score_stream,1),'UniformOutput',false)';
score_cond=cell2mat(score_cond);

itc_score_pc1 = score_stream(:,:,1);
itc_score_pc2 = score_stream(:,:,2);

cond_itc_score_pc1 = score_cond(:,:,1);
cond_itc_score_pc2 = score_cond(:,:,2);

itc_corr1 = mean(cond_itc_score_pc1,2);
itc_corr2 = mean(cond_itc_score_pc2,2);


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


%correlations per ITPC and edge measures condition means
fprintf('ITPC1 cond\nCorrelation with time of peak derivative\n');
[rho,pval]=corr(itc_corr1,time_peakder_cond)
fprintf('Correlation with peak derivative\n');
[rho,pval]=corr(itc_corr1,peakder_cond)
fprintf('Correlation with sharpness\n');
[rho,pval]=corr(itc_corr1,sharp_doe_cond)
fprintf('Correlation with normalised sharpness\n');
[rho,pval]=corr(itc_corr1,sharp_norm_cond)
fprintf('Correlation with gini index\n');
[rho,pval]=corr(itc_corr1,gini_cond)
fprintf('Correlation with maximum amplitude\n');
[rho,pval]=corr(itc_corr1,max_amp_cond)
fprintf('Correlation with time of maximum amplitude\n');
[rho,pval]=corr(itc_corr1,time_ma_cond)
fprintf('Correlation with interval to maximum amplitude\n');
[rho,pval]=corr(itc_corr1,interval_ma_cond)
fprintf('Correlation with interval to peak derivative\n');
[rho,pval]=corr(itc_corr1,interval_peakder_cond)
fprintf('Correlation with plateau interval\n');
[rho,pval]=corr(itc_corr1,interval_plateau_cond)
fprintf('Correlation with time to 80 MA\n');
[rho,pval]=corr(itc_corr1,time80_cond)
fprintf('Correlation with time to 80 PD\n');
[rho,pval]=corr(itc_corr1,80/100*time_peakder_cond)

fprintf('ITPC2 cond\nCorrelation with time of peak derivative\n');
[rho,pval]=corr(itc_corr2,time_peakder_cond)
fprintf('Correlation with peak derivative\n');
[rho,pval]=corr(itc_corr2,peakder_cond)
fprintf('Correlation with sharpness\n');
[rho,pval]=corr(itc_corr2,sharp_doe_cond)
fprintf('Correlation with normalised sharpness\n');
[rho,pval]=corr(itc_corr2,sharp_norm_cond)
fprintf('Correlation with gini index\n');
[rho,pval]=corr(itc_corr2,gini_cond)
fprintf('Correlation with maximum amplitude\n');
[rho,pval]=corr(itc_corr2,max_amp_cond)
fprintf('Correlation with time of maximum amplitude\n');
[rho,pval]=corr(itc_corr2,time_ma_cond)
fprintf('Correlation with interval to maximum amplitude\n');
[rho,pval]=corr(itc_corr2,interval_ma_cond)
fprintf('Correlation with interval to peak derivative\n');
[rho,pval]=corr(itc_corr2,interval_peakder_cond)
fprintf('Correlation with plateau interval\n');
[rho,pval]=corr(itc_corr2,interval_plateau_cond)
fprintf('Correlation with time to 80 MA\n');
[rho,pval]=corr(itc_corr2,time80_cond)



%z-score edge measures
mean_sound_prop = mean(sound_prop2_ordered,1);
sd_sound_prop = std(sound_prop2_ordered,1);

zscore_sound_prop = (sound_prop2_ordered-mean_sound_prop)./sd_sound_prop;

zscores_for_pca = zscore_sound_prop;

save('Zscores_sound_prop_pca_may21.mat','zscores_for_pca');

%{
zscore_sound_prop_cond = reshape(zscore_sound_prop,5,15,9);
zscore_sound_cond = squeeze(mean(zscore_sound_prop_cond,1));

zscore_peakder = zscore_sound_cond(:,1);
zscore_time_peakder = zscore_sound_cond(:,2);
zscore_sharp_doe = zscore_sound_cond(:,3);
zscore_sharp_norm = zscore_sound_cond(:,4);
zscore_gini = zscore_sound_cond(:,5);
zscore_max_amp = zscore_sound_cond(:,6);
zscore_time_ma = zscore_sound_cond(:,7);
zscore_interval_ma = zscore_sound_cond(:,8);
zscore_interval_peakder = zscore_sound_cond(:,9);


%correlations per ITPC and z-scored edge measures (condition means)
fprintf('ITPC1 cond\nCorrelation with z-scored time of peak derivative\n');
[rho,pval]=corr(itc_corr1,zscore_time_peakder)
fprintf('Correlation with z-scored peak derivative\n');
[rho,pval]=corr(itc_corr1,zscore_peakder)
fprintf('Correlation with z-scored sharpness\n');
[rho,pval]=corr(itc_corr1,zscore_sharp_doe)
fprintf('Correlation with z-scored normalised sharpness\n');
[rho,pval]=corr(itc_corr1,zscore_sharp_norm)
fprintf('Correlation with z-scored gini index\n');
[rho,pval]=corr(itc_corr1,zscore_gini)
fprintf('Correlation with z-scored maximum amplitude\n');
[rho,pval]=corr(itc_corr1,zscore_max_amp)
fprintf('Correlation with z-scored time of maximum amplitude\n');
[rho,pval]=corr(itc_corr1,zscore_time_ma)
fprintf('Correlation with z-scored interval to maximum amplitude\n');
[rho,pval]=corr(itc_corr1,zscore_interval_ma)
fprintf('Correlation with z-scored interval to peak derivative\n');
[rho,pval]=corr(itc_corr1,zscore_interval_peakder)

fprintf('ITPC2 cond\nCorrelation with z-scored time of peak derivative\n');
[rho,pval]=corr(itc_corr2,zscore_time_peakder)
fprintf('Correlation with z-scored peak derivative\n');
[rho,pval]=corr(itc_corr2,zscore_peakder)
fprintf('Correlation with z-scored sharpness\n');
[rho,pval]=corr(itc_corr2,zscore_sharp_doe)
fprintf('Correlation with z-scored normalised sharpness\n');
[rho,pval]=corr(itc_corr2,zscore_sharp_norm)
fprintf('Correlation with z-scored gini index\n');
[rho,pval]=corr(itc_corr2,zscore_gini)
fprintf('Correlation with z-scored maximum amplitude\n');
[rho,pval]=corr(itc_corr2,zscore_max_amp)
fprintf('Correlation with z-scored time of maximum amplitude\n');
[rho,pval]=corr(itc_corr2,zscore_time_ma)
fprintf('Correlation with z-scored interval to maximum amplitude\n');
[rho,pval]=corr(itc_corr2,zscore_interval_ma)
fprintf('Correlation with z-scored interval to peak derivative\n');
[rho,pval]=corr(itc_corr2,zscore_interval_peakder)


%it doesn't matter if the edge measures are z-scored or not
%}

%correlations between sound properties

[rho_all,pval_all]=corr(sound_prop2_ordered); 


peakder = sound_prop2_ordered(:,1);
time_peakder = sound_prop2_ordered(:,2);
sharp_doe = sound_prop2_ordered(:,3);
sharp_norm = sound_prop2_ordered(:,4);
gini = sound_prop2_ordered(:,5);
max_amp = sound_prop2_ordered(:,6);
time_ma = sound_prop2_ordered(:,7);
interval_ma = sound_prop2_ordered(:,8);
interval_peakder = sound_prop2_ordered(:,9);
%interval_plateau = sound_prop2_ordered(:,10);


sounds={'Vow';'/b/';'/d/';'/g/';'/k/';'/p/';'/t/';'/m/';'/n/';'/s/';'/z/';'/l/';'/r/';'/f/';'/v/'};
edge_corr = [itc_corr1,time_peakder_cond];
[r_matrix,p_matrix]=corrcoef(edge_corr);
r=r_matrix(1,2);
p=p_matrix(1,2);

fig=figure('Renderer', 'painters', 'Position', [10 10 500 450]);

gsounds = {'Vowels';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Nasals';'Nasals';'Sibilants';'Sibilants';'Rhotics';'Rhotics';'Fricatives';'Fricatives'};
h1=gscatter(itc_corr1,time_peakder_cond,gsounds,'k','o',7.5);
hold on;
mdl = fitlm(itc_corr1,time_peakder_cond);
h2 = plot(mdl) ;
delete(h2(1));
delete(h2(3));
delete(h2(4));
set(h2(2),'LineStyle','--','Color',[0.5 0.5 0.5],'LineWidth',1);
text(itc_corr1,time_peakder_cond,sounds,'horizontal','right','vertical','bottom');
title('ITPC1 scores vs latency of peak derivative','FontSize',14,'FontWeight','bold');
xlabel('ITPC1','FontWeight','bold');
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
T = text(-0.015, 75, strcat(s1,s2)); 
set(T, 'fontsize', 13,'fontweight','bold');
ylim([0 110]);
box on;
