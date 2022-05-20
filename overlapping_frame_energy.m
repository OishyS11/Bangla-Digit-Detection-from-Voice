function [frame_div, numberOfFrames] = overlapping_frame_energy(s,fs)

N = round(fs*.025);                        % frame size
M = round(fs*.01);                        % inter frame distance
len = length(s);
numberOfFrames = 1 + floor((len - N)/double(M));

mat = zeros(N, numberOfFrames); % vector of frame vectors
for i=1:numberOfFrames
    index = M*(i-1) + 1;
    for j=1:N
        mat(j,i) = s(index);
        index = index + 1;
    end
end
c = sum((mat).^2);
frame_div = c;
%stem(1:numberOfFrames,c);