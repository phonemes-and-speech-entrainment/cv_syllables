clearvars;clc;

addpath('/Volumes/Seagate Portable Drive/Speech EEG/Experiment 1/sharpness');
addpath('/Volumes/Seagate Portable Drive/Speech EEG/Code /Entrainment_analysis/Experiment 2/okomarov-ginicoeff-0607437');

files = dir('*.wav');

largest = 0;
for i=1:length(files)
    [sound,~]=audioread(files(i).name);
    if length(sound) > largest
        largest = length(sound);
    end
end

logspace=linspace(log10(80),log10(8000),33);
freqband=power(10,logspace);

env_all=zeros(length(files),largest);
sharp_doe=zeros(length(files),1); %sharpness doelling
sharp_norm=zeros(length(files),1);%normalised sharpness
peakDer=zeros(length(files),1);   %peak derivative
time_of_peakder=zeros(length(files),1); %latency of peak derivative



for i=1:length(files)
    [sound,fs] = audioread(files(i).name);
    sumenv = sharpness_new(sound,fs,freqband);
    l_diff=largest-length(sumenv);
    s=padarray(sumenv,l_diff,0,'post');
    env_all(i,:)=s;
    der=diff(sumenv);
    sharp_doe(i)=mean(der(der>0));
    sharp_norm(i)=sharp_doe(i)/sum(sumenv);
    [maxder,ind]=max(der(1:end-3));
    peakDer(i)=maxder;
    time_of_peakder(i)=ind;
end

[amp,time]=max(env_all,[],2); %extract max amplitude of envelope and its latency

amp=squeeze(amp);
time=squeeze(time);

time_ms=time/fs*1000;

realtime=time_of_peakder/fs*1000; %time of peakder in ms


%extract gini index
gini=zeros(size(env_all,1),1);
for i=1:size(gini,1)
    temp=ginicoeff(env_all(i,:));
    gini(i,:)=temp;
end


% calculate:
%- the time interval between 20% and 80% of the maximum amplitude of the envelope
%- the time interval between 20% and 80% of the peak derivative of the envelope

interval_ma = zeros(length(files),1);
interval_peakder = zeros(length(files),1);
interval_ma_ind = zeros(length(files),2);
interval_peakder_ind = zeros(length(files),2);
interval_plateau = zeros(length(files),1);
interval_plateau_ind = zeros(length(files),2);
high_amp = zeros(length(files),1);
time80 = zeros(length(files),1);


for i=1:length(files)
    low_amp = 20/100*amp(i);
    high_amp(i) = 80/100*amp(i);
    %find first time for low_amp and high_amp and take time interval
    env = env_all(i,:);
    low = find(env>low_amp);
    high = find(env>high_amp(i));
    new_high = find(env(high:end)<high_amp(i)); %check what this starts the count at
    first_low = low(1);
    first_high = high(1);
    time80(i) = first_high;
    last_high = new_high(1)+first_high;
    interval_ma_ind(i,:) = [first_low,first_high];
    interval_ma(i)=first_high-first_low;
    interval_plateau_ind(i,:) = [first_high,last_high];
    interval_plateau(i)=last_high - first_high;
    %same for peak derivative
    low_peakder = 20/100*peakDer(i);
    high_peakder = 80/100*peakDer(i);
    der = diff(env);
    %low_pd = find(abs(der-low_peakder)<.000001);
    %high_pd = find(abs(der-high_peakder)<.000001);
    low_pd = find(der>low_peakder);
    high_pd = find(der>high_peakder);
    first_low_pd = low_pd(1);
    first_high_pd = high_pd(1);
    interval_peakder_ind(i,:) = [first_low_pd,first_high_pd];
    interval_peakder(i) = first_high_pd - first_low_pd;
end
    
interval_ma_ms = interval_ma/fs*1000;
interval_peakder_ms = interval_peakder/fs*1000;
interval_plateau_ms = interval_plateau/fs*1000;
time80_ms = time80/fs*1000;


%plot envelopes with edge marks
t =0:1:largest-1;
t = t/fs*1000;


