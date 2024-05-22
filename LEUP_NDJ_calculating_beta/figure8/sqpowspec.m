function [powerspectrum]=sqpowspec(sample)
NN=size(sample,1);
sample = sample/(max(abs(sample(:))));
powerspectrum=zeros(floor(NN/2)+1,1);
powerspectrum(1)=sample(13,13);

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
    NNx(k)=NNx1(i); NNy(k)=NNy1(i); k=k+1; %colour(NNx(k),NNy(k))=1;
    end
    
end
end

rval=0;
ll=13; mm=13;    

        for ii=1:NNn
            nxval=mod(NNx(ii)+ll,NN);
            if nxval==0
                nxval=NN;
            end
            
            nyval=mod(NNy(ii)+mm,NN);
            if nyval==0
                nyval=NN;
            end
            tmp=rval+sample(nxval,nyval);  
            rval=tmp;
        end

powerspectrum(rr+1)=rval/NNn;
end

powerspectrum = transpose(powerspectrum);