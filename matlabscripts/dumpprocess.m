% The purpose of this function is to take the whole memory map, and split
% the 32 bit numbers into 16 bit real and 16 bit imaginary, and translate
% it into a memory map with complex numbers
%
% Translate the output of the FFT processor into an easier to analyze
% format

function [reconmap] = dumpprocess(origmap)

for (a = 1:8)
    for (b = 1:8)
        reconmap(a,b) = splnconv(origmap(a,b));
    end
end

