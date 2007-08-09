function [flipped] = flip(x)
flipped = imag(x) + j*real(x);
end