function feature_fun = feature_cal(y,fs)

%% feature1 mfcc coefficient
p = endpointdetectioncode(y,44100);
p = [p zeros(1,length(y)-length(p))];
p = p';
mm = mfcc(p,44100);
mm = mm';
size_m = size(mm);
size_re = size_m(1) * size_m(2);
mfcc_coeff = reshape(mm,[1,size_re]);
mfcc_coeff = mfcc_coeff(1,10:400);
mfcc1 = mfcc_try(p,fs);

%% feature2 lpc coefficient
x=resample(p,10000,fs);
x1 = x.*hamming(length(x));
ncoeff=12;
preemph = [1 0.63];
x1 = filter(1,preemph,x1);
a = lpc(x1,ncoeff);
[h,f]=freqz(1,a,512,10000);
lpc_coeff = 20*log10(abs(h)+eps);
lpc_coeff = lpc_coeff';

%% feature3 PSD
psd = pyulear(p,12,512,44100);
psd= psd';
psd = psd(1,1:100);

%% feature4 overlapping energy spectrum
[frame_div, numberOfFrames] = overlapping_frame_energy(p,fs);
frame_div = frame_div(1,10:60);
%plot(1:numberOfFrames, frame_div);
%p1 = polyfit(1:numberOfFrames, frame_div,2);
%q1 = size(p1);

%%
feature_fun = [mfcc_coeff mfcc1 frame_div lpc_coeff]; %psd];
end