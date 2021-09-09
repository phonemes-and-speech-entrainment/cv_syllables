%{
ITC, Evoked Power and Induced Power.

(c) Oana Cucu 2019. oana.cucu@bristol.ac.uk

%}

clearvars;
addpath('/Volumes/Seagate Portable Drive/Speech EEG/Code /Entrainment_analysis/Experiment 2');
load('Data_fft_all.mat');

n=4500;
Fs=1000;
freq=0:Fs/n:Fs/2;
freq=freq(5:226);

%itc
Data_fft=Data_fft.*sqrt(2 ./n);

pow2=Data_fft./abs(Data_fft);

itc=sum(pow2,5);
itc=(abs(itc)/10).^2;

%evoked power
Data_mean=mean(Data_fft,5);
evoked_pow=abs(Data_mean).^2;
mean_evoked=squeeze(mean(mean(evoked_pow,2)));

%total power
total_pow = abs(Data_fft).^2;
total_pow = mean(total_pow,5);
mean_total = squeeze(mean(mean(total_pow,2)));

evoked_without_noise=zeros(size(evoked_pow));
total_without_noise=zeros(size(total_pow));

l=size(evoked_pow,1);
m=size(evoked_pow,2);
p=size(evoked_pow,4);

%remove 1/f noise from evoked and induced power
for i=1:l
    for j=1:m
        for k=1:p
            temp1=squeeze(evoked_pow(i,j,:,k));
            temp2=remove_noise(temp1,freq');
            temp3=squeeze(total_pow(i,j,:,k));
            temp4=remove_noise(temp3,freq');
            evoked_without_noise(i,j,:,k)=temp2;
            total_without_noise(i,j,:,k)=temp4;
        end
    end
end

meanevoked=squeeze(nanmean(nanmean(evoked_without_noise,2)));

meantotal=squeeze(nanmean(nanmean(total_without_noise,2)));

%save('Itc_per_stream.mat','itc');
%save('Evoked_total_pow.mat','evoked_pow','total_pow','mean_evoked','mean_total');
%save('Evoked_total_pow_without_noise.mat','evoked_without_noise','total_without_noise','meanevoked','meantotal');

itc_all=squeeze(mean(mean(itc,4),2));
evoked_all=squeeze(mean(mean(evoked_without_noise,4),2));
total_all=squeeze(mean(mean(total_without_noise,4),2));

mean_itc_all=mean(itc_all);
mean_evoked_all=mean(evoked_all);
mean_total_all=mean(total_all);

f=find(freq==22);

figure('Renderer', 'painters', 'Position', [10 10 450 300]);

h=zeros(1,26);
hold on;
for i=1:size(evoked_all,1)
    h(i)=plot(freq(1:f),evoked_all(i,1:f),'Color','b','DisplayName','individual subjects');
end
hold on;
h(26)=plot(freq(1:f),mean_evoked_all(1:f),'k','LineWidth',3,'DisplayName','subject average');
xlabel('Frequency (Hz)','FontWeight','bold');
ylabel('Evoked Power','FontWeight','bold');
mysigstar(gca,4,10,0.001);
%title('Evoked Power averaged over channels and conditions','FontSize',14);
title('Evoked Power','FontSize',14);
legend(h(1,[1,26]));
xlim([1 22])
set(gca,'Units','normalized')
titleHandle = get( gca ,'Title' );
pos  = get( titleHandle , 'position' );
pos2 = pos + [-5.9 0. 0];
set( titleHandle , 'position' , pos2 );
set(gca,'linewidth',1);
box on

%{
figure('Renderer', 'painters', 'Position', [10 10 450 900]);

subplot(3,1,1);

h1=zeros(1,26);
%figure('Renderer', 'painters', 'Position', [10 10 450 300]);
hold on;
for i=1:size(itc_all,1)
    h1(i)=plot(freq(1:f),itc_all(i,1:f),'Color','b','DisplayName','individual subjects');
end
hold on;
h1(26)=plot(freq(1:f),mean_itc_all(1:f),'k','LineWidth',3,'DisplayName','subject average');
xlabel('Frequency (Hz)','FontWeight','bold');
ylabel('Mean ITC','FontWeight','bold');
%title('ITC averaged over channels and conditions','FontSize',14);
title('ITC','FontSize',14);
legend(h1(1,[1,26]),'Position',[0.77 0.96 0.01 0.02]);
xlim([1 22])
set(gca,'Units','normalized')
titleHandle = get( gca ,'Title' );
pos  = get( titleHandle , 'position' );
pos1 = pos + [-8 0 0];
set( titleHandle , 'position' , pos1 );
set(gca,'linewidth',1);
box on
%saveas(gcf,'mean_itc_subj.png');

subplot(3,1,2);

h2=zeros(1,26);
%figure('Renderer', 'painters', 'Position', [10 10 450 300]);
hold on;
for i=1:size(evoked_all,1)
    h2(i)=plot(freq(1:f),evoked_all(i,1:f),'Color','b','DisplayName','individual subjects');
end
hold on;
h2(26)=plot(freq(1:f),mean_evoked_all(1:f),'k','LineWidth',3,'DisplayName','subject average');
xlabel('Frequency (Hz)','FontWeight','bold');
ylabel('Mean Evoked Power','FontWeight','bold');
%title('Evoked Power averaged over channels and conditions','FontSize',14);
title('Evoked Power','FontSize',14);
%legend(h2(1,[1,26]));
xlim([1 22])
set(gca,'Units','normalized')
titleHandle = get( gca ,'Title' );
pos  = get( titleHandle , 'position' );
pos2 = pos + [-5.9 0. 0];
set( titleHandle , 'position' , pos2 );
set(gca,'linewidth',1);
box on
%saveas(gcf,'mean_evoked_subj.png');

subplot(3,1,3);

h3=zeros(1,26);
%figure('Renderer', 'painters', 'Position', [10 10 450 300]);
hold on;
for i=1:size(evoked_all,1)
    h3(i)=plot(freq(1:f),total_all(i,1:f),'Color','b','DisplayName','individual subjects');
end
hold on;
h3(26)=plot(freq(1:f),mean_total_all(1:f),'k','LineWidth',3,'DisplayName','subject average');
xlabel('Frequency (Hz)','FontWeight','bold');
ylabel('Mean Induced Power','FontWeight','bold');
%title('Induced Power averaged over channels and conditions','FontSize',14);
title('Induced Power','FontSize',14);
%legend(h3(1,[1,26]));
xlim([1 22])
set(gca,'Units','normalized')
titleHandle = get( gca ,'Title' );
pos  = get( titleHandle , 'position' );
pos3 = pos + [-5.7 0 0];
set( titleHandle , 'position' , pos3 );
set(gca,'linewidth',1);
box on

%sgtitle('EEG measures averaged over channels and conditions','FontSize',15,'FontWeight','bold');

%saveas(gcf,'mean_total_subj.png');

%saveas(gcf,'pow_itc_subj.tif');

%{
double_mean_evoked=mean(mean_evoked,2);

figure('Renderer', 'painters', 'Position', [10 10 450 300]);
loglog(freq(1:f),double_mean_evoked(1:f),'k','LineWidth',3);
xlabel('Log Frequency (Hz)','FontSize',14);
ylabel('Log Power','FontSize',14);
title('1/f Noise in the EEG spectrum','FontSize',15);
%title('Evoked Power','FontSize',14);
%legend(h2(1,[1,26]));
%xlim([1 22])
xticks(0:1:10);
set(gca,'linewidth',1);
set(gca,'YTick', []);
%}
%}


