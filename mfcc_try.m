function ff = mfcc_try(p,fs)
mm = mfcc(p,fs);
mf = mean(mm,2); cf = cov(mm');
ff = mf;
for i=0:(size(mm,1)-1)
  ff = [ff;diag(cf,i)];
end
ff = ff(1:15,1);
ff = ff';
end