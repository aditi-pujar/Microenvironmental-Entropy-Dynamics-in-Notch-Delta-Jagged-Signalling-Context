function [avgsigma_r]=LocalSigma(LEUP,T,bit)
NN = size(LEUP,2);
%bit is meant to differentiate between square and hexagonal lattices
%bit=1 means square
%bit=2 means hexagonal

%sigma=zeros(NN,NN,T);
avgsigma_r=zeros(T,1); 

if bit==1
for time=1:T
      sigmaval_r=LocalEnt_SqFn(LEUP(:,:,time),NN,3);
             % sigma(:,:,time)= sigmaval;
              avgsigma_r(time)=mean(sigmaval_r(:));   
end

elseif bit==2
for time=1:T             
      sigmaval_r=LocalEnt_HexFn(LEUP(:,:,time),NN,3);
             % sigma(:,:,time)= sigmaval;
              avgsigma_r(time)=mean(sigmaval_r(:));               
end

end


