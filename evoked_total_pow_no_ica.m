clearvars;
load('Evoked_total_pow_without_noise.mat');

n=4500;
Fs=1000;
freq=0:Fs/n:Fs/2;
freq=freq(5:226);

%{
figure;
plot(freq(1:42),squeeze(evoked_without_noise(1,1,1:42,3))); 
hold on;
plot(freq(1:42),squeeze(total_without_noise(1,1,1:42,3)));
legend('evoked power without noise','total power without noise');
%}

evoked_no_noise_chan=squeeze(mean(evoked_without_noise,2));
tot_no_noise_chan=squeeze(mean(total_without_noise,2));

%{
figure;
plot(freq(1:42),squeeze(evoked_no_noise_chan(1,1:42,3))); 
hold on;
plot(freq(1:42),squeeze(tot_no_noise_chan(1,1:42,3)));
legend('evoked power without noise','total power without noise');
title('Mean over channels');
%}

tot_no_noise_subj=squeeze(mean(total_without_noise));
evoked_no_noise_subj=squeeze(mean(evoked_without_noise));

%{
figure;
plot(freq(1:42),squeeze(evoked_no_noise_subj(1,1:42,3))); 
hold on;
plot(freq(1:42),squeeze(tot_no_noise_subj(1,1:42,3)));
legend('evoked power without noise','total power without noise');
title('Mean over subjects');
%}

tot_no_noise_mean=squeeze(mean(tot_no_noise_chan));
evoked_no_noise_mean=squeeze(mean(evoked_no_noise_chan));


figure;
plot(freq(1:42),squeeze(evoked_no_noise_mean(1:42,3))); 
hold on;
plot(freq(1:42),squeeze(tot_no_noise_mean(1:42,3)));
legend('evoked power without noise','total power without noise');
title('Mean over channels and subjects');

tot_no_noise_mean_sound=reshape(tot_no_noise_mean,length(freq),3,15);
tot_no_noise_mean_sound=squeeze(mean(tot_no_noise_mean_sound,2));
evoked_no_noise_mean_sound=reshape(evoked_no_noise_mean,length(freq),3,15);
evoked_no_noise_mean_sound=squeeze(mean(evoked_no_noise_mean_sound,2));

figure;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,3))); 
hold on;
plot(freq(1:42),squeeze(tot_no_noise_mean_sound(1:42,3)));
legend('evoked power without noise','total power without noise');
title('Mean over channels, subjects, consonants');

figure;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,1))); %frequencies 1.11 to 10 Hz
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,2))); 
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,3))); 
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,4))); 
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,5)));
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,6))); 
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,7))); 
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,8))); 
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,9))); 
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,10))); 
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,11)));
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,12))); 
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,13))); 
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,14))); 
hold on;
plot(freq(1:42),squeeze(evoked_no_noise_mean_sound(1:42,15))); 
legend('Vowels','B','D','G','K','P','T','M','N','S','Z','L','R','F','V');

figure;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,1))); %frequencies 3.11 to 20 Hz
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,2))); 
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,3))); 
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,4))); 
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,5)));
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,6))); 
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,7))); 
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,8))); 
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,9))); 
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,10))); 
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,11)));
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,12))); 
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,13))); 
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,14))); 
hold on;
plot(freq(11:87),squeeze(evoked_no_noise_mean_sound(11:87,15))); 
legend('Vowels','B','D','G','K','P','T','M','N','S','Z','L','R','F','V');

figure;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,1)));
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,2))); 
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,3))); 
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,4))); 
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,5)));
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,6))); 
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,7))); 
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,8))); 
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,9))); 
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,10))); 
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,11)));
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,12))); 
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,13))); 
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,14))); 
hold on;
plot(freq,squeeze(evoked_no_noise_mean_sound(:,15))); 
legend('Vowels','B','D','G','K','P','T','M','N','S','Z','L','R','F','V');

a=find(freq==4);
b=find(freq==8);

sounds='Vbdgkptmnszlrfv';
sounds=sounds';
sounds2 = cellstr(sounds);

%total power without noise
tot_pow4_2=squeeze(total_without_noise(:,:,a,:));
tot_pow8_2=squeeze(total_without_noise(:,:,b,:));

tot_pow4_2=squeeze(mean(tot_pow4_2,2));
tot_pow4_2=tot_pow4_2';
tot_pow8_2=squeeze(mean(tot_pow8_2,2));
tot_pow8_2=tot_pow8_2';

