clearvars; clc;

load('Itc_for_pca_oana.mat');
load('Zscores_sound_prop_pca_may21.mat');

%pca on ITPC
Itc_pca=reshape(Itc_for_pca,1125,4);

[Coeff1, Score1, Latent1, TSquared1, Explained1]=pca(Itc_pca);

score_stream = reshape(Score1,45,25,4);

n=3;
score_cond=arrayfun(@(i) mean(score_stream(i:i+n-1,:,:)),1:n:size(score_stream,1),'UniformOutput',false)';
score_cond=cell2mat(score_cond);

itc_score_pc1 = score_stream(:,:,1);
itc_score_pc2 = score_stream(:,:,2);
itc_score_pc3 = score_stream(:,:,3);
itc_score_pc4 = score_stream(:,:,4);

cond_itc_score_pc1 = score_cond(:,:,1);
cond_itc_score_pc2 = score_cond(:,:,2);
cond_itc_score_pc3 = score_cond(:,:,3);
cond_itc_score_pc4 = score_cond(:,:,4);


sditc1=std(itc_score_pc1,[],2);
sem1=sditc1./sqrt(size(itc_score_pc1,2));

sditc2=std(itc_score_pc2,[],2);
sem2=sditc2./sqrt(size(itc_score_pc2,2));

sditc1_mean=std(cond_itc_score_pc1,[],2);
sem1_mean=sditc1_mean./sqrt(size(cond_itc_score_pc1,2));

sditc2_mean=std(cond_itc_score_pc2,[],2);
sem2_mean=sditc2_mean./sqrt(size(cond_itc_score_pc2,2));

%pca on edge measures
zscores_for_pca2 = zscores_for_pca(:,[2 3 5 7 10]);

[Coeff2, Score2, Latent2, TSquared2, Explained2]=pca(zscores_for_pca2);

score_pc1=Score2(:,1);
score_pc2=Score2(:,2);

score_pc1=reshape(score_pc1,5,15);
score_pc2=reshape(score_pc2,5,15);

meanscore_pc1=mean(score_pc1);
meanscore_pc2=mean(score_pc2);

std_pc1=std(score_pc1,[],1);
std_pc2=std(score_pc2,[],1);

sem_pc1=std_pc1./sqrt(size(score_pc1,1));
sem_pc2=std_pc2./sqrt(size(score_pc2,1));

%gsounds={'Vowels';'Vowels';'Vowels';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Nasals';'Nasals';'Nasals';'Nasals';'Nasals';'Nasals';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Fricatives';'Fricatives';'Fricatives';'Fricatives';'Fricatives';'Fricatives'};

gsounds2 = {'Vowels';'Voiced Stops';'Voiced Stops';'Fricatives';'Voiced Stops';'Unvoiced Stops';'Rhotics';'Nasals';'Nasals';'Unvoiced Stops';'Rhotics';'Sibilants';'Unvoiced Stops';'Fricatives';'Sibilants'};

sounds={'Vow';'/b/';'/d/';'/g/';'/k/';'/p/';'/t/';'/m/';'/n/';'/s/';'/z/';'/l/';'/r/';'/f/';'/v/'};
%sounds3={'Vow';'/b/';'/d/';'/f/';'/g/';'/k/';'/l/';'/m/';'/n/';'/p/';'/r/';'/s/';'/t/';'/v/';'/z/'};

%graph itpc1 and itpc 2 versus graph edge measures pc1 and pc2

fig1=figure('Renderer', 'painters', 'Position', [10 10 500 1000]);

