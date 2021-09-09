%Oana Cucu 2021. Instead of smoothing the sum of the narrowband envelopes,
%this if bandpass filtered between 2 and 10 Hz.

function s = sharpness_new(sound, Fs,freqband)
freqrad=freqband*2/Fs;
x=[];
for i=1:(length(freqrad)-2)
[b,a]=butter(2,[freqrad(i) freqrad(i+1)]);
y=filter(b,a,sound);
x=[x,y];
end
env=envelope(x);
sumenv=sum(env,2);

b = fir1(350,[4/Fs 20/Fs],'bandpass',kaiser(351,0.5));
%s = filter(b,1,sumenv);
s = filtfilt(b,1,sumenv);


%d = designfilt('bandpassfir', 'StopbandFrequency1', .00004535, 'PassbandFrequency1', .0000907, 'PassbandFrequency2', .00045351, 'StopbandFrequency2', .00054422, 'StopbandAttenuation1', 120, 'PassbandRipple', 1, 'StopbandAttenuation2', 120, 'DesignMethod', 'kaiserwin');
%s = filtfilt(d,sumenv);



%old stuff
%s=smooth(sumenv,0.002);
%s=s(1:44:end);
%s=s(1:2000);
%h=0.02;
%derenv=diff(s)/h;
%posder=derenv(derenv>0);
%posder=posder/sum(s);
%sharp=mean(posder);
end





