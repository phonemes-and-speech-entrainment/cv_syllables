clearvars;clc;
files = dir('*.wav');
fs=44100;

Durations = zeros(75,1);
syllable_names = {};
for i=1:length(files)
    [sound,~]=audioread(files(i).name);
    token=strtok(files(i).name,'.');
    syllable_names = [syllable_names token];
    duration_ms = length(sound)/fs*1000;
    Durations(i)=duration_ms;
end


cd('/Volumes/Seagate Portable Drive/Speech EEG/Code /Stimulus maker (Anthony)/syllables/streams/Experiment 2');

stream_files = dir('*.txt');
all_syllables = {};
for i=1:length(stream_files)
    fileID = fopen(stream_files(i).name,'r');
    formatSpec = '%c';
    stream = fscanf(fileID,formatSpec);
    stream = strsplit(stream,'\n');
    all_syllables = [all_syllables stream];
end


syllable_occurences = zeros(75,1);
for i = 1:length(syllable_names)
    cnt = 0;
    for j = 1:length(all_syllables)
        if isequal(syllable_names{i},all_syllables{j})
            cnt = cnt + 1;
        end
    end
    syllable_occurences(i) = cnt;
end


[x,i] = sort(Durations);
y = syllable_occurences(i);

%{
%[C,IA,IC] = unique(x);
d = [true; diff(x)<2; true];
idx_rep = find(d==0);


for i=1:length(idx_rep)
    y(idx_rep(i)) = y(idx_rep(i)-1) + y(idx_rep(i));
    y(idx_rep(i)-1) = 0;
end

indy = find (y==0);

y(indy) = [];
%}

Twoms = 242:2:254;
Counts = zeros(length(Twoms),1);

i=1;
j=1;
while j<=length(x)
    if i>length(Twoms)
        break
    end
    if abs(Twoms(i)-x(j))>1
        i=i+1;
    elseif abs(Twoms(i)-x(j))<1
        Counts(i)=Counts(i)+y(j);
        j=j+1;
    elseif abs(Twoms(i)-x(j))==1
        if x(j)<Twoms(i)
            Counts(i)=Counts(i)+y(j);
        else
            j=j+1;
        end
    end
end
            

%bar(C,y,200,'FaceColor','b','EdgeColor','b');
bar(Twoms,Counts,1);
title('Histogram of Syllable Durations','FontSize',14);
xlabel('Syllable Durations (ms)','FontSize',13);
ylabel('Number of Syllables','FontSize',13);
%axis([238 258 0 37]);



