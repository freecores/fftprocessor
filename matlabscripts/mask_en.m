% Generate the enable mask matrix, to be used for multiplication, for selecting
% which constants to multiply to the output of the 1st 8 point fft.

function [enable] = mask_en();

enable(1,:) = [ 0 0 0 0 0 0 0 0];
enable(2,:) = [ 1 1 1 1 1 1 1 0];
enable(3,:) = [ 0 1 0 1 0 1 0 1];
enable(4,:) = [ 0 1 0 1 0 1 0 0];
enable(5,:) = [ 1 1 1 1 1 1 1 0];
enable(6,:) = [ 0 0 0 1 0 0 0 1];
enable(7,:) = [ 0 0 0 1 0 0 0 0];
enable(8,:) = [ 0 0 0 1 0 0 0 1];
enable(9,:) = [ 0 0 0 1 0 0 0 0];
enable(10,:)= [ 1 1 1 1 1 1 1 0];
enable(11,:)= [ 0 1 0 1 0 1 0 1];
enable(12,:)= [ 0 1 0 1 0 1 0 0];
enable(13,:)= [ 1 1 1 1 1 1 1 0];

end