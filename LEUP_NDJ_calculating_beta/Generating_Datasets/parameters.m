clear;
% Parameters
%% Signalling Paramters:%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% taken from NJP 2015:
% Degradation rate:
gamma=0.1;  gammaI=0.5;
% Transcription rate:
%N0=1400;
%D0=1600; 
%J0=1200; 
% kt and kc:
kTD=5e-5; 
kTJ=5e-5; 
kC=5e-4; 
% Threshold value of NICD:
I0=200;
% Hill function coefficient or cooperativity:
nN=2.0; nD=2.0; nJ= 5.0;nF=1.0;
% Lambdas(fold change)
lambdaN= 2.0; 
lambdaJ= 2.0; 
lambdaD= 0.0;

% Lambda for fringe:
ldf=1.0;ljf=1/ldf;

save('params.mat');