p1 = [interval_ma_ind(61,1)/fs*1000 interval_ma_ind(61,2)/fs*1000];                         % First Point
p2 = [0.08 0.08];                      
p3 = [interval_peakder_ind(61,1)/fs*1000 interval_peakder_ind(61,2)/fs*1000];                         % First Point
p4 = [0.06 0.06]; 
p5 = [interval_plateau_ind(61,1)/fs*1000 interval_plateau_ind(61,2)/fs*1000];

figure;
plot(t,env_all(61,:),'-k','LineWidth',1);
xline(time(61)/fs*1000, '--', 'Color',[0.6350 0.0780 0.1818],'LineWidth',1);
text(time(61)/fs*1000+3,amp(61)-0.002, sprintf('1'),'FontSize',13,'FontWeight','bold');
xline(time_of_peakder(61)/fs*1000,'--', 'Color',[0.4660 0.6740 0.1880],'LineWidth',1);
text(time_of_peakder(61)/fs*1000+0.002,env_all(61,time_of_peakder(61))-0.003, sprintf('2'),'FontSize',13,'FontWeight','bold');
xline(interval_ma_ind(61,1)/fs*1000,'--','Color',[0.9290 0.6940 0.1250],'LineWidth',1);
xline(interval_ma_ind(61,2)/fs*1000,'--','Color',[0.8500 0.3250 0.0980],'LineWidth',1);
xline(interval_plateau_ind(61,2)/fs*1000,'--','Color',[0.8500 0.3250 0.0980],'LineWidth',1);
xline(interval_peakder_ind(61,1)/fs*1000,'--','Color',[0.3010 0.7450 0.9330],'LineWidth',1);
xline(interval_peakder_ind(61,2)/fs*1000,'--','Color',[0 0.4480 0.7410],'LineWidth',1);
xlim([-5 250]);
hold on;
plot(p1,p2,'-k','LineWidth',1.5);
text((p1(2)+p1(1))/2,0.085, sprintf('3'),'FontSize',13,'FontWeight','bold');
hold on;
plot(p3,p4,'-k','LineWidth',1.5);
text((p3(2)+p3(1))/2-2,0.065,sprintf('4'),'FontSize',13,'FontWeight','bold');
hold on;
plot(p5,[high_amp(61) high_amp(61)],'-k','LineWidth',1.5);
text((p5(2)+p5(1))/2-2,high_amp(61)+0.004,sprintf('5'),'FontSize',13,'FontWeight','bold');
title('Narrowband Envelope ''/ta/'' - Bandpassed','FontSize',15,'FontWeight','bold');
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
set(gca,'linewidth',1);
dim = [.63 .6 .3 .3];
str = sprintf("1 - Maximum amplitude (MA)\n2 - Peak Derivative (PD)\n3 - Interval to MA\n4 - Interval to PD\n5 - Plateau Interval");
annotation('textbox',dim, 'String', str,'FitBoxToText','on');
box on
set(gca,'XTick',[])
set(gca,'YTick',[])


%use both for correlations with itc 1 and 2 as well as for pca on edge
%measures
sound_prop1=[peakDer,realtime,sharp_doe,sharp_norm,gini,amp,time_ms]; 
sound_prop2=[peakDer,realtime,sharp_doe,sharp_norm,gini,amp,time_ms,interval_ma_ms,interval_peakder_ms,interval_plateau_ms,time80_ms]; 

%re-arrange sound properties to match the order of the conditions in itpc
vowels2 = sound_prop2([1,12,13,44,45],:);
b2=sound_prop2(2:6,:);
d2=sound_prop2(7:11,:);
g2=sound_prop2(19:23,:);
k2=sound_prop2(24:28,:);
p2=sound_prop2(46:50,:);
t2=sound_prop2(61:65,:);
m2=sound_prop2(34:38,:);
n2=sound_prop2(39:43,:);
s2=sound_prop2(56:60,:);
z2=sound_prop2(71:75,:);
l2=sound_prop2(29:33,:);
r2=sound_prop2(51:55,:);
f2=sound_prop2(14:18,:);
v2=sound_prop2(66:70,:);

vowels_mean = mean(vowels2);
b_mean = mean(b2);
d_mean = mean(d2);
g_mean = mean(g2);
k_mean = mean(k2);
p_mean = mean(p2);
t_mean = mean(t2);
m_mean = mean(m2);
n_mean = mean(n2);
s_mean = mean(s2);
z_mean = mean(z2);
l_mean = mean(l2);
r_mean = mean(r2);
f_mean = mean(f2);
v_mean = mean(v2);