subplot(2,1,1);
hold on;
e1=errorbar(mean(cond_itc_score_pc1(1,:),2),mean(cond_itc_score_pc2(1,:),2),sem2_mean(1),sem2_mean(1),sem1_mean(1),sem1_mean(1),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.02 0.8 0.18],'MarkerFaceColor',[0.02 0.8 0.18]);
hold on;
e2=errorbar(mean(cond_itc_score_pc1(2:4,:),2),mean(cond_itc_score_pc2(2:4,:),2),sem2_mean(2:4),sem2_mean(2:4),sem1_mean(2:4),sem1_mean(2:4),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);
hold on;
e3=errorbar(mean(cond_itc_score_pc1(5:7,:),2),mean(cond_itc_score_pc2(5:7,:),2),sem2_mean(5:7),sem2_mean(5:7),sem1_mean(5:7),sem1_mean(5:7),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.93 0.69 0.13],'MarkerFaceColor',[0.93 0.69 0.13]);
hold on;
e4=errorbar(mean(cond_itc_score_pc1(8:9,:),2),mean(cond_itc_score_pc2(8:9,:),2),sem2_mean(8:9),sem2_mean(8:9),sem1_mean(8:9),sem1_mean(8:9),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.2857 0 1],'MarkerFaceColor',[0.2857 0 1]);
hold on;
e5=errorbar(mean(cond_itc_score_pc1(10:11,:),2),mean(cond_itc_score_pc2(10:11,:),2),sem2_mean(10:11),sem2_mean(10:11),sem1_mean(10:11),sem1_mean(10:11),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[1 0 1],'MarkerFaceColor',[1 0 1]);
hold on;
e6=errorbar(mean(cond_itc_score_pc1(12:13,:),2),mean(cond_itc_score_pc2(12:13,:),2),sem2_mean(12:13),sem2_mean(12:13),sem1_mean(12:13),sem1_mean(12:13),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.13 0.67 0.9],'MarkerFaceColor',[0.13 0.67 0.9]);
hold on;
e7=errorbar(mean(cond_itc_score_pc1(14:15,:),2),mean(cond_itc_score_pc2(14:15,:),2),sem2_mean(14:15),sem2_mean(14:15),sem1_mean(14:15),sem1_mean(14:15),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.57 0.04 0.75],'MarkerFaceColor',[0.57 0.04 0.75]);
text(mean(cond_itc_score_pc1,2),mean(cond_itc_score_pc2,2),sounds,'horizontal','right','vertical','bottom');
title('ITPC: PC1 vs PC2 scores by condition','FontSize',14,'FontWeight','bold');
xlabel('ITPC1','FontWeight','bold');
ylabel('ITPC2','FontWeight','bold');
%ax = gca;
%ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
e5.Color=[1 0 1];
e1.Color=[0.02 0.8 0.18];
%legend('Vowels','Voiced Stops','Unvoiced Stops','Nasals','Sibilants','Liquids','Fricatives','Location','Southeast');%'Position',[0.2 0.513 0.05 0.03]
set(gca,'LineWidth',1);
box on

