%do coh over streams and trials too!

clearvars;
load('/Users/gigel/Documents/Speech EEG/Code /Entrainment_analysis/Processed data/sound_envelopes.mat');
load('Data_fft_all.mat');

env_all_trunc=env_all(:,501:5000);
envfft=fft(env_all_trunc,[],2);
envfft=envfft(:,5:226);
pows=envfft./abs(envfft);
n=size(env_all_trunc,2);
Fs=1000;
freq=0:Fs/n:Fs/2;
freq=freq(5:226);

Pow_each=Data_fft./abs(Data_fft);

sound_coh=zeros(size(Pow_each,1),size(Pow_each,2),size(Pow_each,3),size(Pow_each,4));

for i = 1: size(pows,1)
    for j=1:size(Pow_each,1)
        for h=1:size(Pow_each,2)
    temp1=pows(i,:);
    temp2=squeeze(Pow_each(j,h,:,i,:));
    phase=angle(temp2.*conj(temp1'));
    sine = sin(phase);
    cosine = cos(phase);
    coh=mean(cosine,2).^2+mean(sine,2).^2;
    sound_coh(j,h,:,i)=coh;
        end
    end
end

%take cerebro-acoustic coherence at 4 and 8 Hz
coh48=squeeze(mean(sound_coh,2));
coh4=squeeze(coh48(:,find(freq==4),:))';
coh8=squeeze(coh48(:,find(freq==8),:))';

%take the mean over consonants
n=3;
mean4=arrayfun(@(i) mean(coh4(i:i+n-1,:)),1:n:size(coh4,1),'UniformOutput',false)';
mean4=cell2mat(mean4);

mean8=arrayfun(@(i) mean(coh8(i:i+n-1,:)),1:n:size(coh8,1),'UniformOutput',false)';
mean8=cell2mat(mean8);

%mean and standard deviation of the coherence (over subjects)
sdca4=std(mean4,[],2);
sem4=sdca4./sqrt(size(mean4,2));


sdca8=std(mean8,[],2);
sem8=sdca8./sqrt(size(mean8,2));

mean_sound_coh=squeeze(mean(mean(sound_coh,2)));
mean_sound_coh=mean_sound_coh';

%average over consonant but for all frequency values between 1.14 and 50 Hz
n = 3; % average every n values
sound_coh_cond = arrayfun(@(i) mean(mean_sound_coh(i:i+n-1,:)),1:n:size(mean_sound_coh,1)-n+1,'UniformOutput',false)'; 


sound_coh_cond=cell2mat(sound_coh_cond);

figure;
hold on;
for i=1:size(sound_coh_cond,1)
    plot(freq(1:132),sound_coh_cond(i,1:132));
end
hold off;
title('CaCoh per condition');
xlabel('Frequency, Hz');
ylabel('CaCoh');
legend('Vowel','B','D','G','K','P','T','M','N','S','Z','L','R','F','V');

%%scatter plot of EEG-sound coh at 4 and 8 Hz, check is mean4 and mean8
%%elicit same values as meansoundcoh (and they do)

a='Vbdgkptmnszlrfv';
a=a';
b = cellstr(a);
dx=0.01; dy=0.01;


figure;
scatter(mean(mean4,2),mean(mean8,2));
errorbar(mean(mean4,2),mean(mean8,2),sem8,sem8,sem4,sem4,'o');
text(mean(mean4,2),mean(mean8,2),b,'horizontal','right','vertical','bottom');
title('Scatterplot of Cerebro-acoustic coherence at 4 and 8 Hz');
xlabel('CACH at 4 Hz');
ylabel('CACH at 8 Hz');

%scatter plot per stream
sdsound_coh4_2=std(coh4,[],2);
sem4_2=sdsound_coh4_2./sqrt(size(coh4,2));

sdsound_coh8_2=std(coh8,[],2);
sem8_2=sdsound_coh8_2./sqrt(size(coh8,2));

mean4all_2=mean(coh4,2);
mean8all_2=mean(coh8,2);

sounds='VVVbbbdddgggkkkppptttmmmnnnssszzzlllrrrfffvvv';
sounds=sounds';
sounds2 = cellstr(sounds);


figure;
scatter(mean4all_2,mean8all_2);
errorbar(mean4all_2,mean8all_2,sem8_2,sem8_2,sem4_2,sem4_2,'o');
text(mean4all_2,mean8all_2,sounds2,'horizontal','right','vertical','bottom');
title('Scatterplot of cerebro-acoustic coherence at 4 and 8 Hz (stream)');
xlabel('CaCoh at 4 Hz');
ylabel('CaCoh at 8 Hz');


