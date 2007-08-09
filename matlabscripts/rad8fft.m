% 8 point dft function, 3 stages. 24 butterflies.
% twiddles are reinitialized for each stage.
% In lace computation
function [x_stage1, x_stage2,x_out] = rad8fft(x_in, w)

x_stage1 = [];
x_stage2 = [];
twiddle = const_init(w);

% Stage 1 butterflies(1-5:2-6:3-7:4-8)
% In place computation
% scaled down, to avoid arithmetic overflow
x_stage1(1) =  x_in(1) + x_in(5);
x_stage1(5) = (x_in(1) - x_in(5))*twiddle(1);
x_stage1(2) =  x_in(2) + x_in(6);
x_stage1(6) = (x_in(2) - x_in(6))*twiddle(2);
x_stage1(3) =  x_in(3) + x_in(7);
x_stage1(7) = (x_in(3) - x_in(7))*twiddle(3);
x_stage1(4) =  x_in(4) + x_in(8);
x_stage1(8) = (x_in(4) - x_in(8))*twiddle(4);
x_stage1 = x_stage1/2;
% Stage 2 butterflies (inputs 1-3:2-4:5-7:6-8)
% In place computation
% scaled down to avoid arithmetic overflow
twiddle = const_init(2*w);
for (k = [1 5])
    x_stage2(k)   =  x_stage1(k)   + x_stage1(k+2);
    x_stage2(k+2) = (x_stage1(k)   - x_stage1(k+2))*twiddle(1);
    x_stage2(k+1) =  x_stage1(k+1) + x_stage1(k+3);
    x_stage2(k+3) = (x_stage1(k+1) - x_stage1(k+3))*twiddle(3);
end
x_stage2 = x_stage2/2;

% Stage 3 butterflies (inputs 1-2:3-4:5-6:7-8)
% In place computation
% scaled down to avoid arithmetic overflow
twiddle = const_init(4*w);
for (k = [1 3 5 7])
    x_out(k)   =  x_stage2(k) + x_stage2(k+1);
    x_out(k+1) = (x_stage2(k) - x_stage2(k+1))*twiddle(1);
end
x_out = x_out/2;