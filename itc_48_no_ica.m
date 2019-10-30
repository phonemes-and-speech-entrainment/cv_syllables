%{

ITC at 4 Hz is plotted against the ITC at 8 Hz. These are averaged over
subjects and channels.

(c) Oana Cucu 2019. oana.cucu@bristol.ac.uk

%}


clearvars;
load('Itc_per_stream.mat');
n=4500;
Fs=1000;
freq=0:Fs/n:Fs/2;
freq=freq(5:226);

a=find(freq==4);
b=find(freq==8);
c=find(freq==12);
d=find(freq==16);

Itc4=squeeze(itc(:,:,a,:));
Itc8=squeeze(itc(:,:,b,:));
Itc12=squeeze(itc(:,:,c,:));
Itc16=squeeze(itc(:,:,d,:));

Itc4=squeeze(mean(Itc4,2));
Itc4=Itc4';
Itc8=squeeze(mean(Itc8,2));
Itc8=Itc8';
Itc12=squeeze(mean(Itc12,2));
Itc12=Itc12';
Itc16=squeeze(mean(Itc16,2));
Itc16=Itc16';

%bins
Itc4_comp=itc(:,:,[(a-9):(a-1),(a+1):(a+9)],:);
Itc4_comp=squeeze(mean(Itc4_comp,2));
Itc4_comp=permute(Itc4_comp,[3 1 2]);

Itc8_comp=itc(:,:,[(b-9):(b-1),(b+1):(b+9)],:);
Itc8_comp=squeeze(mean(Itc8_comp,2));
Itc8_comp=permute(Itc8_comp,[3 1 2]);

Itc12_comp=itc(:,:,[(c-9):(c-1),(c+1):(c+9)],:);
Itc12_comp=squeeze(mean(Itc12_comp,2));
Itc12_comp=permute(Itc12_comp,[3 1 2]);

Itc16_comp=itc(:,:,[(d-9):(d-1),(d+1):(d+9)],:);
Itc16_comp=squeeze(mean(Itc16_comp,2));
Itc16_comp=permute(Itc16_comp,[3 1 2]);


%mean cond
n=3;
meanitc4=arrayfun(@(i) mean(Itc4(i:i+n-1,:)),1:n:size(Itc4,1),'UniformOutput',false)';
meanitc4=cell2mat(meanitc4);

meanitc8=arrayfun(@(i) mean(Itc8(i:i+n-1,:)),1:n:size(Itc8,1),'UniformOutput',false)';
meanitc8=cell2mat(meanitc8);

meanitc12=arrayfun(@(i) mean(Itc12(i:i+n-1,:)),1:n:size(Itc12,1),'UniformOutput',false)';
meanitc12=cell2mat(meanitc12);

meanitc16=arrayfun(@(i) mean(Itc16(i:i+n-1,:)),1:n:size(Itc16,1),'UniformOutput',false)';
meanitc16=cell2mat(meanitc16);

meanitc4_comp=arrayfun(@(i) mean(Itc4_comp(i:i+n-1,:,:)),1:n:size(Itc4_comp,1),'UniformOutput',false)';
meanitc4_comp=cell2mat(meanitc4_comp);

meanitc8_comp=arrayfun(@(i) mean(Itc8_comp(i:i+n-1,:,:)),1:n:size(Itc8_comp,1),'UniformOutput',false)';
meanitc8_comp=cell2mat(meanitc8_comp);

meanitc12_comp=arrayfun(@(i) mean(Itc12_comp(i:i+n-1,:,:)),1:n:size(Itc12_comp,1),'UniformOutput',false)';
meanitc12_comp=cell2mat(meanitc12_comp);

meanitc16_comp=arrayfun(@(i) mean(Itc16_comp(i:i+n-1,:,:)),1:n:size(Itc16_comp,1),'UniformOutput',false)';
meanitc16_comp=cell2mat(meanitc16_comp);

sditc4=std(meanitc4,[],2);
sem4=sditc4./sqrt(size(meanitc4,2));

