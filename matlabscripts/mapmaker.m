function [stageone,stagetwo,stagethree,stagefour,stagefive,stageout,stageoutmap] = mapmaker(rea,ima)
mapone  = [];
maptwo  = [];
mapthree= [];
mapfour = [];
mapfive = [];
mapout  = [];

c = complex(rea,ima);
[mapone,maptwo,mapthree,mapfour,mapfive,mapout] = fftsixfour(c);


a = real(mapone);
b = imag(mapone);

d = fi(a,1,16,8);
e = fi(b,1,16,8);
stageonemap = complex(d,e);

d = fi(real(maptwo),1,16,8);
e = fi(imag(maptwo),1,16,8);
stagetwomap = complex(d,e);

d = fi(real(mapthree),1,16,8);
e = fi(imag(mapthree),1,16,8);
stagethreemap = complex(d,e);

d = fi(real(mapfour),1,16,8);
e = fi(imag(mapfour),1,16,8);
stagefourmap = complex(d,e);

d = fi(real(mapfive),1,16,8);
e = fi(imag(mapfive),1,16,8);
stagefivemap = complex(d,e);

d = fi(real(mapout),1,16,8);
e = fi(imag(mapout),1,16,8);
stageoutmap = complex(d,e);

stageone   = memmap(stageonemap);
stagetwo   = memmap(stagetwomap);
stagethree = memmap(stagethreemap);
stagefour  = memmap(stagefourmap);
stagefive  = memmap(stagefivemap);
stageout   = memmap(stageoutmap);
end