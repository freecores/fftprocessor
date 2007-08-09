% Test script to initialize memory deck for FFT processor, and compare
% validate the output of the FFT processor, against MATLAB's FFT.

ran = input(' Do you want to have a random set of data generated (1 = yes, 0 = no)? ');

if (ran)
    % generate real and imaginary random numbers
    rea = rand(1,64)*4;
    imag = rand(1,64)*4;
end

if(~ran)
    rea = input(' Enter the real numbers: ');
    imag = input(' Enter the imaginary numbers: ');
end

% Create the fi objects
a = fi(rea,1,16,8);
b = fi(imag,1,16,8);

% Construct memory maps for each stage for debugging modelsim. 
[stageone,stagetwo,stagethree,stagefour,stagefive,stageout,stageoutunmap] = mapmaker(a,b);

% Initialize the memory banks for providing input to modelsim.(creates the
% modelsim input decks)
bankinit(a,b);

display(stageone.hex);
r = input(' Press a key for stage two');
display(stagetwo.hex);
r = input(' Press a key for stage three');
display(stagethree.hex);
r = input(' Press a key for stage four');
display(stagefour.hex);
r = input(' Press a key for stage five');
display(stagefive.hex);
r = input(' Press a key for stage six');
display(stageout.hex);

% Wait for the FFT to complete
inp = input(' Press a key when FFT is complete ');


% Read all the strings from the memory banks
bankone   = uint32(dlmread('mem0.out'));
banktwo   = uint32(dlmread('mem1.out'));
bankthree = uint32(dlmread('mem2.out'));
bankfour  = uint32(dlmread('mem3.out'));
bankfive  = uint32(dlmread('mem4.out'));
banksix   = uint32(dlmread('mem5.out'));
bankseven = uint32(dlmread('mem6.out'));
bankeight = uint32(dlmread('mem7.out'));

% Make the 8x8 memory map from the banks
origmap = [bankone(:,1) banktwo(:,1) bankthree(:,1) bankfour(:,1) bankfive(:,1) banksix(:,1) bankseven(:,1) bankeight(:,1)]

% Convert everything back to complex numbers
reconmap = dumpprocess(origmap);

% Get a 1d vector holding bit reversed output of the fft
fftvec = givevec(reconmap);
fftvecsim = givevec(stageout.double);

% reorder the output vector to reshuffle the bit reversed output.
fftout = reorder(fftvec);
fftsim = reorder(fftvecsim);


