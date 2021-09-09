clearvars;clc;
load('Itc_for_stats.mat');
load('peakder_prop.mat');
load('narrowenv_prop.mat');
load('itc_pca1_for_stats.mat');
load('syllable_names.mat');

meanitc4=mean(Itc4)';
meanitc8=mean(Itc8)';
meanitc12=mean(Itc12)';
meanitc16=mean(Itc16)';

meanitc=[meanitc4,meanitc8,meanitc12,meanitc16];

%pca

[Coeff, Score, Latent, TSquared, Explained]=pca(meanitc);

itc_pca_comp1=Coeff(1,1)*Itc4 + Coeff(2,1)*Itc8 + Coeff(3,1)*Itc12 + Coeff(4,1)*Itc16;
itc_pca_comp2=Coeff(1,2)*Itc4 + Coeff(2,2)*Itc8 + Coeff(3,2)*Itc12 + Coeff(4,2)*Itc16;

n=3;
mean_itc_pca1=arrayfun(@(i) mean(itc_pca_comp1(i:i+n-1,:)),1:n:size(Itc4,1),'UniformOutput',false)';
mean_itc_pca1=cell2mat(mean_itc_pca1);

mean_itc_pca2=arrayfun(@(i) mean(itc_pca_comp2(i:i+n-1,:)),1:n:size(Itc4,1),'UniformOutput',false)';
mean_itc_pca2=cell2mat(mean_itc_pca2);

sditc1_mean=std(mean_itc_pca1,[],2);
sem1_mean=sditc1_mean./sqrt(size(mean_itc_pca1,2));

sditc2_mean=std(mean_itc_pca2,[],2);
sem2_mean=sditc2_mean./sqrt(size(mean_itc_pca2,2));

sound_prop=[peakDer,time_peakder,pos_der,pos_der2,gini,time_ms];
[rho1,pval1]=corr([sound_prop,amp]);
%[Coeff, Score, Latent, TSquared, Explained]=pca(sound_prop);

%z-scoring
meanpeakder=mean(peakDer);
meantpeakder=mean(time_peakder);
meanposder=mean(pos_der);
meanposder2=mean(pos_der2);
meangini=mean(gini);
%meanamp=mean(amp);
meantimeamp=mean(time_ms);

stdpeakder=std(peakDer);
stdtpeakder=std(time_peakder);
stdposder=std(pos_der);
stdposder2=std(pos_der2);
stdgini=std(gini);
%stdamp=std(amp);
stdtimeamp=std(time_ms);

zpeakder=(peakDer-meanpeakder)/stdpeakder;
ztpeakder=(time_peakder-meantpeakder)/stdtpeakder;
zposder=(pos_der-meanposder)/stdposder;
zposder2=(pos_der2-meanposder2)/stdposder2;
zgini=(gini-meangini)/stdgini;
%zamp=(amp-meanamp)/stdamp;
ztimeamp=(time_ms-meantimeamp)/stdtimeamp;

sound_prop_z=[zpeakder,ztpeakder,zposder,zposder2,zgini,ztimeamp];

%[rho2,pval2]=corr(sound_prop_z);

%pca
[Coeff, Score, Latent, TSquared, Explained]=pca(sound_prop_z);

score_pc1=Score(:,1);
score_pc2=Score(:,2);
score_pc3=Score(:,3);
score_pc4=Score(:,4);

vowels_pc1=score_pc1([1,12,13,44,45]);
score_pc1([1,12,13,44,45])=[];
score_pc1=[vowels_pc1;score_pc1];

vowels_pc2=score_pc2([1,12,13,44,45]);
score_pc2([1,12,13,44,45])=[];
score_pc2=[vowels_pc2;score_pc2];

vowels_pc3=score_pc3([1,12,13,44,45]);
score_pc3([1,12,13,44,45])=[];
score_pc3=[vowels_pc3;score_pc3];

vowels_pc4=score_pc4([1,12,13,44,45]);
score_pc4([1,12,13,44,45])=[];
score_pc4=[vowels_pc4;score_pc4];

score_pc1=reshape(score_pc1,5,15);
score_pc2=reshape(score_pc2,5,15);
score_pc3=reshape(score_pc3,5,15);
score_pc4=reshape(score_pc4,5,15);