sditc8=std(meanitc8,[],2);
sem8=sditc8./sqrt(size(meanitc8,2));

mean4=mean(meanitc4,2);
mean8=mean(meanitc8,2);

sounds2={'Vowels';'/b/';'/d/';'/g/';'/k/';'/p/';'/t/';'/m/';'/n/';'/s/';'/z/';'/l/';'/r/';'/f/';'/v/'};
sounds={'Vowels';'Vowels';'Vowels';'/b/';'/b/';'/b/';'/d/';'/d/';'/d/';'/g/';'/g/';'/g/';'/k/';'/k/';'/k/';'/p/';'/p/';'/p/';'/t/';'/t/';'/t/';'/m/';'/m/';'/m/';'/n/';'/n/';'/n/';'/s/';'/s/';'/s/';'/z/';'/z/';'/z/';'/l/';'/l/';'/l/';'/r/';'/r/';'/r/';'/f/';'/f/';'/f/';'/v/';'/v/';'/v/'};

%{
figure('Renderer', 'painters', 'Position', [10 10 450 900]);

subplot(2,1,1);
errorbar(mean4,mean8,sem8,sem8,sem4,sem4,'o', 'MarkerSize',5,...
    'MarkerEdgeColor','blue','MarkerFaceColor','red');
text(mean4,mean8,sounds,'horizontal','right','vertical','bottom');
title('Scatterplot of Itc at 4 and 8 Hz, per condition','FontSize',14,'FontWeight','bold');
set(gca,'Units','normalized');
titleHandle = get( gca ,'Title' );
pos1  = get( titleHandle , 'position' );
pos1 = pos1 + [0 0.005 0];
set( titleHandle , 'position' , pos1 );
xlabel('Itc 4 Hz','FontWeight','bold');
ylabel('Itc 8 Hz','FontWeight','bold');
%}
%{
mean4=meanitc4';
mean8=meanitc8';
p1=anova1(mean4);
p2=anova1(mean8);
%}


%scatter plot per stream
sditcstream4=std(Itc4,[],2);
semitcstr4=sditcstream4./sqrt(size(Itc4,2));

sditcstream8=std(Itc8,[],2);
semitcstr8=sditcstream8./sqrt(size(Itc8,2));

mean4all_2=mean(Itc4,2);
mean8all_2=mean(Itc8,2);
mean12all_2=mean(Itc12,2);
mean16all_2=mean(Itc16,2);

%{
subplot(2,1,2);
scatter(mean4all_2,mean8all_2,'o',...
    'MarkerEdgeColor','blue','MarkerFaceColor','red');
%errorbar(mean4all_2,mean8all_2,semitcstr8,semitcstr8,semitcstr4,semitcstr4,'o', 'MarkerSize',5,...
%    'MarkerEdgeColor','blue','MarkerFaceColor','red');
text(mean4all_2,mean8all_2,sounds2,'horizontal','right','vertical','bottom');
title('Scatterplot of ITC at 4 and 8 Hz, per stream','FontSize',14,'FontWeight','bold');
set(gca,'Units','normalized')
titleHandle = get( gca ,'Title' );
pos2  = get( titleHandle , 'position' );
pos2 = pos2 + [0 0.005 0];
set( titleHandle , 'position' , pos2 );
xlabel('ITC 4 Hz','FontWeight','bold');
ylabel('ITC 8 Hz','FontWeight','bold');
%}

meanitc=squeeze(mean(mean(itc,2)));
meanitc=meanitc';

meanitc_cond=arrayfun(@(i) mean(meanitc(i:i+n-1,:)),1:n:size(meanitc,1),'UniformOutput',false)';
meanitc_cond=cell2mat(meanitc_cond);

%{
figure;
hold on;
for i=11 %1:size(meanitc_cond,1)
    plot(freq(1:132),meanitc_cond(i,1:132));
end
hold off;
title('ITC per condition');
xlabel('Frequency, Hz');
ylabel('ITC');
legend('Vowel','B','D','G','K','P','T','M','N','S','Z','L','R','F','V');
%}

