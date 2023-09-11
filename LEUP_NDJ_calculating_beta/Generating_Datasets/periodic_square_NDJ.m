function periodic_square_NDJ(D0_value,J0_value)
close all
tic
%% Declaring Global Variables:
 global dt gamma gammaI N0 D0 J0 kTD kTJ kC I0 nN nD nJ nF lambdaN lambdaJ lambdaD ldf ljf nn NN TMAX 
%% Signalling Paramters:%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% taken from NJP 2015:
% Degradation rate:
gamma=0.1;  gammaI=0.5;
% Transcription rate:
N0=1400;
D0=1600; 
J0=1200; 
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
%% Change the parameter for different runs:
D0=D0_value;
J0=J0_value;
%% Lattice and time settings: 
nn=4; %% number of neighbours
NN=24;
TMAX=50; %% total time
dt=0.01; % time step:
NoI=TMAX/dt; %number of iterations
interval=100; %no of iterations after which value of LEUP is stored
SIZE=NoI/interval; %size of LEUP array with snapshot of phenotypes stored after every "iterv" iterations

%% Initial conditions:%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
seed = 5;
rng(seed,'twister');
noise = 0.5;

Ninit=N0*(1+noise*(-0.5+rand(NN)));
Dinit=D0*(1+noise*(-0.5+rand(NN)));
Jinit=J0*(1+noise*(-0.5+rand(NN)));
Iinit=I0*(1+noise*(-0.5+rand(NN)));
 
% Ninit=N0*(2*rand(NN));
% Dinit=D0*(2*rand(NN));
% Jinit=J0*(2*rand(NN));
% Iinit=I0*(2*rand(NN));

% Initialise array for storing results of the time step:
Nnew=zeros(NN);Dnew=zeros(NN);Jnew=zeros(NN);Inew=zeros(NN);
% Initialisng the 3D array for storing NDJI values:
N=zeros(NN,NN,SIZE+1);D=zeros(NN,NN,SIZE+1);
J=zeros(NN,NN,SIZE+1);I=zeros(NN,NN,SIZE+1);
T=zeros(1,SIZE+1);
% Putting the first time point in arrays:
N(:,:,1)=Ninit;D(:,:,1)=Dinit;J(:,:,1)=Jinit;I(:,:,1)=Iinit;
%% Declaring the grid:     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2D Lattice of cells
% No on cells = NN^2
x=1:NN;
y=1:NN;
%[X,Y]=meshgrid(x,y);
%% Iterating over time and lattice:
for t=1:NoI
% iterating over each cell:
for i=1:NN
for j=1:NN
    %Periodic boundary conditions:
    Xn=[i-1,i,i,i+1];
    if(i==1)
        Xn(1)=NN;
    elseif(i==NN)
        Xn(4)=1;
    end
    Yn=[j,j+1,j-1,j];
    if(j==1)
        Yn(3)=NN;
    elseif(j==NN)
        Yn(2)=1;
    end
    % Initialising External quantities for a cell:
    Dext=0;Jext=0;N_D_I_ext=0;N_J_I_ext=0;
    for q=1:nn
        %Summing over nearby cells:
        N_D_I_ext=N_D_I_ext+Ninit(Xn(q),Yn(q))*Hill(Iinit(Xn(q),Yn(q)),I0,nF,ldf);
        N_J_I_ext=N_J_I_ext+Ninit(Xn(q),Yn(q))*Hill(Iinit(Xn(q),Yn(q)),I0,nF,ljf);
        Dext=Dext+Dinit(Xn(q),Yn(q));
        Jext=Jext+Jinit(Xn(q),Yn(q));
    end
    % Dividing the external values by average to bring them back to normal values
    N_D_I_ext=N_D_I_ext/nn;N_J_I_ext=N_J_I_ext/nn;Dext=Dext/nn;Jext=Jext/nn;
    

    %Time step
    [Nnew(i,j),Dnew(i,j),Jnew(i,j),Inew(i,j)]=ndj_equations(Ninit(i,j),Dinit(i,j),Jinit(i,j),Iinit(i,j),Dext,Jext,N_D_I_ext,N_J_I_ext,N0,D0,J0);

end %for j
end %for i
Ninit=Nnew;Dinit=Dnew;Jinit=Jnew;Iinit=Inew;% Updating the lattice for new time point:
%% Storing after every "step_size_for_storing" time steps:
if mod(t,interval)==0
    tau=t/interval;
    N(:,:,tau+1)=Nnew; D(:,:,tau+1)=Dnew;
    J(:,:,tau+1)=Jnew; I(:,:,tau+1)=Inew;
    T(tau+1)=t*dt;
end

end %for the time iterations

%% Save the data here:
%save(strcat(folder_name,'kTD_',num2str(kTD),'_kTJ_',num2str(kTJ),'_N0_',num2str(N0),'_D0_',num2str(D0),'_J0_',num2str(J0),'_f_',num2str(ldf),'.mat'),'N','D','I','J','T','kTD','kTJ','kC','ldf')
save(strcat('../Datasets/lat_D0_',num2str(D0),'_J0_',num2str(J0),'.mat'),'N','D','I','J','T','N0','D0','J0','I0');
toc
end