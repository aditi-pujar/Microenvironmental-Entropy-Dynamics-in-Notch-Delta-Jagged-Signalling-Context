function circle_fn(NN,r,beta,seed)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%global NN TMAX
%NN=25; %% number of points on x and y axis 
TMAX=5; %% total time
%Initial conditions:
dt=0.001; 
NoI=TMAX/dt; %number of iterations
interval=100; %no of iterations after which value of LEUP is stored
SIZE=NoI/interval; %size of LEUP array with snapshot of phenotypes stored after every "iterval" iterations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LEUP signalling
% beta=250;
% r=6;
Nn=2*r*(r+1); % number of neighbours

%Initialising
rng(seed,'twister'); %setting seed=1 with generator twister for random no
LEUPinit=-1+2*rand(NN);
LEUP = zeros(NN,NN,TMAX+1);
LEUP(:,:,1)=LEUPinit;

LEUPval=LEUPinit;
LEUPnew=zeros(NN);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2D Lattice of cells
% No on cells = NN^2
x=1:NN;
y=1:NN;

for t=1:NoI
for i=1:NN
for j=1:NN
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighbors for a given radius of interaction
p2=0;
p3=0;

for p=-r:r
    pval=mod(i+p,NN);
    if pval==0
        pval=NN;
    end
    
    pr = r-abs(p);
    if pr==0
        p2=p2+LEUPval(pval,j);
        p3=p3+LEUPval(pval,j)^2;
        continue
    end
    for q=-pr:pr
        if (p==0)&&(q==0)
            continue
        end
        
        qval=mod(j+q,NN);
        if qval==0
            qval=NN;
        end
        
        p2=p2+LEUPval(pval,qval);
        p3=p3+LEUPval(pval,qval)^2;
    end
end
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
x=LEUP;
folder=strcat('r=',num2str(r));
filename=strcat('circle_beta',num2str(beta),'_r',num2str(r),'_t',num2str(seed),'.mat');
save(fullfile(cd,'square',folder,filename),'LEUP');
end
