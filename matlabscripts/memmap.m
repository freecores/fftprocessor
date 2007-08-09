function [snapshot] = memmap(a)

% Put the real and imaginary fi objects into the memory map
bankone   = [a(1) a(16) a(23) a(30) a(37) a(44) a(51) a(58)];
banktwo   = [a(2) a(9)  a(24) a(31) a(38) a(45) a(52) a(59)];
bankthree = [a(3) a(10) a(17) a(32) a(39) a(46) a(53) a(60)];
bankfour  = [a(4) a(11) a(18) a(25) a(40) a(47) a(54) a(61)];
bankfive  = [a(5) a(12) a(19) a(26) a(33) a(48) a(55) a(62)];
banksix   = [a(6) a(13) a(20) a(27) a(34) a(41) a(56) a(63)];
bankseven = [a(7) a(14) a(21) a(28) a(35) a(42) a(49) a(64)];
bankeight = [a(8) a(15) a(22) a(29) a(36) a(43) a(50) a(57)];

% reconstruct the real numbers in the memory map, for displaying on the
% screen to check our inputs
snapshot = [bankone.' banktwo.' bankthree.' bankfour.' bankfive.' banksix.' bankseven.' bankeight.'];