meanscore_pc1=mean(score_pc1);
meanscore_pc2=mean(score_pc2);
meanscore_pc3=mean(score_pc3);
meanscore_pc4=mean(score_pc4);

std_pc1=std(score_pc1,[],1);
std_pc2=std(score_pc1,[],1);

sem_pc1=std_pc1./sqrt(size(score_pc1,1));
sem_pc2=std_pc2./sqrt(size(score_pc2,1));


gsounds={'Vowels';'Vowels';'Vowels';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Nasals';'Nasals';'Nasals';'Nasals';'Nasals';'Nasals';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Fricatives';'Fricatives';'Fricatives';'Fricatives';'Fricatives';'Fricatives'};

gsounds2 = {'Vowels';'Voiced Stops';'Voiced Stops';'Fricatives';'Voiced Stops';'Unvoiced Stops';'Rhotics';'Nasals';'Nasals';'Unvoiced Stops';'Rhotics';'Sibilants';'Unvoiced Stops';'Fricatives';'Sibilants'};

sounds2={'Vow';'/b/';'/d/';'/g/';'/k/';'/p/';'/t/';'/m/';'/n/';'/s/';'/z/';'/l/';'/r/';'/f/';'/v/'};
sounds3={'Vow';'/b/';'/d/';'/f/';'/g/';'/k/';'/l/';'/m/';'/n/';'/p/';'/r/';'/s/';'/t/';'/v/';'/z/'};

fig=figure('Renderer', 'painters', 'Position', [10 10 500 1000]);

subplot(2,1,1);
hold on;
e1=errorbar(mean(mean_itc_pca1(1,:),2),mean(mean_itc_pca2(1,:),2),sem2_mean(1),sem2_mean(1),sem1_mean(1),sem1_mean(1),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.02 0.8 0.18],'MarkerFaceColor',[0.02 0.8 0.18]);
hold on;
e2=errorbar(mean(mean_itc_pca1(2:4,:),2),mean(mean_itc_pca2(2:4,:),2),sem2_mean(2:4),sem2_mean(2:4),sem1_mean(2:4),sem1_mean(2:4),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);
hold on;
e3=errorbar(mean(mean_itc_pca1(5:7,:),2),mean(mean_itc_pca2(5:7,:),2),sem2_mean(5:7),sem2_mean(5:7),sem1_mean(5:7),sem1_mean(5:7),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.93 0.69 0.13],'MarkerFaceColor',[0.93 0.69 0.13]);
hold on;
e4=errorbar(mean(mean_itc_pca1(8:9,:),2),mean(mean_itc_pca2(8:9,:),2),sem2_mean(8:9),sem2_mean(8:9),sem1_mean(8:9),sem1_mean(8:9),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.2857 0 1],'MarkerFaceColor',[0.2857 0 1]);
hold on;
e5=errorbar(mean(mean_itc_pca1(10:11,:),2),mean(mean_itc_pca2(10:11,:),2),sem2_mean(10:11),sem2_mean(10:11),sem1_mean(10:11),sem1_mean(10:11),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[1 0 1],'MarkerFaceColor',[1 0 1]);
hold on;
e6=errorbar(mean(mean_itc_pca1(12:13,:),2),mean(mean_itc_pca2(12:13,:),2),sem2_mean(12:13),sem2_mean(12:13),sem1_mean(12:13),sem1_mean(12:13),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.13 0.67 0.9],'MarkerFaceColor',[0.13 0.67 0.9]);
hold on;
e7=errorbar(mean(mean_itc_pca1(14:15,:),2),mean(mean_itc_pca2(14:15,:),2),sem2_mean(14:15),sem2_mean(14:15),sem1_mean(14:15),sem1_mean(14:15),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.57 0.04 0.75],'MarkerFaceColor',[0.57 0.04 0.75]);
text(mean(mean_itc_pca1,2),mean(mean_itc_pca2,2),sounds2,'horizontal','right','vertical','bottom');
title('ITC: PC1 vs PC2 scores by Condition','FontSize',14,'FontWeight','bold');
xlabel('ITC PC1','FontWeight','bold');
ylabel('ITC PC2','FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
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
e9=errorbar(meanscore_pc1([2,3,5]),meanscore_pc2([2,3,5]),sem_pc2([2,3,5]),sem_pc2([2,3,5]),sem_pc1([2,3,5]),sem_pc1([2,3,5]),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);
hold on;
e10=errorbar(meanscore_pc1([6,10,13]),meanscore_pc2([6,10,13]),sem_pc2([6,10,13]),sem_pc2([6,10,13]),sem_pc1([6,10,13]),sem_pc1([6,10,13]),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.93 0.69 0.13],'MarkerFaceColor',[0.93 0.69 0.13]);
hold on;
e11=errorbar(meanscore_pc1(8:9),meanscore_pc2(8:9),sem_pc2(8:9),sem_pc2(8:9),sem_pc1(8:9),sem_pc1(8:9),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.2857 0 1],'MarkerFaceColor',[0.2857 0 1]);
hold on;
e12=errorbar(meanscore_pc1([12,15]),meanscore_pc2([12,15]),sem_pc2([12,15]),sem_pc2([12,15]),sem_pc1([12,15]),sem_pc1([12,15]),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[1 0 1],'MarkerFaceColor',[1 0 1]);
hold on;
e13=errorbar(meanscore_pc1([7,11]),meanscore_pc2([7,11]),sem_pc2([7,11]),sem_pc2([7,11]),sem_pc1([7,11]),sem_pc1([7,11]),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.13 0.67 0.9],'MarkerFaceColor',[0.13 0.67 0.9]);
hold on;
e14=errorbar(meanscore_pc1([4,14]),meanscore_pc2([4,14]),sem_pc2([4,14]),sem_pc2([4,14]),sem_pc1([4,14]),sem_pc1([4,14]),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.57 0.04 0.75],'MarkerFaceColor',[0.57 0.04 0.75]);
%h2=gscatter(meanscore_pc1,meanscore_pc2,gsounds2);
text(meanscore_pc1,meanscore_pc2,sounds3,'horizontal','right','vertical','bottom');
title('Edger markers: PC1 vs PC2 scores by Condition','FontSize',14,'FontWeight','bold');
xlabel('PC1','FontWeight','bold');
ylabel('PC2','FontWeight','bold');
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