%matrix ordered in the same way as itpc
sound_prop2_ordered = [vowels2;b2;d2;g2;k2;p2;t2;m2;n2;s2;z2;l2;r2;f2;v2];
%the above averaged by condition
sound_prop2_cond = [vowels_mean;b_mean;d_mean;g_mean;k_mean;p_mean;t_mean;m_mean;n_mean;s_mean;z_mean;l_mean;r_mean;f_mean;v_mean];


%{
%figures
figure(1);
plot(1:25,time_ms,'r');
hold on;
plot(1:25,realtime,'b');
title('Time of maximum amplitude versus time of peak derivative per syllable');

figure(2);
plot(1:25,amp,'r');
title('Maximum amplitude per syllable');
figure(3)
plot(1:25,peakDer,'b');
title('Peak derivative per syllable');
%}

save('Sound_properties_may21.mat','sound_prop2_ordered','sound_prop2_cond');

%{
for i = 1:length(files)
p1 = [interval_ma_ind(i,1)/fs*1000 interval_ma_ind(i,2)/fs*1000];                         % First Point
p2 = [0.08 0.08];                      
p3 = [interval_peakder_ind(i,1)/fs*1000 interval_peakder_ind(i,2)/fs*1000];                         % First Point
p4 = [0.06 0.06]; 
p5 = [interval_plateau_ind(i,1)/fs*1000 interval_plateau_ind(i,2)/fs*1000];
h=figure;
plot(t,env_all(i,:),'-k','LineWidth',1);
xline(time(i)/fs*1000, '--', 'Color',[0.6350 0.0780 0.1818],'LineWidth',1);
text(time(i)/fs*1000+1,amp(i)+0.001, sprintf('1'),'FontSize',13,'FontWeight','bold');
xline(time_of_peakder(i)/fs*1000,'--', 'Color',[0.4660 0.6740 0.1880],'LineWidth',1);
text(time_of_peakder(i)/fs*1000+0.002,env_all(i,time_of_peakder(i))-0.003, sprintf('2'),'FontSize',13,'FontWeight','bold');
xline(interval_ma_ind(i,1)/fs*1000,'--','Color',[0.9290 0.6940 0.1250],'LineWidth',1);
xline(interval_ma_ind(i,2)/fs*1000,'--','Color',[0.8500 0.3250 0.0980],'LineWidth',1);
xline(interval_plateau_ind(i,2)/fs*1000,'--','Color',[0.8500 0.3250 0.0980],'LineWidth',1);
xline(interval_peakder_ind(i,1)/fs*1000,'--','Color',[0.3010 0.7450 0.9330],'LineWidth',1);
xline(interval_peakder_ind(i,2)/fs*1000,'--','Color',[0 0.4480 0.7410],'LineWidth',1);
xlim([-5 250]);
hold on;
plot(p1,p2,'-k','LineWidth',1.5);
text((p1(2)+p1(1))/2,0.085, sprintf('3'),'FontSize',13,'FontWeight','bold');
hold on;
plot(p3,p4,'-k','LineWidth',1.5);
text((p3(2)+p3(1))/2-2,0.014,sprintf('4'),'FontSize',13,'FontWeight','bold');
hold on;
plot(p5,[high_amp(i) high_amp(i)],'-k','LineWidth',1.5);
text((p5(2)+p5(1))/2-2,high_amp(i)+0.004,sprintf('5'),'FontSize',13,'FontWeight','bold');
title(sprintf('Narrowband Envelope %d - Bandpassed',i),'FontSize',15,'FontWeight','bold');
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
set(gca,'linewidth',1);
dim = [.63 .6 .3 .3];
str = sprintf("1 - Maximum amplitude (MA)\n2 - Peak Derivative (PD)\n3 - Interval to MA\n4 - Interval to PD\n5 - Plateau Interval");
annotation('textbox',dim, 'String', str,'FitBoxToText','on');
box on
set(gca,'XTick',[])
set(gca,'YTick',[])
saveas(h,sprintf('FIG%d.png',i))
end
%}
