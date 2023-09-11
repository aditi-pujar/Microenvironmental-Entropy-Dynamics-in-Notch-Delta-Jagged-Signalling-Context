function diag_fn(NN,r,beta,seed)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%global NN TMAX
%NN=25; %% number of points on x and y axis 
TMAX=50; %% total time
%Initial conditions:
dt=0.01; 
NoI=TMAX/dt; %number of iterations
interval=100; %no of iterations after which value of LEUP is stored
SIZE=NoI/interval; %size of LEUP array with snapshot of phenotypes stored after every "iterval" iterations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LEUP signalling
% beta=250;
% r=6;

%Initialising
rng(seed,'twister'); %setting seed=1 with generator twister for random no
LEUPinit=-1+2*rand(NN);
LEUP = zeros(NN,NN,TMAX+1);
LEUP(:,:,1)=LEUPinit;

[NX,NY,Nn]=DiagNeighbours(r);
LEUPval=LEUPinit;
LEUPnew=zeros(NN);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2D Lattice of cells
% No on cells = NN^2

for t=1:NoI
for i=1:NN
for j=1:NN
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighbors for a given radius of interaction
p2=0;
p3=0;

  %for the cell at (l,m)
            for kk=1:Nn
            NXval=mod(NX(kk)+i,NN);
            if NXval==0
                NXval=NN;
            end
            
            NYval=mod(NY(kk)+j,NN);
            if NYval==0
                NYval=NN;
            end
            
            p2=p2+LEUPval(NXval,NYval);
            p3=p3+(LEUPval(NXval,NYval))^2;
            end
%Time step
%%%%%%%%%

%Time step

LEUPnew(i,j)=leup(LEUPval(i,j),p2,p3,beta,Nn,dt);

if mod(t,interval)==0
    tau=t/interval;
    LEUP(i,j,tau+1)=LEUPnew(i,j);
end

end %for j
end %for i
LEUPval=LEUPnew;
end %for the time iterations

%folder=strcat('r=',num2str(r));
filename=strcat('diag_beta',num2str(beta),'_r',num2str(r),'_dt',num2str(dt),'_TMAX',num2str(TMAX),'_T',num2str(seed),'.mat');
save(fullfile(cd,'../../Datasets/LEUP/neighborhoods',filename),'LEUP');
end
