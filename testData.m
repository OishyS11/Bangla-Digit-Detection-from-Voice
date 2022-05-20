clc;
clear all;
close all;

load feature_one.mat;
load trainedClassifier1.mat;
trainedClassifier;
validationAccuracy

% [file,PathName] = uigetfile('*.wav;*.mp3','Pick an audio input');
% [y,fs] = audioread([PathName,file]);
fs = 44100;
myVoice = audiorecorder(fs,8,1);
myVoice.StartFcn = 'disp(''Start speaking.'')';
recordblocking(myVoice, 3);
myVoice.StopFcn = 'disp(''End of recording.'')';
disp('End of recording.')
%play(myVoice);
y = getaudiodata(myVoice);
%audiowrite('undefined.wav',myRecording,Fs);
size_y=size(y);
if size_y(2)>1
    y=y(:,1);
end
if fs ~= 44100
    y=resample(y,44100,fs);
end

features1(1,:) = feature_cal(y,44100);
F = [features1];
F= array2table(F);
yfit = trainedClassifier.predictFcn(F)