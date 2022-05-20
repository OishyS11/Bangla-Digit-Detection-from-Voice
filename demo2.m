clc;
clear all;
close all;

features1=[];
for j = 1:10
for i=1:23
file = strcat('command',num2str(j),' (',num2str(i),').wav');
[y,fs] = audioread(file);
size_y=size(y);
if size_y(2)>1
    y=y(:,1);
end
if fs ~= 44100
    y=resample(y,44100,fs);
end
features1(i+(j-1)*23,:) = feature_cal(y,44100);
end
end

label = [1*ones(1,23)  2*ones(1,23) 3*ones(1,23) 4*ones(1,23) 5*ones(1,23) 6*ones(1,23) 7*ones(1,23) 8*ones(1,23) 9*ones(1,23) 0*ones(1,23)];
label = label';
F = [features1 label];
save('feature_one.mat','F');
F= array2table(F);
[trainedClassifier, validationAccuracy] = trainClassifier(F)
save('trainedClassifier1.mat','trainedClassifier','validationAccuracy');