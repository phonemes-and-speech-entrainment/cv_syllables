clearvars;
load('/Users/gigel/Documents/Speech EEG/Code /Entrainment_analysis/Processed data/sound_envelopes.mat');
load('Data_fft_all.mat');


Pow_each=Data_fft./abs(Data_fft);

Pow_stream=reshape(Pow_each,[25 32 222 3 15 10]);
Pow_stream=permute(Pow_stream,[1 2 3 5 6 4]);

env_all_trunc=env_all(:,501:5000);
env_stream=reshape(env_all_trunc,[3 15 4500]);
env_stream=permute(env_stream,[2 3 1]);
envfft=fft(env_stream,[],2);
envfft=envfft(:,5:226,:);
pows=envfft./abs(envfft);
n=size(env_all_trunc,2);
Fs=1000;
freq=0:Fs/n:Fs/2;
freq=freq(5:226);

sound_coh=zeros(size(Pow_stream,1),size(Pow_stream,2),size(Pow_stream,3),size(Pow_stream,4));

for i = 1: size(pows,1)
    for j=1:size(Pow_stream,1)
        for h=1:size(Pow_stream,2)
            sine=zeros(size(Pow_stream,3),size(Pow_stream,5),size(Pow_stream,6));
            cosine=zeros(size(Pow_stream,3),size(Pow_stream,5),size(Pow_stream,6));
            for k=1:size(Pow_stream,6)
                temp1=squeeze(pows(i,:,k));
                temp2=squeeze(Pow_stream(j,h,:,i,:,k));
                phase=angle(temp2.*conj(temp1'));
                sine(:,:,k) = sin(phase);
                cosine(:,:,k) = cos(phase);
            end
            coh=mean(mean(cosine,2),3).^2 + mean(mean(sine,2),3).^2;
            sound_coh(j,h,:,i)=coh;
        end
    end
end

figure;
hold on;
for i=1
    plot(freq(1:132),sound_coh(i,1:132));
end
hold off;
%title('CaCoh per condition');
xlabel('Frequency, Hz');
ylabel('CaCoh');
%legend('Vowel','B','D','G','K','P','T','M','N','S','Z','L','R','F','V')


a=find(freq==4);
b=find(freq==8);

soundcoh4=sound_coh(:,:,a,:);
soundcoh8=sound_coh(:,:,b,:);

mean4=squeeze(mean(soundcoh4,2));
mean8=squeeze(mean(soundcoh8,2));

sdca4=std(mean4,[],1);
sem4=sdca4./sqrt(size(mean4,1));


sdca8=std(mean8,[],1);
sem8=sdca8./sqrt(size(mean8,1));

a='Vbdgkptmnszlrfv';
a=a';
b = cellstr(a);
dx=0.01; dy=0.01;


figure;
scatter(mean(mean4),mean(mean8));
errorbar(mean(mean4),mean(mean8),sem8,sem8,sem4,sem4,'o');
text(mean(mean4),mean(mean8),b,'horizontal','right','vertical','bottom');
title('Scatterplot of Cerebro-acoustic coherence at 4 and 8 Hz');
xlabel('CACH at 4 Hz');
ylabel('CACH at 8 Hz');



