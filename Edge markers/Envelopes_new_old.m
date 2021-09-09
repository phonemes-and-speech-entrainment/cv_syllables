clearvars;clc;

addpath('/Volumes/Seagate Portable Drive/Speech EEG/Experiment 1/sharpness');
addpath('/Volumes/Seagate Portable Drive/Speech EEG/Stims exp 3/Stims and properties/');
files = dir('*.wav');
%files=files(81:end);

%{
Envs=get_envelope_all(files);
%}

largest = 0;
for i=1:length(files)
    [sound,~]=audioread(files(i).name);
    if length(sound) > largest
        largest = length(sound);
    end
end

Envs_old = zeros(largest, length(files));
logspace=linspace(log10(80),log10(8000),33);
freqband=power(10,logspace);

for i = 1:length(files)
    [sound, Fs] = audioread(files(i).name);
    new_sound = padarray(sound, (largest - length(sound)), 'post');
    env = sharpness(new_sound,Fs,freqband);
    Envs_old(:,i) = env;
end

Envs_old=Envs_old(1:44:end,:);



%}
Envs_new = zeros(largest, length(files));

for i = 1:length(files)
    [sound, Fs] = audioread(files(i).name);
    new_sound = padarray(sound, (largest - length(sound)), 'post');
    env = sharpness_new(new_sound,Fs, freqband);
    Envs_new(:,i) = env;
end

Envs_new=Envs_new(1:44:end,:);

time=0:1:(size(Envs_old,1)-1);
%time=time/1000;

%{
fig1=figure('Renderer', 'painters', 'Position', [10 10 600 800]);
subplot(2,1,1);
plot(time,Envs(:,2),'r','LineWidth',1);
%hold on;
%plot(time,Envelopes(:,2),'b','LineWidth',1);
%xlim([0 2.5]);
%lgd=legend('Strong Edges','Weak Edges');
%lgd.FontSize = 12;
title('Syllable Envelope ''Ba'' (narrowband)','FontSize',15,'FontWeight','bold');
xlim([0 250]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
%y=ylabel('Envelope Amplitude','Color','None','FontSize',13,'FontWeight','bold');
%set(y, 'Units', 'Normalized', 'Position', [-0.07, 0.5, 0]);
set(gca,'linewidth',1);
box off

subplot(2,1,2);
plot(time,Envs(:,56),'r','LineWidth',1);
title('Syllable Envelope ''Sa'' (narrowband)','FontSize',15,'FontWeight','bold');
xlim([0 250]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
set(gca,'linewidth',1);
box off
%}

%{
fig2=figure('Renderer', 'painters', 'Position', [10 10 900 300]);
subplot(1,2,1);
plot(time,Envs_old(:,61),'r','LineWidth',1);
title('Narrowband Envelope ''Ba'' - Smoothed','FontSize',15,'FontWeight','bold');
xlim([0 250]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
%set(y, 'Units', 'Normalized', 'Position', [-0.07, 0.5, 0]);
set(gca,'linewidth',1);
box on

subplot(1,2,2);
plot(time,Envs_new(:,61),'r','LineWidth',1);
title('Narrowband Envelope ''Ba'' - Bandpassed','FontSize',15,'FontWeight','bold');
xlim([0 250]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
set(gca,'linewidth',1);
box on
%}

figure;
plot(time,Envs_new(:,45),'r','LineWidth',1);
%title('Narrowband Envelope ''A'' - Bandpassed','FontSize',15,'FontWeight','bold');
xlim([0 250]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
set(gca,'linewidth',1);
box on
%set(gca,'visible','off')



%{
fig3=figure('Renderer', 'painters', 'Position', [10 10 600 800]);


subplot(2,1,1);
plot(time,sound(1:44:end));
title('Sound waveform "zoo"');
xlim([0 250]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Waveform','FontSize',13,'FontWeight','bold');

subplot(2,1,2);
plot(time,abs(sound(1:44:end)));
title('Absolute of sound waveform "zoo"');
xlim([0 250]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Absolute sound value','FontSize',13,'FontWeight','bold');
%}