%%%%%%%%%%%%%%%%%%%%%%%
function [SIGMA]=LocalEnt_SqFn(f,NN,r)
SIGMA=zeros(NN,NN);
%tmp=f/max(abs(f(:)));

%I0 = 200;
%tmp = f/I0;

%tmp=f;

minval = min(f(:)); maxval=max(f(:));
tmp = (f-minval)/(maxval-minval);

%tmp=normalise(f);
f=tmp;

for l=1:NN
    for m=1:NN
        [NX,NY,Nn]=RadialNeighbours(r);
        tmp1=f(l,m); tmp2=(f(l,m))^2;
        
        for k=1:Nn
            
            nxval=mod(NX(k)+l,NN);
            if nxval==0
                nxval=NN;
            end
            
            nyval=mod(NY(k)+m,NN);
            if nyval==0
                nyval=NN;
            end

            tmp1=f(nxval,nyval)+tmp1;
            tmp2=(f(nxval,nyval))^2+tmp2;
        end
        
        meanval=tmp1/(Nn+1); sqmean=tmp2/(Nn+1);
        SIGMA(l,m)=sqmean-(meanval)^2;
    end
end

end
