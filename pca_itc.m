%{

PCA is performed for the ITC values at 4, 8, 12 and 16 Hz, averaged over
channels and conditions. The scores of PC1 are plotted against the scores of PC2.

(c) Oana Cucu 2019. oana.cucu@bristol.ac.uk

%}

clearvars;
load('Itc_for_stats.mat');

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

%save('itc_pca1_for_stats.mat','itc_pca_comp1','mean_itc_pca1');
%save('itc_pca2_for_stats.mat','itc_pca_comp2','mean_itc_pca2');

sditc1=std(itc_pca_comp1,[],2);
sem1=sditc1./sqrt(size(itc_pca_comp1,2));

sditc2=std(itc_pca_comp2,[],2);
sem2=sditc2./sqrt(size(itc_pca_comp2,2));

sditc1_mean=std(mean_itc_pca1,[],2);
sem1_mean=sditc1_mean./sqrt(size(mean_itc_pca1,2));

sditc2_mean=std(mean_itc_pca2,[],2);
sem2_mean=sditc2_mean./sqrt(size(mean_itc_pca2,2));

sounds2={'Vowels';'/b/';'/d/';'/g/';'/k/';'/p/';'/t/';'/m/';'/n/';'/s/';'/z/';'/l/';'/r/';'/f/';'/v/'};
sounds={'Vowels';'Vowels';'Vowels';'/b/';'/b/';'/b/';'/d/';'/d/';'/d/';'/g/';'/g/';'/g/';'/k/';'/k/';'/k/';'/p/';'/p/';'/p/';'/t/';'/t/';'/t/';'/m/';'/m/';'/m/';'/n/';'/n/';'/n/';'/s/';'/s/';'/s/';'/z/';'/z/';'/z/';'/l/';'/l/';'/l/';'/r/';'/r/';'/r/';'/f/';'/f/';'/f/';'/v/';'/v/';'/v/'};

%{
figure('Renderer', 'painters', 'Position', [10 10 450 900]);

subplot(2,1,1);
errorbar(mean(mean_itc_pca1,2),mean(mean_itc_pca2,2),sem2_mean,sem2_mean,sem1_mean,sem1_mean,'o', 'MarkerSize',5,...
    'MarkerEdgeColor','blue','MarkerFaceColor','red');
text(mean(mean_itc_pca1,2),mean(mean_itc_pca2,2),sounds2,'horizontal','right','vertical','bottom');
title('Scatterplot of PC1 and PC2 Component Scores, per condition','FontSize',14,'FontWeight','bold');
set(gca,'Units','normalized')
titleHandle = get( gca ,'Title' );
pos1  = get( titleHandle , 'position' );
pos1 = pos1 + [0 0.005 0];
set( titleHandle , 'position' , pos1 );
xlabel('PC1 Scores','FontWeight','bold');
ylabel('PC2 Scores','FontWeight','bold');

subplot(2,1,2);
scatter(mean(itc_pca_comp1,2),mean(itc_pca_comp2,2),'o',...
    'MarkerEdgeColor','blue','MarkerFaceColor','red');
%errorbar(mean(itc_pca_comp1,2),mean(itc_pca_comp2,2),sem2,sem2,sem1,sem1,'o', 'MarkerSize',5,...
%    'MarkerEdgeColor','blue','MarkerFaceColor','red');
text(mean(itc_pca_comp1,2),mean(itc_pca_comp2,2),sounds,'horizontal','right','vertical','bottom');
title('Scatterplot of PC1 and PC2 Component Scores, per stream','FontSize',14,'FontWeight','bold');
set(gca,'Units','normalized')
titleHandle = get( gca ,'Title' );
pos1  = get( titleHandle , 'position' );
pos1 = pos1 + [0 0.005 0];
set( titleHandle , 'position' , pos1 );
xlabel('PC1 Scores','FontWeight','bold');
ylabel('PC2 Scores','FontWeight','bold');
%}

gsounds={'Vowels';'Vowels';'Vowels';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Nasals';'Nasals';'Nasals';'Nasals';'Nasals';'Nasals';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Fricatives';'Fricatives';'Fricatives';'Fricatives';'Fricatives';'Fricatives'};

%plots per stream and condition
fig=figure('Renderer', 'painters', 'Position', [10 10 500 1000]);
subplot(2,1,1);
h1=gscatter(mean(itc_pca_comp1,2),mean(itc_pca_comp2,2),gsounds);
text(mean(itc_pca_comp1,2),mean(itc_pca_comp2,2),sounds,'horizontal','right','vertical','bottom');
title('ITC: PC1 vs PC2 scores by Stream','FontSize',14,'FontWeight','bold');
xlabel('ITC PC1 Scores','FontWeight','bold');
ylabel('ITC PC2 Scores','FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
vowels=h1(1);
vstops=h1(2);
ustops=h1(3);
fricatives=h1(7);
rhotics=h1(6);
nasals=h1(4);
sibilants=h1(5);
vowels.Color=[0.02 0.8 0.18];
vstops.Color=[1 0.5 0];
ustops.Color=[0.93 0.69 0.13];
fricatives.Color=[0.57 0.04 0.75];
rhotics.Color=[0.13 0.67 0.9];
nasals.Color=[0.2857 0 1];
sibilants.Color=[1 0 1];
hLeg=findobj(fig,'type','legend');
set(hLeg,'visible','off');
set(gca,'LineWidth',1);

subplot(2,1,2);
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
legend('Vowels','Voiced Stops','Unvoiced Stops','Nasals','Sibilants','Liquids','Fricatives','Location','Southeast');%'Position',[0.2 0.513 0.05 0.03]
set(gca,'LineWidth',1);
box on

%{
gsounds2 = {'Vowels';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Nasals';'Nasals';'Sibilants';'Sibilants';'Rhotics';'Rhotics';'Fricatives';'Fricatives'};

subplot(2,1,2);
h2=gscatter(mean(mean_itc_pca1,2),mean(mean_itc_pca2,2),gsounds2);
text(mean(mean_itc_pca1,2),mean(mean_itc_pca2,2),sounds2,'horizontal','right','vertical','bottom');
title('PC1 vs PC2 scores by condition','FontSize',14,'FontWeight','bold');
xlabel('PC1','FontWeight','bold');
ylabel('PC2','FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
legend('Position',[0.21 0.513 0.05 0.03]);
vowels=h2(1);
vstops=h2(2);
ustops=h2(4);
fricatives=h2(3);
rhotics=h2(5);
nasals=h2(6);
sibilants=h2(7);
vowels.Color=[0.02 0.8 0.18];
vstops.Color=[1 0.5 0];
ustops.Color=[0.93 0.69 0.13];
fricatives.Color=[0.57 0.04 0.75];
rhotics.Color=[0.13 0.67 0.9];
nasals.Color=[0.2857 0 1];
sibilants.Color=[1 0 1];
%}