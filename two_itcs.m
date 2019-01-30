clearvars;
load('Data_fft_all.mat');

n=4500;
Fs=1000;
freq=0:Fs/n:Fs/2;
freq=freq(5:226);

%Data_fft1=Data_fft.*sqrt(2 ./n);

pow2=Data_fft./abs(Data_fft);

itc1=sum(pow2,5);
itc1=(abs(itc1)/10).^2;

%pow22=Data_fft./abs(Data_fft);

phase=angle(pow2);
sine=sin(phase);
cosine=cos(phase);

itc2=mean(cosine,5).^2+mean(sine,5).^2;

isequal(itc1,itc2)

a=itc1(1,1,:,1);
a=squeeze(a);
b=itc2(1,1,:,1);
b=squeeze(b);
figure;
plot(freq,a);
hold on;
plot(freq,b);
hold off;

