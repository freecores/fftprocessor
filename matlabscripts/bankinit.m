function [] = bankinit(a,b);


% Put the real and imaginary fi objects into the memory map
bankone_r   = [a(1) a(16) a(23) a(30) a(37) a(44) a(51) a(58)];
banktwo_r   = [a(2) a(9)  a(24) a(31) a(38) a(45) a(52) a(59)];
bankthree_r = [a(3) a(10) a(17) a(32) a(39) a(46) a(53) a(60)];
bankfour_r  = [a(4) a(11) a(18) a(25) a(40) a(47) a(54) a(61)];
bankfive_r  = [a(5) a(12) a(19) a(26) a(33) a(48) a(55) a(62)];
banksix_r   = [a(6) a(13) a(20) a(27) a(34) a(41) a(56) a(63)];
bankseven_r = [a(7) a(14) a(21) a(28) a(35) a(42) a(49) a(64)];
bankeight_r = [a(8) a(15) a(22) a(29) a(36) a(43) a(50) a(57)];

% reconstruct the real numbers in the memory map, for displaying on the
% screen to check our inputs
realmem = [bankone_r; banktwo_r; bankthree_r; bankfour_r; bankfive_r; banksix_r; bankseven_r; bankeight_r];

bankone_i   = [b(1) b(16) b(23) b(30) b(37) b(44) b(51) b(58)];
banktwo_i   = [b(2) b(9)  b(24) b(31) b(38) b(45) b(52) b(59)];
bankthree_i = [b(3) b(10) b(17) b(32) b(39) b(46) b(53) b(60)];
bankfour_i  = [b(4) b(11) b(18) b(25) b(40) b(47) b(54) b(61)];
bankfive_i  = [b(5) b(12) b(19) b(26) b(33) b(48) b(55) b(62)];
banksix_i   = [b(6) b(13) b(20) b(27) b(34) b(41) b(56) b(63)];
bankseven_i = [b(7) b(14) b(21) b(28) b(35) b(42) b(49) b(64)];
bankeight_i = [b(8) b(15) b(22) b(29) b(36) b(43) b(50) b(57)];


%reconstruct the imaginary numbers in the memory map for displaying on the
%screen to check our inputs
imagmem = [bankone_i; banktwo_i; bankthree_i; bankfour_i; bankfive_i; banksix_i; bankseven_i; bankeight_i];

complex(realmem',imagmem')


% write the concatenated values to the memory files.
temp = [hex(bankone_r(1)) hex(bankone_i(1))];
dlmwrite('mem0.in',temp,'');
temp = [hex(banktwo_r(1))   hex(banktwo_i(1))];
dlmwrite('mem1.in',temp,'');
temp = [hex(bankthree_r(1)) hex(bankthree_i(1))];
dlmwrite('mem2.in',temp,'');
temp = [hex(bankfour_r(1))  hex(bankfour_i(1))];
dlmwrite('mem3.in',temp,'');
temp = [hex(bankfive_r(1))  hex(bankfive_i(1))];
dlmwrite('mem4.in',temp,'');
temp = [hex(banksix_r(1))   hex(banksix_i(1))];
dlmwrite('mem5.in',temp,'');
temp = [hex(bankseven_r(1)) hex(bankseven_i(1))];
dlmwrite('mem6.in',temp,'');
temp = [hex(bankeight_r(1)) hex(bankeight_i(1))];
dlmwrite('mem7.in',temp,'');

% concatenate the hex values of the real and imaginary fi objects
for (i = 2:8)
    temp = [hex(bankone_r(i)) hex(bankone_i(i))];
    dlmwrite('mem0.in',temp,'-append','delimiter','');
    temp = [hex(banktwo_r(i))   hex(banktwo_i(i))];
    dlmwrite('mem1.in',temp,'-append','delimiter','');
    temp = [hex(bankthree_r(i)) hex(bankthree_i(i))];
    dlmwrite('mem2.in',temp,'-append','delimiter','');
    temp = [hex(bankfour_r(i))  hex(bankfour_i(i))];
    dlmwrite('mem3.in',temp,'-append','delimiter','');
    temp = [hex(bankfive_r(i))  hex(bankfive_i(i))];
    dlmwrite('mem4.in',temp,'-append','delimiter','');
    temp = [hex(banksix_r(i))   hex(banksix_i(i))];
    dlmwrite('mem5.in',temp,'-append','delimiter','');
    temp = [hex(bankseven_r(i)) hex(bankseven_i(i))];
    dlmwrite('mem6.in',temp,'-append','delimiter','');
    temp = [hex(bankeight_r(i)) hex(bankeight_i(i))];
    dlmwrite('mem7.in',temp,'-append','delimiter','');
end
end