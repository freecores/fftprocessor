% This function takes a 32 bit unsigned integer and splits it into 2-16
% bit numbers and converts then into 16 bit signed fi objects, with
% fraction length of 8 bits.

function [comp] = splnconv(bignum)
re = uint16(bignum/65536);
im = uint16(rem(bignum,65536));

rea = floor(re/256); %+ rem(re,256)/256;
real = fi(rea,1,16,8);

ima = floor(im/256); %+ rem(im,256)/256;
imag = fi(ima,1,16,8);

comp = complex(re,im);