subplot(2,1,2);
hold on;
e8=errorbar(meanscore_pc1(1),meanscore_pc2(1),sem_pc2(1),sem_pc2(1),sem_pc1(1),sem_pc1(1),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.02 0.8 0.18],'MarkerFaceColor',[0.02 0.8 0.18]);
hold on;
e9=errorbar(meanscore_pc1(2:4),meanscore_pc2(2:4),sem_pc2(2:4),sem_pc2(2:4),sem_pc1(2:4),sem_pc1(2:4),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);
hold on;
e10=errorbar(meanscore_pc1(5:7),meanscore_pc2(5:7),sem_pc2(5:7),sem_pc2(5:7),sem_pc1(5:7),sem_pc1(5:7),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.93 0.69 0.13],'MarkerFaceColor',[0.93 0.69 0.13]);
hold on;
e11=errorbar(meanscore_pc1(8:9),meanscore_pc2(8:9),sem_pc2(8:9),sem_pc2(8:9),sem_pc1(8:9),sem_pc1(8:9),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.2857 0 1],'MarkerFaceColor',[0.2857 0 1]);
hold on;
e12=errorbar(meanscore_pc1(10:11),meanscore_pc2(10:11),sem_pc2(10:11),sem_pc2(10:11),sem_pc1(10:11),sem_pc1(10:11),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[1 0 1],'MarkerFaceColor',[1 0 1]);
hold on;
e13=errorbar(meanscore_pc1(12:13),meanscore_pc2(12:13),sem_pc2(12:13),sem_pc2(12:13),sem_pc1(12:13),sem_pc1(12:13),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.13 0.67 0.9],'MarkerFaceColor',[0.13 0.67 0.9]);
hold on;
e14=errorbar(meanscore_pc1(14:15),meanscore_pc2(14:15),sem_pc2(14:15),sem_pc2(14:15),sem_pc1(14:15),sem_pc1(14:15),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.57 0.04 0.75],'MarkerFaceColor',[0.57 0.04 0.75]);
%h2=gscatter(meanscore_pc1,meanscore_pc2,gsounds2);
text(meanscore_pc1,meanscore_pc2,sounds,'horizontal','right','vertical','bottom');
title('Edge markers: PC1 vs PC2 scores by condition','FontSize',14,'FontWeight','bold');
xlabel('PC1','FontWeight','bold');
ylabel('PC2','FontWeight','bold');
axis([-3 4 -3 2]);
%ax = gca;
%ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
%legend('Position',[0.21 0.513 0.05 0.03]);
%vowels=h2(1);
%vstops=h2(2);
%ustops=h2(4);
%fricatives=h2(3);
%rhotics=h2(5);
%nasals=h2(6);
%sibilants=h2(7);
%vowels.Color=[0.02 0.8 0.18];
%vstops.Color=[1 0.5 0];
%ustops.Color=[0.93 0.69 0.13];
%fricatives.Color=[0.57 0.04 0.75];
%rhotics.Color=[0.13 0.67 0.9];
%nasals.Color=[0.2857 0 1];
%sibilants.Color=[1 0 1];
e12.Color=[1 0 1];
e8.Color=[0.02 0.8 0.18];
set(gca,'LineWidth',1);
legend('Vowels','Voiced Stops','Unvoiced Stops','Nasals','Sibilants','Liquids','Fricatives','Location','Southeast');%'Position',[0.2 0.513 0.05 0.03]
box on

meanitc_pca1 = mean(cond_itc_score_pc1,2)';
meanitc_pca2 = mean(cond_itc_score_pc2,2)';
meanitc_pca3 = mean(cond_itc_score_pc3,2)';
meanitc_pca4 = mean(cond_itc_score_pc4,2)';


edge_corr = [meanitc_pca1;meanscore_pc1]';
[r_matrix,p_matrix]=corrcoef(edge_corr);
r=r_matrix(1,2);
p=p_matrix(1,2);
fig=figure('Renderer', 'painters', 'Position', [10 10 500 450]);

gsounds = {'Vowels';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Nasals';'Nasals';'Sibilants';'Sibilants';'Rhotics';'Rhotics';'Fricatives';'Fricatives'};


h1=gscatter(meanitc_pca1,meanscore_pc1,gsounds,'k','o',7.5);
hold on;
mdl = fitlm(meanitc_pca1,meanscore_pc1);
h2 = plot(mdl) ;
delete(h2(1));
delete(h2(3));
delete(h2(4));
set(h2(2),'LineStyle','--','Color',[0.5 0.5 0.5],'LineWidth',1);
text(meanitc_pca1,meanscore_pc1,sounds,'horizontal','right','vertical','bottom');
title('ITPC1 scores vs PC1 scores of edge markers','FontSize',14,'FontWeight','bold');
xlabel('ITPC1','FontWeight','bold');
ylabel('Edge marker PC1','FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
axis([-0.051 0.051 -3.1 3.1]);
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
s1=['r = ',num2str(round(r,3))];
s2='***';
T = text(-0.015, 1.5, strcat(s1,s2)); 
set(T, 'fontsize', 13,'fontweight','bold');
box on;


edge_corr2 = [meanitc_pca3;meanscore_pc2]';
[r_matrix2,p_matrix2]=corrcoef(edge_corr2);
r2=r_matrix2(1,2);
p2=p_matrix2(1,2);

%{
%k means clustering for edge measures
edge_clusters = [meanscore_pc1;meanscore_pc2];
edge_clusters = edge_clusters';

opts = statset('Display','final');
[idx,C] = kmeans(edge_clusters,4,'Distance','cityblock',...
    'Replicates',100,'Options',opts);

figure
gscatter(edge_clusters(:,1),edge_clusters(:,2),idx,'brygm')
hold on
plot(C(:,1),C(:,2),'kx')
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster Centroid');
%}
