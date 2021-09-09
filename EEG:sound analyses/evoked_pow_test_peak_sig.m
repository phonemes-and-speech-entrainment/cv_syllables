%{

The evoked power at 4, 8, 12 and 16 Hz is compared with the bins 2 Hz away
from each peak, using a Wilcoxon signed rank test.

(c) Oana Cucu 2019. oana.cucu@bristol.ac.uk

%}

clearvars;
load('evoked_pow_for_stats.mat');
load('evoked_pow_bins_comp.mat');

%compare evoked at each frequency with neighbouring bins

n=size(meanevoked4_comp,3);
m=size(meanevoked4_comp,1);

p4=zeros(18,1);
p8=zeros(18,1);
p12=zeros(18,1);
p16=zeros(18,1);

meanstream4=squeeze(mean(evoked4_comp));
meanstream8=squeeze(mean(evoked8_comp));
meanstream12=squeeze(mean(evoked12_comp));
meanstream16=squeeze(mean(evoked16_comp));

for i=1:n
    [~,p]=ttest(mean(evoked_pow4),meanstream4(:,i)');
    p4(i)=p;
    [~,p]=ttest(mean(evoked_pow8),meanstream8(:,i)');
    p8(i)=p;
    [~,p]=ttest(mean(evoked_pow12),meanstream12(:,i)');
    p12(i)=p;
    [~,p]=ttest(mean(evoked_pow16),meanstream16(:,i)');
    p16(i)=p;
end


pstream4=zeros(15,18);
pstream8=zeros(15,18);
pstream12=zeros(15,18);
pstream16=zeros(15,18);
for i=1:n
    for j=1:m
        [~,p]=ttest(meanevokedpow4(j,:),meanevoked4_comp(j,:,i));
        pstream4(j,i)=p;
        [~,p]=ttest(meanevokedpow8(j,:),meanevoked8_comp(j,:,i));
        pstream8(j,i)=p;
        [~,p]=ttest(meanevokedpow12(j,:),meanevoked12_comp(j,:,i));
        pstream12(j,i)=p;
        [~,p]=ttest(meanevokedpow16(j,:),meanevoked16_comp(j,:,i));
        pstream16(j,i)=p;
    end
end
       
