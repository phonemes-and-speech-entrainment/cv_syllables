close all; clearvars;clc;
load('/Volumes/KINGSTON/Itc_for_stats.mat');

%% stats
groups1 = {'Vowels4','B4','D4','G4','K4','P4','T4','M4','N4',...
           'S4','Z4','L4','R4','F4','Z4'};
groups2 = {'Sibs4','Nas4','Frics4','Rhots4','Stops4'};
groups3 = {'Sibs/Frics4','Nas/Rhots4','Stops4'};

groups4 = {'Vowels8','B8','D8','G8','K8','P8','T8','M8','N8',...
           'S8','Z8','L8','R8','F8','Z8'};
groups5 = {'Sibs8','Nas8','Frics8','Rhots8','Stops8'};
groups6 = {'Sibs/Frics8','Nas/Rhots8','Stops8'};

p1=anova1(meanitc4',groups1);
p2=anova1(meanitc8',groups4);

fprintf('The p-value of the one-way anova between all consonant groups at 4 Hz is %f\n',p1);
fprintf('The p-value of the one-way anova between all consonant groups at 8 Hz is %f\n\n',p2);

% 5 groups sibilants, fricatives, nasals, rhotics, stops
%p value for post-hoc ttests is 0.005 (10 comparisons)
sibs1_4=mean(meanitc4(10:11,:));
nas1_4=mean(meanitc4(8:9,:));
frics_4=mean(meanitc4(14:15,:));
rhots_4=mean(meanitc4(12:13,:));
stops_4=mean(meanitc4(2:7,:));


sibs1_8=mean(meanitc8(10:11,:));
nas1_8=mean(meanitc8(8:9,:));
frics_8=mean(meanitc8(14:15,:));
rhots_8=mean(meanitc8(12:13,:));
stops_8=mean(meanitc8(2:7,:));

p3=anova1([sibs1_4;nas1_4;frics_4;rhots_4;stops_4]',groups2);
p4=anova1([sibs1_8;nas1_8;frics_8;rhots_8;stops_8]',groups5);

fprintf('The p-value of the one-way anova between 5 consonant groups at 4 Hz is %f\n',p3);
fprintf('The p-value of the one-way anova between 5 consonant groups at 8 Hz is %f\n\n',p4);

fprintf('Means of each of the 5 groups at 4 Hz \n');
fprintf('Stops: %f\n', mean(stops_4));
fprintf('Nasals: %f\n', mean(nas1_4));
fprintf('Sibilants: %f\n',mean(sibs1_4));
fprintf('Rhotics: %f\n', mean(rhots_4));
fprintf('Fricatives: %f\n\n', mean(frics_4));

fprintf('Means of each of the 5 groups at 8 Hz \n');
fprintf('Stops: %f\n', mean(stops_8));
fprintf('Nasals: %f\n', mean(nas1_8));
fprintf('Sibilants: %f\n',mean(sibs1_8));
fprintf('Rhotics: %f\n', mean(rhots_8));
fprintf('Fricatives: %f\n\n', mean(frics_8));

[hsn1_4,psn1_4]=ttest(sibs1_4,nas1_4);
[hsf_4,psf_4]=ttest(sibs1_4,frics_4);
[hsr_4,psr_4]=ttest(sibs1_4,rhots_4);
[hsst1_4,psst1_4]=ttest(sibs1_4,stops_4);
[hnf_4,pnf_4]=ttest(nas1_4,frics_4);
[hnr_4,pnr_4]=ttest(nas1_4,rhots_4);
[hnst1_4,pnst1_4]=ttest(nas1_4,stops_4);
[hfr_4,pfr_4]=ttest(frics_4,rhots_4);
[hfst_4,pfst_4]=ttest(frics_4,stops_4);
[hrst_4,prst_4]=ttest(rhots_4,stops_4);

[hsn1_8,psn1_8]=ttest(sibs1_8,nas1_8);
[hsf_8,psf_8]=ttest(sibs1_8,frics_8);
[hsr_8,psr_8]=ttest(sibs1_8,rhots_8);
[hsst1_8,psst1_8]=ttest(sibs1_8,stops_8);
[hnf_8,pnf_8]=ttest(nas1_8,frics_8);
[hnr_8,pnr_8]=ttest(nas1_8,rhots_8);
[hnst1_8,pnst1_8]=ttest(nas1_8,stops_8);
[hfr_8,pfr_8]=ttest(frics_8,rhots_8);
[hfst_8,pfst_8]=ttest(frics_8,stops_8);
[hrst_8,prst_8]=ttest(rhots_8,stops_8);

fprintf('Minimum p-value of each post-hoc test when we do pairwise comparisons for 5 groups must be 0.005\n');

fprintf('The p-value of the Ttest comparing sibilants and nasals at 4 Hz is %f\n',psn1_4);
fprintf('The p-value of the Ttest comparing sibilants and fricatives at 4 Hz is %f\n',psf_4);
fprintf('The p-value of the Ttest comparing silbilants and rhotics at 4 Hz is %f\n',psr_4);
fprintf('The p-value of the Ttest comparing sibilants and stops at 4 Hz is %f\n',psst1_4);
fprintf('The p-value of the Ttest comparing nasals and fricatives at 4 Hz is %f\n',pnf_4);
fprintf('The p-value of the Ttest comparing nasals and rhotics at 4 Hz is %f\n',pnr_4);
fprintf('The p-value of the Ttest comparing nasals and stops at 4 Hz is %f\n',pnst1_4);
fprintf('The p=value of the Ttest comparing fricatives and rhotics at 4 Hz is %f\n',pfr_4);
fprintf('The p-value of the Ttest comparing fricatives and stops at 4 Hz is %f\n',pfst_4);
fprintf('The p-value of the Ttest comparing rhotics ans stops and 4 Hz is %f\n\n',prst_4);

fprintf('The p-value of the Ttest comparing sibilants and nasals at 8 Hz is %f\n',psn1_8);
fprintf('The p-value of the Ttest comparing sibilants and fricatives at 8 Hz is %f\n',psf_8);
fprintf('The p-value of the Ttest comparing silbilants and rhotics at 8 Hz is %f\n',psr_8);
fprintf('The p-value of the Ttest comparing sibilants and stops at 8 Hz is %f\n',psst1_8);
fprintf('The p-value of the Ttest comparing nasals and fricatives at 8 Hz is %f\n',pnf_8);
fprintf('The p-value of the Ttest comparing nasals and rhotics at 8 Hz is %f\n',pnr_8);
fprintf('The p-value of the Ttest comparing nasals and stops at 8 Hz is %f\n',pnst1_8);
fprintf('The p=value of the Ttest comparing fricatives and rhotics at 8 Hz is %f\n',pfr_8);
fprintf('The p-value of the Ttest comparing fricatives and stops at 8 Hz is %f\n',pfst_8);
fprintf('The p-value of the Ttest comparing rhotics ans stops and 8 Hz is %f\n\n',prst_8);


%3 groups sibilants, nasals, stops
%p value for post-hoc ttests is 0.016 (3 comparisons)

sibs2_4=mean(meanitc4([10,11,14,15],:));
nas2_4=mean(meanitc4([8,9,12,13],:));

sibs2_8=mean(meanitc8([10,11,14,15],:));
nas2_8=mean(meanitc8([8,9,12,13],:));

p5=anova1([sibs2_4;nas2_4;stops_4]',groups3);
p6=anova1([sibs2_8;nas2_8;stops_8]',groups6);

fprintf('The p-value of the one-way anova between 3 consonant groups at 4 Hz is %f\n',p5);
fprintf('The p-value of the one-way anova between 3 consonant groups at 8 Hz is %f\n\n',p6);

[hsn2_4,psn2_4]=ttest(sibs2_4,nas2_4);
[hsst2_4,psst2_4]=ttest(sibs2_4,stops_4);
[hnst2_4,pnst2_4]=ttest(nas2_4,stops_4);

[hsn2_8,psn2_8]=ttest(sibs2_8,nas2_8);
[hsst2_8,psst2_8]=ttest(sibs2_8,stops_8);
[hnst2_8,pnst2_8]=ttest(nas2_8,stops_8);

fprintf('Means of each of the 3 groups at 4 Hz \n');
fprintf('Stops: %f\n', mean(stops_4));
fprintf('Nasals/rhotics: %f\n', mean(nas2_4));
fprintf('Sibilants/fricatives: %f\n\n',mean(sibs2_4));

fprintf('Means of each of the 3 groups at 8 Hz \n');
fprintf('Stops: %f\n', mean(stops_8));
fprintf('Nasals/rhotics: %f\n', mean(nas2_8));
fprintf('Sibilants/fricatives: %f\n\n',mean(sibs2_8));

fprintf('Minimum p-value of each post-hoc test when we do pairwise comparisons for 3 groups must be 0.016\n');

fprintf('The p-value of the Ttest comparing sibilants/fricatives and nasals/rhotics at 4 Hz is %f\n',psn2_4);
fprintf('The p-value of the Ttest comparing sibilants/fricatives and stops at 4 Hz is %f\n',psst2_4);
fprintf('The p-value of the Ttest comparing nasals/rhotics and stops at 4 Hz is %f\n\n',pnst2_4);

fprintf('The p-value of the Ttest comparing sibilants/fricatives and nasals/rhotics at 8 Hz is %f\n',psn2_8);
fprintf('The p-value of the Ttest comparing sibilants/fricatives and stops at 8 Hz is %f\n',psst2_8);
fprintf('The p-value of the Ttest comparing nasals/rhotics and stops at 8 Hz is %f\n\n',pnst2_8);

% 2 groups voiced/unvoiced
voiced_4=mean(meanitc4([2,3,4,11,15],:));
unvoiced_4=mean(meanitc4([5,6,7,10,14],:));

voiced_stops_4=mean(meanitc4([2,3,4],:));
unvoiced_stops_4=mean(meanitc4([5,6,7],:));

voiced_frics_4=mean(meanitc4([11,15],:));
unvoiced_frics_4=mean(meanitc4([10,14],:));

voiced_8=mean(meanitc8([2,3,4,11,15],:));
unvoiced_8=mean(meanitc8([5,6,7,10,14],:));

voiced_stops_8=mean(meanitc8([2,3,4],:));
unvoiced_stops_8=mean(meanitc8([5,6,7],:));

voiced_frics_8=mean(meanitc8([11,15],:));
unvoiced_frics_8=mean(meanitc8([10,14],:));

fprintf('Means of each of the voiced/unvoiced groups at 4 Hz \n');
fprintf('Voiced all: %f\n', mean(voiced_4));
fprintf('Unvoiced all: %f\n', mean(unvoiced_4));
fprintf('Voiced stops: %f\n',mean(voiced_stops_4));
fprintf('Unvoiced stops: %f\n',mean(unvoiced_stops_4));
fprintf('Voiced fricatives: %f\n',mean(voiced_frics_4));
fprintf('Unvoiced fricatives: %f\n\n',mean(unvoiced_frics_4));

fprintf('Means of each of the voiced/unvoiced groups at 8 Hz \n');
fprintf('Voiced all: %f\n', mean(voiced_8));
fprintf('Unvoiced all: %f\n', mean(unvoiced_8));
fprintf('Voiced stops: %f\n',mean(voiced_stops_8));
fprintf('Unvoiced stops: %f\n',mean(unvoiced_stops_8));
fprintf('Voiced fricatives: %f\n',mean(voiced_frics_8));
fprintf('Unvoiced fricatives: %f\n\n',mean(unvoiced_frics_8));


[h1,p7]=ttest(voiced_4,unvoiced_4);
[h2,p8]=ttest(voiced_8,unvoiced_8);
[h3,p9]=ttest(voiced_stops_4,unvoiced_stops_4);
[h4,p10]=ttest(voiced_stops_8,unvoiced_stops_8);
[h5,p11]=ttest(voiced_frics_4,unvoiced_frics_4);
[h6,p12]=ttest(voiced_frics_8,unvoiced_frics_8);

fprintf('The p-value of the Ttest comparing voiced and unvoiced consonants at 4 Hz is %f\n',p7);
fprintf('The p-value of the Ttest comparing voiced and unvoiced consonants at 8 Hz is %f\n',p8)

fprintf('The p-value of the Ttest comparing voiced and unvoiced stops at 4 Hz is %f\n',p9);
fprintf('The p-value of the Ttest comparing voiced and unvoiced stops at 8 Hz is %f\n',p10);

fprintf('The p-value of the Ttest comparing voiced and unvoiced fricatives at 4 Hz is %f\n',p11);
fprintf('The p-value of the Ttest comparing voiced and unvoiced fricatives at 8 Hz is %f\n',p12);





p13=anova1(Itc4');
p14=anova1(Itc8');

fprintf('The p-value of the one-way anova between all consonant streams at 4 Hz is %f\n',p13);
fprintf('The p-value of the one-way anova between all consonant streams at 8 Hz is %f\n',p14);