%fprintf('standard error of itc at 4 hz per cond is \n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n',sem4);
%fprintf('standard error of itc at 8 hz per cond is \n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n',sem8);
%fprintf('mean standard error of itc at 4 hz per cond is %f\n',mean(sem4));
%fprintf('mean standard error of itc at 8 hz per cond is %f\n',mean(sem8));


%save('Itc_for_stats.mat','Itc4','Itc8','Itc12','Itc16','meanitc4','meanitc8','meanitc12','meanitc16');

%save('Itc_bins_comp.mat','Itc4_comp','Itc8_comp','Itc12_comp','Itc16_comp','meanitc4_comp','meanitc8_comp','meanitc12_comp','meanitc16_comp');


gsounds={'Vowels';'Vowels';'Vowels';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Voiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Unvoiced Stops';'Nasals';'Nasals';'Nasals';'Nasals';'Nasals';'Nasals';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Sibilants';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Rhotics';'Fricatives';'Fricatives';'Fricatives';'Fricatives';'Fricatives';'Fricatives'};


fig=figure('Renderer', 'painters', 'Position', [10 10 500 1000]);
subplot(2,1,1);
h1=gscatter(mean4all_2,mean8all_2,gsounds);
text(mean4all_2,mean8all_2,sounds,'horizontal','right','vertical','bottom');
title('ITC 4 vs 8 Hz by Stream','FontSize',14,'FontWeight','bold');
xlabel('ITC 4 Hz','FontWeight','bold');
ylabel('ITC 8 Hz','FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
axis([0.12 0.23 0.11 0.21])
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
e1=errorbar(mean4(1),mean8(1),sem8(1),sem8(1),sem4(1),sem4(1),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.02 0.8 0.18],'MarkerFaceColor',[0.02 0.8 0.18]);
hold on;
e2=errorbar(mean4(2:4),mean8(2:4),sem8(2:4),sem8(2:4),sem4(2:4),sem4(2:4),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);
hold on;
e3=errorbar(mean4(5:7),mean8(5:7),sem8(5:7),sem8(5:7),sem4(5:7),sem4(5:7),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.93 0.69 0.13],'MarkerFaceColor',[0.93 0.69 0.13]);
hold on;
e4=errorbar(mean4(8:9),mean8(8:9),sem8(8:9),sem8(8:9),sem4(8:9),sem4(8:9),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.2857 0 1],'MarkerFaceColor',[0.2857 0 1]);
hold on;
e5=errorbar(mean4(10:11),mean8(10:11),sem8(10:11),sem8(10:11),sem4(10:11),sem4(10:11),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[1 0 1],'MarkerFaceColor',[1 0 1]);
hold on;
e6=errorbar(mean4(12:13),mean8(12:13),sem8(12:13),sem8(12:13),sem4(12:13),sem4(12:13),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.13 0.67 0.9],'MarkerFaceColor',[0.13 0.67 0.9]);
hold on;
e7=errorbar(mean4(14:15),mean8(14:15),sem8(14:15),sem8(14:15),sem4(14:15),sem4(14:15),'o', 'MarkerSize',5,...
    'MarkerEdgeColor',[0.57 0.04 0.75],'MarkerFaceColor',[0.57 0.04 0.75]);
text(mean4,mean8,sounds2,'horizontal','right','vertical','bottom');
title('ITC 4 vs 8 Hz by Condition','FontSize',14,'FontWeight','bold');
xlabel('ITC 4 Hz','FontWeight','bold');
ylabel('ITC 8 Hz','FontWeight','bold');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
axis([0.12 0.23 0.11 0.21])
e5.Color=[1 0 1];
e1.Color=[0.02 0.8 0.18];
set(gca,'LineWidth',1);
hLeg=findobj(fig,'type','legend');
legend('Vowels','Voiced Stops','Unvoiced Stops','Nasals','Sibilants','Liquids','Fricatives','Location','Southeast');%'Position',[0.2 0.513 0.05 0.03]
%set(hLeg,'visible','off');
box on

%}