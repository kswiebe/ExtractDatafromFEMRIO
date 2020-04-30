% Prepare data for climate policies, employment and poverty

# Get FEMRIO data
# from FEMRIOv1_EXIOfuturesIEAETP.zip 
# available at Wiebe KS, Bjelle EL, Toebben J, Wood R (2018) 
# Code and data for FEMRIO version 1.0 EXIOfuturesIEAETP. Zenodo Ind Ecol
# Sustain Res Community. https://doi.org/10.5281/zenodo.1342557

# 10.12.2019
# KSW kirsten.wiebe@sintef.no



datapath = 'FEMRIOv1_EXIOfuturesIEAETP\futures\'
% load EXIOhist for 2014
load([datapath,'6degrees\final_IOT_2030_ixi.mat'])
IOT6DS = IO;
load([datapath,'2degrees\final_IOT_2030_ixi.mat'])
IOT2DS = IO;
load([datapath,'EXIOhist\final_IOT_2014_ixi.mat'])
# i.e. 2014 is IO

nreg = 49;
nind = 163;
nfd = 7;

% 3 Compensation of employees; wages, salaries, & employers social contributions: Low-skilled
% 4 Compensation of employees; wages, salaries, & employers social contributions: Medium-skilled
% 5 Compensation of employees; wages, salaries, & employers social contributions: High-skilled
% 10 Employment: Low-skilled male
% 11 Employment: Low-skilled female
% 12 Employment: Medium-skilled male
% 13 Employment: Medium-skilled female
% 14 Employment: High-skilled male
% 15 Employment: High-skilled female
% 16 Employment hours: Low-skilled male
% 17 Employment hours: Low-skilled female
% 18 Employment hours: Medium-skilled male
% 19 Employment hours: Medium-skilled female
% 20 Employment hours: High-skilled male
% 21 Employment hours: High-skilled female
% 22 Employment: Vulnerable employment
% 23 Employment hours: Vulnerable employment
sel = [3:5,10:23];
seln = size(sel)(2);
size(IOT2DS.x)

Fsel6DS = zeros(nind*nreg,seln);
Fsel2DS = zeros(nind*nreg,seln);
Fselhis = zeros(nind*nreg,seln);
#X6DS = zeros(nreg*nfd,1);
#X2DS = zeros(nreg*nfd,1);
#Xhis = zeros(nreg*nfd,1);
  for s = sel
    Fsel6DS(:,s) = transpose(IOT6DS.S(s,:)) .* IOT6DS.x;
    Fsel2DS(:,s) = transpose(IOT2DS.S(s,:)) .* IOT2DS.x;
    Fselhis(:,s) = transpose(IO.S(s,:)) .* IO.x;
  end

csvwrite('Fsel6DS.csv',Fsel6DS);
csvwrite('Fsel2DS.csv',Fsel2DS);
csvwrite('Fselhis.csv',Fselhis);
csvwrite('X6DS.csv',IOT6DS.x);
csvwrite('X2DS.csv',IOT2DS.x);
csvwrite('Xhis.csv',IO.x);


csvwrite('CO26DS.csv',transpose(IOT6DS.S(24,:)));
csvwrite('CO22DS.csv',transpose(IOT2DS.S(24,:)));
csvwrite('CO2his.csv',transpose(IO.S(24,:)));

csvwrite('Fselmeta.csv',meta.labsF(sel));

csvwrite('VA6DS.csv',transpose(sum(IOT6DS.V,1)));
csvwrite('VA2DS.csv',transpose(sum(IOT2DS.V,1)));
csvwrite('VAhis.csv',transpose(sum(IO.V,1)));


# materials
# domestic extraction used: char(111,:)
# domestic extraction unused: char(112,:)

test = IO.char(111,:) * IO.F;
test6DS = IO.char(111,:) * IOT6DS.F;
test2DS = IO.char(111,:) * IOT2DS.F;

ratio = test2DS./test6DS;
# Global material footprint GlobalMF
ratiosum = sum(test2DS)/sum(test6DS);

FossilFuelindex = [716:726];
MetalOresindex = [728:739];
NMMindex = [740:747];

index = FossilFuelindex;
GlobalMFfossilfuels = [sum(sum(IO.F(index,:))),sum(sum(IOT6DS.F(index,:))),sum(sum(IOT2DS.F(index,:)))];
csvwrite('GlobalMFfossilfuels.csv',GlobalMFfossilfuels)

index = MetalOresindex;
GlobalMFmetalores = [sum(sum(IO.F(index,:))),sum(sum(IOT6DS.F(index,:))),sum(sum(IOT2DS.F(index,:)))];
csvwrite('GlobalMFmetalores.csv',GlobalMFmetalores)

index = NMMindex;
GlobalMFnonmetallicmin = [sum(sum(IO.F(index,:))),sum(sum(IOT6DS.F(index,:))),sum(sum(IOT2DS.F(index,:)))];
csvwrite('GlobalMFnonmetallicmin.csv',GlobalMFnonmetallicmin)

