function [g]=grandGsq(LEUPval)
NN=size(LEUPval,1);
LEUPn=LEUPval/max(abs(LEUPval(:)));

no_of=zeros(40,1);
cumulative=0;

for k=1:40
    tmp=0;
for l=1:NN
    for m=1:NN
        if LEUPn(l,m)<=-1+(0.1)*k
            tmp=tmp+1;
        end  
    end
end
no_of(k)=tmp-cumulative;
cumulative=tmp;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gn=zeros(NN,NN,floor(NN/2));
g=zeros(floor(NN/2),1);
thresh=0.1;

for rr=1:floor(NN/2)
[NNx1,NNy1,NNn1]= RadialNeighbours(rr);
[NNx2,NNy2,NNn2]= RadialNeighbours(rr-1);

if NNn2==0
    NNx=NNx1; NNy=NNy1; NNn=NNn1;
else

NNn=NNn1-NNn2;
NNx=zeros(NNn,1); NNy=zeros(NNn,1);

k=1;
for i=1:NNn1
    for j=1:NNn2
        if ((NNx1(i)==NNx2(j)) && (NNy1(i)==NNy2(j)))
            bitwise=0; %this is to mean that the ith neighbour is in common and therefore shouldn't be considered
            break 
        elseif j==NNn2
            bitwise=1; %this means after going over all the neighbours, this is not in common
        else
            continue
        end
    end
    
    if bitwise==1
    NNx(k)=NNx1(i); NNy(k)=NNy1(i); k=k+1;
    end
    
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ll=1:NN
    for mm=1:NN
        %classifying cell at (ll,mm)
        for kk=1:40
            if (kk==1)
            if ( LEUPn(ll,mm)<= -1+(0.1)*kk ) && ((LEUPn(ll,mm)>-1+(0.1)*(kk-1)) || (LEUPn(ll,mm)==-1))
                phen=no_of(kk); break;
            end
            else
            if ( LEUPn(ll,mm)<= -1+(0.1)*kk ) && (LEUPn(ll,mm)>-1+(0.1)*(kk-1))
                phen=no_of(kk); break;
            end
            end
        end
        
        %calculating g
        ncluster=0;
        
        for ii=1:NNn
            nxval=mod(NNx(ii)+ll,NN);
            if nxval==0
                nxval=NN;
            end
            
            nyval=mod(NNy(ii)+mm,NN);
            if nyval==0
                nyval=NN;
            end
            
            
            %if abs(LEUPn(nxval,nyval)-LEUPn(ll,mm))<= thresh
            %    ncluster = ncluster+1;
            %end   
if (LEUPn(nxval,nyval)<= -1+(0.1)*kk && (LEUPn(nxval,nyval)>-1+(0.1)*(kk-1)))||(kk==1 && LEUPn(nxval,nyval)==-1)
ncluster=ncluster+1;
end
 
        end
        gn(ll,mm,rr)=(ncluster/NNn)/(phen/(NN^2));
    end
end
end

for rrr=1:floor(NN/2)
    tmp=gn(:,:,rrr);
    g(rrr)=mean(tmp(:));
end
g = transpose(g);
end
