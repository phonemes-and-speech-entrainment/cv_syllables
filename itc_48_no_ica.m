clearvars;
load('Itc_per_stream.mat');
n=4500;
Fs=1000;
freq=0:Fs/n:Fs/2;
freq=freq(5:226);

a=find(freq==12);
b=find(freq==16);

Itc4=squeeze(itc(:,:,a,:));
Itc8=squeeze(itc(:,:,b,:));

Itc4=squeeze(mean(Itc4,2));
Itc4=Itc4';
Itc8=squeeze(mean(Itc8,2));
Itc8=Itc8';

n=3;
meanitc4=arrayfun(@(i) mean(Itc4(i:i+n-1,:)),1:n:size(Itc4,1),'UniformOutput',false)';
meanitc4=cell2mat(meanitc4);

meanitc8=arrayfun(@(i) mean(Itc8(i:i+n-1,:)),1:n:size(Itc8,1),'UniformOutput',false)';
meanitc8=cell2mat(meanitc8);

sditc4=std(meanitc4,[],2);
sem4=sditc4./sqrt(size(meanitc4,2));

sditc8=std(meanitc8,[],2);
sem8=sditc8./sqrt(size(meanitc8,2));

mean4=mean(meanitc4,2);
mean8=mean(meanitc8,2);

a='Vbdgkptmnszlrfv';
a=a';
b = cellstr(a);
dx=0.01; dy=0.01;


figure;
scatter(mean4,mean8);
errorbar(mean4,mean8,sem8,sem8,sem4,sem4,'o');
text(mean4,mean8,b,'horizontal','right','vertical','bottom');
title('Scatterplot of Itc at 4 and 8 Hz');
xlabel('Itc at 4 Hz');
ylabel('Itc at 8 Hz');

%{
mean4=meanitc4';
mean8=meanitc8';
p1=anova1(mean4);
p2=anova1(mean8);
%}


%scatter plot per stream
sditcstream4=std(Itc4,[],2);
semitcstr4=sditcstream4./sqrt(size(Itc4,2));

sditcstream8=std(Itc8,[],2);
semitcstr8=sditcstream8./sqrt(size(Itc8,2));

mean4all_2=mean(Itc4,2);
mean8all_2=mean(Itc8,2);

sounds='VVVbbbdddgggkkkppptttmmmnnnssszzzlllrrrfffvvv';
sounds=sounds';
sounds2 = cellstr(sounds);


figure;
scatter(mean4all_2,mean8all_2);
errorbar(mean4all_2,mean8all_2,semitcstr8,semitcstr8,semitcstr4,semitcstr4,'o');
text(mean4all_2,mean8all_2,sounds2,'horizontal','right','vertical','bottom');
title('Scatterplot of ITC at 4 and 8 Hz (stream)');
xlabel('ITC at 4 Hz');
ylabel('ITC at 8 Hz');


meanitc=squeeze(mean(mean(itc,2)));
meanitc=meanitc';

meanitc_cond=arrayfun(@(i) mean(meanitc(i:i+n-1,:)),1:n:size(meanitc,1),'UniformOutput',false)';
meanitc_cond=cell2mat(meanitc_cond);


figure;
hold on;
for i=1:size(meanitc_cond,1)
    plot(freq(1:132),meanitc_cond(i,1:132));
end
hold off;
title('ITC per condition');
xlabel('Frequency, Hz');
ylabel('ITC');
legend('Vowel','B','D','G','K','P','T','M','N','S','Z','L','R','F','V');


%fprintf('standard error of itc at 4 hz per cond is \n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n',sem4);
%fprintf('standard error of itc at 8 hz per cond is \n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n',sem8);
%fprintf('mean standard error of itc at 4 hz per cond is %f\n',mean(sem4));
%fprintf('mean standard error of itc at 8 hz per cond is %f\n',mean(sem8));



