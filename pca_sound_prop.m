%{
Edge markers of syllables in each condition are z-scored, after which 
PCA is performed. The scores of PC1 are plotted against the scores of PC2.

(c) Oana Cucu 2019. oana.cucu@bristol.ac.uk

%}


clearvars;
load('peakder_prop.mat');
load('narrowenv_prop.mat');
load('itc_pca1_for_stats.mat');
load('syllable_names.mat');

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

%% graphs (edge markers are plotted individually for each syllable, then average over condition)
sounds={'/a/';'/e/';'/i/';'/o/';'/u/';'/ba/';'/be/';'/bi/';'/bo/';'/bu/';'/da/';'/de/';'/di/';'/do/';'/du/';'/fa/';'/fe/';'/fi/';'/fo/';'/fu/';'/ga/';'/ge/';'/gi/';'/go/';'/gu/';'/ka/';'/ke/';'/ki/';'/ko/';'/ku/';'/la/';'/le/';'/li/';'/lo/';'/lu/';'/ma/';'/me/';'/mi/';'/mo/';'/mu/';'/na/';'/ne/';'/ni/';'/no/';'/nu/';'/pa/';'/pe/';'/pi/';'/po/';'/pu/';'/ra/';'/re/';'/ri/';'/ro/';'/ru/';'/sa/';'/se/';'/si/';'/so/';'/su/';'/ta/';'/te/';'/ti/';'/to/';'/tu/';'/va/';'/ve/';'/vi/';'/vo/';'/vu/';'/za/';'/ze/';'/zi/';'/zo/';'/zu/'};
gsounds={'Vowels';'Vowels';'Vowels';'Vowels';'Vowels';'Voiced Stops';'Voiced Stops';
 'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';
 'Voiced Stops';'Voiced Stops';'Voiced Stops';'Fricatives';'Fricatives';'Fricatives';
 'Fricatives';'Fricatives';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';
 'Voiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';
 'Unvoiced Stops';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Nasals';'Nasals';
 'Nasals';'Nasals';'Nasals';'Nasals';'Nasals';'Nasals';'Nasals';'Nasals';'Unvoiced Stops';
 'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Rhotics';'Rhotics';
 'Rhotics';'Rhotics';'Rhotics';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Sibilants';
 'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';
 'Fricatives';'Fricatives';'Fricatives';'Fricatives';'Fricatives';'Sibilants';'Sibilants';
 'Sibilants';'Sibilants';'Sibilants';};

