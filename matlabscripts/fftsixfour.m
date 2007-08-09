% 64 point fft function takes a 64 point vector and provides the fft
% It uses rad8fft to do break the fft down into chunks 
% of 8 point butterfly computations.
% All computations are in place, and the rad8 fft outputs are scaled down
% There is a reorder function at the end to shuffle back the bit reversed
% ordered output back into normal order
function [stage_one,stage_two,stage_three,stage_four,stage_five,sixtyfour_out] = fftsixfour(sixtyfour_in)
stage_one     = [];
stage_two     = [];
stage_three   = [];
stage_four    = [];
stage_five    = [];
sixtyfour_out = [];

l = linspace(1,57,8);

% First stage rad 8 fft, spacing 8 points.
for (k = 0:7) 
    [stage_one(k+l) stage_two(k+l) stage_three(k+l)] = (rad8fft(sixtyfour_in(k+l),k));   
end


% Second stage rad 8 fft, no spacing, 8 - 8 point blocks.
for (k = 0:7)
      [stage_four(8*k+1:8*(k+1)),stage_five(8*k+1:8*(k+1)),sixtyfour_out(8*k+1:8*(k+1))]= (rad8fft(stage_three(8*k+1:8*(k+1)),0));
end

end