meanitc_pca1 = mean(mean_itc_pca1,2)';
meanscore_pc1 = meanscore_pc1([1 2 3 5 6 10 13 8 9 12 15 7 11 4 14]);

meanitc_pca2 = mean(mean_itc_pca2,2)';
meanscore_pc2 = meanscore_pc2([1 2 3 5 6 10 13 8 9 12 15 7 11 4 14]);


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
text(meanitc_pca1,meanscore_pc1,sounds2,'horizontal','right','vertical','bottom');
title('Compound ITC1 of EEG vs PC1 scores of edge markers','FontSize',14,'FontWeight','bold');
xlabel('ITC PC1','FontWeight','bold');
ylabel('Edge marker PC1','FontWeight','bold');
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
legend('Vowels','Voiced Stops','Unvoiced Stops','Nasals','Sibilants','Rhotics','Fricatives','Location','Southeast');%'Position',[0.2 0.513 0.05 0.03]
legend('Position',[0.75 0.78 0.05 0.03]);
s1=['r = ',num2str(round(r,2))];
s2='***';
T = text(0.225, 1.9, strcat(s1,s2)); 
set(T, 'fontsize', 13,'fontweight','bold');
box on;


edge_corr2 = [meanitc_pca1;meanscore_pc2]';
[r_matrix2,p_matrix2]=corrcoef(edge_corr2);
r2=r_matrix2(1,2)
p2=p_matrix2(1,2)

edge_corr3 = [meanitc_pca2;meanscore_pc1]';
[r_matrix3,p_matrix3]=corrcoef(edge_corr3);
r3=r_matrix3(1,2)
p3=p_matrix3(1,2)

edge_corr4 = [meanitc_pca2;meanscore_pc2]';
[r_matrix4,p_matrix4]=corrcoef(edge_corr4);
r4=r_matrix4(1,2)
p4=p_matrix4(1,2)
