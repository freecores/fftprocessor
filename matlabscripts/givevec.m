% The purpose is this function is to take the staggered 8x8 memory map for the fft
% and give a vector (length = 64), which is the bit reversed FFT output.

function [fftvec] = givevec(reconmap)

fftvec = reconmap(1,:);
for (a = 2:8)
    fftvec = [fftvec reconmap(a,a:8) reconmap(a,1:a-1)];
end