fig=figure('Renderer', 'painters', 'Position', [10 10 500 1000]);
subplot(2,1,1);
h1=gscatter(score_pc1,score_pc2,gsounds);
text(score_pc1,score_pc2,sounds,'horizontal','right','vertical','bottom');
title('Edger markers: PC1 vs PC2 scores by syllable','FontSize',14,'FontWeight','bold');
xlabel('PC1','FontWeight','bold');
ylabel('PC2','FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
vowels=h1(1);
vstops=h1(2);
ustops=h1(4);
fricatives=h1(3);
rhotics=h1(5);
nasals=h1(6);
sibilants=h1(7);
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

score_pc1=reshape(score_pc1,5,15);
score_pc2=reshape(score_pc2,5,15);
score_pc3=reshape(score_pc3,5,15);
score_pc4=reshape(score_pc4,5,15);

score_pc1=mean(score_pc1);
score_pc2=mean(score_pc2);
score_pc3=mean(score_pc3);
score_pc4=mean(score_pc4);

gsounds2 = {'Vowels';'Voiced Stops';'Voiced Stops';'Fricatives';'Voiced Stops';'Unvoiced Stops';'Rhotics';'Nasals';'Nasals';'Unvoiced Stops';'Rhotics';'Sibilants';'Unvoiced Stops';'Fricatives';'Sibilants'};

sounds2={'Vowels';'/b/';'/d/';'/f/';'/g/';'/k/';'/l/';'/m/';'/n/';'/p/';'/r/';'/s/';'/t/';'/v/';'/z/'};

subplot(2,1,2);
h2=gscatter(score_pc1,score_pc2,gsounds2);
text(score_pc1,score_pc2,sounds2,'horizontal','right','vertical','bottom');
title('Edger markers: PC1 vs PC2 scores by condition','FontSize',14,'FontWeight','bold');
xlabel('PC1','FontWeight','bold');
ylabel('PC2','FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
%legend('Position',[0.21 0.513 0.05 0.03]);
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
set(gca,'LineWidth',1);
legend('Vowels','Voiced Stops','Fricatives','Unvoiced Stops','Rhotics','Nasals','Sibilants','Location','Southeast');%'Position',[0.2 0.513 0.05 0.03]
%hLeg=findobj(fig,'type','legend');
%set(hLeg,'visible','off');
%{
hold on;
scatter(score_pc1(1),score_pc2(1),'r', 'filled');
hold on;
scatter(score_pc1([2,3,5]),score_pc2([2,3,5]),'g', 'filled');
hold on;
scatter(score_pc1([6,10,13]),score_pc2([6,10,13]),'k', 'filled');
hold on;
scatter(score_pc1([8,9]),score_pc2([8,9]),'b', 'filled');
hold on;
scatter(score_pc1([12,15]),score_pc2([12,15]),'m', 'filled');
hold on;
scatter(score_pc1([7,11]),score_pc2([7,11]),'y','filled');
hold on;
scatter(score_pc1([4,14]),score_pc2([4,14]),'c', 'filled');
text(score_pc1,score_pc2,sounds2,'horizontal','right','vertical','bottom');
title('Scatterplot of PC1 and PC2 scores of condition means','FontSize',14,'FontWeight','bold');
xlabel('PC1','FontWeight','bold');
ylabel('PC2','FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
legend('Vowels','Voiced Stops','Unvoiced Stops','Nasals','Sibilants','Rhotics','Fricatives','Position',[0.2 0.513 0.05 0.03]);
%}
%save('scores_pca.mat','score_pc1','score_pc2','score_pc3','score_pc4');

%%
%{
itc_corr=mean(mean_itc_pca1,2);

itc_corr=itc_corr([1,2,3,14,4,5,12,8,9,6,13,10,7,15,11]);


fprintf('Correlation with scores of PC1 \n');
[rho,pval]=corr(itc_corr,score_pc1')
fprintf('Correlation with scores of PC2 \n');
[rho,pval]=corr(itc_corr,score_pc2')
fprintf('Correlation with scores of PC3 \n');
[rho,pval]=corr(itc_corr,score_pc3')
fprintf('Correlation with scores of PC4 \n');
[rho,pval]=corr(itc_corr,score_pc4')

figure('Renderer', 'painters', 'Position', [10 10 500 1000]);
subplot(2,1,1);
h3=gscatter(itc_corr,score_pc1,gsounds2);
text(itc_corr,score_pc1,sounds2,'horizontal','right','vertical','bottom');
coeffs=polyfit(itc_corr,score_pc1',1);
fittedx=linspace(min(itc_corr),max(itc_corr),200);
fittedy=polyval(coeffs,fittedx);
hold on;
plot(fittedx,fittedy,'--','color',[0.5 0.5 0.5],'LineWidth',1);
title({'ITC vs PC1 scores';'(Condition Average)'},'FontSize',14,'FontWeight','bold');
xlabel('ITC','FontSize',13,'FontWeight','bold');
ylabel('PC1 scores','FontSize',13,'FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
%legend('Position',[0.93 0.718 0.05 0.03]);
vowels=h3(1);
vstops=h3(2);
ustops=h3(4);
fricatives=h3(3);
rhotics=h3(5);
nasals=h3(6);
sibilants=h3(7);
vowels.Color=[0.02 0.8 0.18];
vstops.Color=[1 0.5 0];
ustops.Color=[0.93 0.69 0.13];
fricatives.Color=[0.57 0.04 0.75];
rhotics.Color=[0.13 0.67 0.9];
nasals.Color=[0.2857 0 1];
sibilants.Color=[1 0 1];
%hLeg=findobj(fig,'type','legend');
%set(hLeg,'visible','off');
set(gca,'LineWidth',1);



subplot(2,1,2);
h4=gscatter(itc_corr,score_pc2,gsounds2);
text(itc_corr,score_pc2,sounds2,'horizontal','right','vertical','bottom');
coeffs=polyfit(itc_corr,score_pc2',1);
fittedx=linspace(min(itc_corr),max(itc_corr),200);
fittedy=polyval(coeffs,fittedx);
hold on;
plot(fittedx,fittedy,'--','color',[0.5 0.5 0.5],'LineWidth',1);
title({'ITC vs PC2 scores';'(Condition Average)'},'FontSize',14,'FontWeight','bold');
xlabel('ITC','FontSize',13,'FontWeight','bold');
ylabel('PC2 scores','FontSize',13,'FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
%legend('Position',[0.93 0.718 0.05 0.03]);
vowels=h4(1);
vstops=h4(2);
ustops=h4(4);
fricatives=h4(3);
rhotics=h4(5);
nasals=h4(6);
sibilants=h4(7);
vowels.Color=[0.02 0.8 0.18];
vstops.Color=[1 0.5 0];
ustops.Color=[0.93 0.69 0.13];
fricatives.Color=[0.57 0.04 0.75];
rhotics.Color=[0.13 0.67 0.9];
nasals.Color=[0.2857 0 1];
sibilants.Color=[1 0 1];
%legend('Vowels','Voiced Stops','Unvoiced Stops','Nasals','Sibilants','Liquids','Fricatives','Location','Southeast');%'Position',[0.2 0.513 0.05 0.03]
set(gca,'LineWidth',1);

%hLeg=findobj(fig,'type','legend');
%set(hLeg,'visible','off');
%set(gca,'XAxisLocation','top');

%import cvs first
%cv2=reshape(cv,5,14);
%cv2=mean(cv2);

%%
%{
hold on;
scatter(itc_corr(1),score_pc1(1),'r', 'filled');
hold on;
scatter(itc_corr([2,3,5]),score_pc1([2,3,5]),'g', 'filled');
hold on;
scatter(itc_corr([6,10,13]),score_pc1([6,10,13]),'k', 'filled');
hold on;
scatter(itc_corr([8,9]),score_pc1([8,9]),'b', 'filled');
hold on;
scatter(itc_corr([12,15]),score_pc1([12,15]),'m', 'filled');
hold on;
scatter(itc_corr([7,11]),score_pc1([7,11]),'y', 'filled');
hold on;
scatter(itc_corr([4,14]),score_pc1([4,14]),'c', 'filled');
text(itc_corr,score_pc1,sounds2,'horizontal','right','vertical','bottom','FontSize',14,'FontWeight','bold');
title({'Scatterplot of ITC versus PC1 scores';'(Condition Average)'},'FontSize',14,'FontWeight','bold');
xlabel('ITC','FontWeight','bold');
ylabel('PC1 scores','FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
%}
%correlations with z-scored sound properties are the same as those with the
%unmodified sound properties 
%{
vowels_znew=sound_prop_z([1,12,13,44,45],:);
sound_prop_znew=sound_prop_z;
sound_prop_znew([1,12,13,44,45],:)=[];
sound_prop_znew=[vowels_znew;sound_prop_znew];
sound_prop_znew=reshape(sound_prop_znew,5,15,6);
sound_prop_znew=squeeze(mean(sound_prop_znew));
fprintf('Correlation with z-scored peak der \n');
[rho,pval]=corr(itc_corr,sound_prop_znew(:,1))
fprintf('Correlation with z-scored time of peak der \n');
[rho,pval]=corr(itc_corr,sound_prop_znew(:,2))
fprintf('Correlation with z-scored sharpness \n');
[rho,pval]=corr(itc_corr,sound_prop_znew(:,3))
fprintf('Correlation with z-scored normalised sharpness \n');
[rho,pval]=corr(itc_corr,sound_prop_znew(:,4))
fprintf('Correlation with z-scored gini \n');
[rho,pval]=corr(itc_corr,sound_prop_znew(:,5))
fprintf('Correlation with z-scored time of MA \n');
[rho,pval]=corr(itc_corr,sound_prop_znew(:,6))
%}
%{
sound_prop_new=sound_prop*Coeff(:,1);
sound_prop_znew=sound_prop_z*Coeff(:,1);

vowels_new=sound_prop_new([1,12,13,44,45]);
sound_prop_new([1,12,13,44,45])=[];
sound_prop_new=[vowels_new;sound_prop_new];
sound_prop_new=reshape(sound_prop_new,5,15);
sound_prop_new=mean(sound_prop_new);

vowels_znew=sound_prop_znew([1,12,13,44,45]);
sound_prop_znew([1,12,13,44,45])=[];
sound_prop_znew=[vowels_znew;sound_prop_znew];
sound_prop_znew=reshape(sound_prop_znew,5,15);
sound_prop_znew=mean(sound_prop_znew);

fprintf('Correlation with sound properties * coeff of PC1 \n');
[rho,pval]=corr(itc_corr,sound_prop_new')
fprintf('Correlation with z-scored sound properties * coeff of Pc1 \n');%same as 'Correlation with scores of PC1'
[rho,pval]=corr(itc_corr,sound_prop_znew')
%}

vowels_tpeakder=time_peakder([1,12,13,44,45]);
time_peakder([1,12,13,44,45])=[];
time_peakder=[vowels_tpeakder;time_peakder];
%}
