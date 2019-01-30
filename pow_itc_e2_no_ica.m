clearvars;
addpath('/Users/gigel/Documents/Speech EEG/Code /Entrainment_analysis/Experiment 2');
load('Data_fft_all.mat');

n=4500;
Fs=1000;
freq=0:Fs/n:Fs/2;
freq=freq(5:226);

Data_fft=Data_fft.*sqrt(2 ./n);

pow2=Data_fft./abs(Data_fft);

itc=sum(pow2,5);
itc=(abs(itc)/10).^2;

Data_mean=nanmean(Data_fft,5);
evoked_pow=abs(Data_mean).^2;
mean_evoked=squeeze(nanmean(nanmean(evoked_pow,2)));


total_pow = abs(Data_fft).^2;
total_pow = mean(total_pow,5);
mean_total = squeeze(nanmean(nanmean(total_pow,2)));

evoked_without_noise=zeros(size(evoked_pow));
total_without_noise=zeros(size(total_pow));

l=size(evoked_pow,1);
m=size(evoked_pow,2);
p=size(evoked_pow,4);

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

save('Itc_per_stream.mat','itc');
save('Evoked_total_pow.mat','evoked_pow','total_pow','mean_evoked','mean_total');
save('Evoked_total_pow_without_noise.mat','evoked_without_noise','total_without_noise','meanevoked','meantotal');


