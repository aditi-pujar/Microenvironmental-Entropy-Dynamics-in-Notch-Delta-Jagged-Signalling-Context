function [NEXT,LEXT] = devr(N,D,J)
NN = 24;
r=1;
NEXT=zeros(NN);
LEXT=zeros(NN);

for l=1:NN
    for m=1:NN
        [NX,NY,Nn]=RadialNeighbours(r);
        nval=0; dval=0; jval=0;
        
        for k=1:Nn
            
            nxval=mod(NX(k)+l,NN);
            if nxval==0
                nxval=NN;
            end
            
            nyval=mod(NY(k)+m,NN);
            if nyval==0
                nyval=NN;
            end

            nval=N(nxval,nyval)+nval;
            dval=D(nxval,nyval)+dval;
            jval=J(nxval,nyval)+jval;
        end
        
        next=nval/(Nn); lext=(dval+jval)/(Nn);
        NEXT(l,m)=next; LEXT(l,m)=lext;
    end
end
end