n=3;
totpow4_2=arrayfun(@(i) mean(tot_pow4_2(i:i+n-1,:)),1:n:size(tot_pow4_2,1),'UniformOutput',false)';
totpow4_2=cell2mat(totpow4_2);

totpow8_2=arrayfun(@(i) mean(tot_pow8_2(i:i+n-1,:)),1:n:size(tot_pow8_2,1),'UniformOutput',false)';
totpow8_2=cell2mat(totpow8_2);

sdtotpow4_2=std(totpow4_2,[],2);
semtotpow4_2=sdtotpow4_2./sqrt(size(totpow4_2,2));

sdtotpow8_2=std(totpow8_2,[],2);
semtotpow8_2=sdtotpow8_2./sqrt(size(totpow8_2,2));

meantotpow4_2=mean(totpow4_2,2);
meantotpow8_2=mean(totpow8_2,2);


figure;
scatter(meantotpow4_2,meantotpow8_2);
errorbar(meantotpow4_2,meantotpow8_2,semtotpow8_2,semtotpow8_2,semtotpow4_2,semtotpow4_2,'o');
text(meantotpow4_2,meantotpow8_2,sounds2,'horizontal','right','vertical','bottom');
title('Scatterplot of Total Power at 4 and 8 Hz (without noise)');
xlabel('Total Power without noise at 4 Hz');
ylabel('Total Power without noise at 8 Hz');

%evoked power without noise
evoked_pow4_2=squeeze(evoked_without_noise(:,:,a,:));
evoked_pow8_2=squeeze(evoked_without_noise(:,:,b,:));

evoked_pow4_2=squeeze(mean(evoked_pow4_2,2));
evoked_pow4_2=evoked_pow4_2';
evoked_pow8_2=squeeze(mean(evoked_pow8_2,2));
evoked_pow8_2=evoked_pow8_2';

n=3;
evokedpow4_2=arrayfun(@(i) mean(evoked_pow4_2(i:i+n-1,:)),1:n:size(evoked_pow4_2,1),'UniformOutput',false)';
evokedpow4_2=cell2mat(evokedpow4_2);

evokedpow8_2=arrayfun(@(i) mean(evoked_pow8_2(i:i+n-1,:)),1:n:size(evoked_pow8_2,1),'UniformOutput',false)';
evokedpow8_2=cell2mat(evokedpow8_2);

sdevokedpow4_2=std(evokedpow4_2,[],2);
semevokedpow4_2=sdevokedpow4_2./sqrt(size(evokedpow4_2,2));

sdevokedpow8_2=std(evokedpow8_2,[],2);
semevokedpow8_2=sdevokedpow8_2./sqrt(size(evokedpow8_2,2));

meanevokedpow4_2=mean(evokedpow4_2,2);
meanevokedpow8_2=mean(evokedpow8_2,2);

figure;
scatter(meanevokedpow4_2,meanevokedpow8_2);
errorbar(meanevokedpow4_2,meanevokedpow8_2,semevokedpow8_2,semevokedpow8_2,semevokedpow4_2,semevokedpow4_2,'o');
text(meanevokedpow4_2,meanevokedpow8_2,sounds2,'horizontal','right','vertical','bottom');
title('Scatterplot of Evoked Power at 4 and 8 Hz (without noise)');
xlabel('Evoked Power without noise at 4 Hz');
ylabel('Evoked Power without noise at 8 Hz');

%scatter plot per stream
sdepnstr4=std(evoked_pow4_2,[],2);
semepnstr4=sdepnstr4./sqrt(size(evoked_pow4_2,2));

sdepnstr8=std(evoked_pow8_2,[],2);
semepnstr8=sdepnstr8./sqrt(size(evoked_pow8_2,2));

mean4all_2=mean(evoked_pow4_2,2);
mean8all_2=mean(evoked_pow8_2,2);

sounds='VVVbbbdddgggkkkppptttmmmnnnssszzzlllrrrfffvvv';
sounds=sounds';
sounds2 = cellstr(sounds);


figure;
scatter(mean4all_2,mean8all_2);
errorbar(mean4all_2,mean8all_2,semepnstr8,semepnstr8,semepnstr4,semepnstr4,'o');
text(mean4all_2,mean8all_2,sounds2,'horizontal','right','vertical','bottom');
title('Scatterplot of Evoked Power without noise at 4 and 8 Hz (stream)');
xlabel('Evoked power at 4 Hz');
ylabel('Evoked power at 8 Hz');
