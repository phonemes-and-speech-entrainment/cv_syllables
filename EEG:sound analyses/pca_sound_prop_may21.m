clearvars; clc;

load('Zscores_sound_prop_pca_may21.mat');
%{
[Coeff, Score, Latent, TSquared, Explained]=pca(zscores_for_pca);

x=1:11;

fig1=figure('Renderer', 'painters', 'Position', [10 10 450 300]);
plot(x,Latent,'-ks','LineWidth',2);
title('Eigenvalues of PCA Components for 7 Edge Markers','FontSize',14,'FontWeight','bold');
xlabel('Component Number','FontSize',13,'FontWeight','bold');
ylabel('Eigenvalues','FontSize',13,'FontWeight','bold');
xticks(1:7)
xlim([0 7]);
ylim([0 5]);
set(gca,'LineWidth',1);

factor_loadings7 = Coeff';


fig2=figure('Renderer', 'painters', 'Position', [10 10 450 350]);

b1 = bar(factor_loadings7,'FaceColor','flat');
xlabel('Edge marker PCA component','FontSize',14);
ylabel('Factor loadings','FontSize',14);
title('Factor loadings of edge markers for 7 PCA components','FontSize',14,'FontWeight','bold');
axis([0 8 -0.8 1.5]);
legend('PD','PD Latency','Doelling Sharpness','Normalised Sharpness','Gini','MA','MA Latency','MA Plateau');
%}

zscores_for_pca2 = zscores_for_pca(:,[2 3 5 7 10]);

[Coeff2, Score2, Latent2, TSquared2, Explained2]=pca(zscores_for_pca2);

x2=1:5;

fig3=figure('Renderer', 'painters', 'Position', [10 10 450 300]);
plot(x2,Latent2,'-ks','LineWidth',2);
title('Eigenvalues of PCA Components for 5 Edge Markers','FontSize',14,'FontWeight','bold');
xlabel('Component Number','FontSize',13,'FontWeight','bold');
ylabel('Eigenvalues','FontSize',13,'FontWeight','bold');
xticks(1:5)
xlim([0 7]);
ylim([0 5]);
set(gca,'LineWidth',1);

factor_loadings5 = Coeff2';


fig4=figure('Renderer', 'painters', 'Position', [10 10 450 350]);

b2 = bar(factor_loadings5,'FaceColor','flat');
xlabel('Edge marker PCA component','FontSize',14);
ylabel('Factor loadings','FontSize',14);
title('PCA factor loadings of edge markers','FontSize',14,'FontWeight','bold');
axis([0 6 -0.8 1.5]);
legend('PD Latency','Doelling Sharpness','Gini','MA Latency','MA Plateau');