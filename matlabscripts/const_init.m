% Function to initialize the twiddle factors for a particular stage of the
% fft computation
function [constant] = const_init(k)
n = [0 8 16 24];
constant = exp(-2*pi*j*(n+k)/64);
end