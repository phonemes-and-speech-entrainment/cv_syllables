%{

The ITC values at 4, 8, 12 and 16 Hz is compared with the bins 2 Hz away
from each peak, using a Wilcoxon signed rank test.

(c) Oana Cucu 2019. oana.cucu@bristol.ac.uk

%}

clearvars;
load('Itc_for_stats.mat');
load('Itc_bins_comp.mat');

%compare itc at each frequency with neighbouring bins

n=size(meanitc4_comp,3);
m=size(meanitc4_comp,1);

p4=zeros(18,1);
p8=zeros(18,1);
p12=zeros(18,1);
p16=zeros(18,1);

meanstream4=squeeze(mean(Itc4_comp));
meanstream8=squeeze(mean(Itc8_comp));
meanstream12=squeeze(mean(Itc12_comp));
meanstream16=squeeze(mean(Itc16_comp));

for i=1:n
    p=signrank(mean(Itc4),meanstream4(:,i)');
    p4(i)=p;
    p=signrank(mean(Itc8),meanstream8(:,i)');
    p8(i)=p;
    p=signrank(mean(Itc12),meanstream12(:,i)');
    p12(i)=p;
    p=signrank(mean(Itc16),meanstream16(:,i)');
    p16(i)=p;
end


pstream4=zeros(15,18);
pstream8=zeros(15,18);
pstream12=zeros(15,18);
pstream16=zeros(15,18);
for i=1:n
    for j=1:m
        p=signrank(meanitc4(j,:),meanitc4_comp(j,:,i));
        pstream4(j,i)=p;
        p=signrank(meanitc8(j,:),meanitc8_comp(j,:,i));
        pstream8(j,i)=p;
        p=signrank(meanitc12(j,:),meanitc12_comp(j,:,i));
        pstream12(j,i)=p;
        p=signrank(meanitc16(j,:),meanitc16_comp(j,:,i));
        pstream16(j,i)=p;
    end
end
       
cond=1:15;
cond=cond';
diff_cond4=[cond,zeros(15,1)];
count=0;

[row4,~]=find(pstream4>0.05);

for i=1:length(cond)
    for j=1:length(row4)
        if row4(j)==cond(i)
            count=count+1;
            diff_cond4(i,2)=count;
        end
    end
    count=0;
end

diff_cond8=[cond,zeros(15,1)];
count=0;

[row8,~]=find(pstream8>0.05);

for i=1:length(cond)
    for j=1:length(row8)
        if row8(j)==cond(i)
            count=count+1;
            diff_cond8(i,2)=count;
        end
    end
    count=0;
end

diff_cond12=[cond,zeros(15,1)];
count=0;

[row12,~]=find(pstream12>0.05);

for i=1:length(cond)
    for j=1:length(row12)
        if row12(j)==cond(i)
            count=count+1;
            diff_cond12(i,2)=count;
        end
    end
    count=0;
end

diff_cond16=[cond,zeros(15,1)];
count=0;

[row16,~]=find(pstream16>0.05);

for i=1:length(cond)
    for j=1:length(row16)
        if row16(j)==cond(i)
            count=count+1;
            diff_cond16(i,2)=count;
        end
    end
    count=0;
end