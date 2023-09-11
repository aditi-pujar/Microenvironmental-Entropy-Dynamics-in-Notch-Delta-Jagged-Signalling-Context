function [NX,NY,nn]=DiagNeighbours(r)

%nn=2*r*(r+1);
%NX=zeros(nn,1);
%NY=zeros(nn,1);

if (r>0)
    
k=1;

for pp=-r:r
pr = r-abs(pp);
    if pr==0
        NX(k) = pp; NY(k) = pr; tmp=k+1; k=tmp;
        continue
    end
    
    for q=-pr:pr
        if (pp==0)&&(q==0)
            continue
        end
        NX(k) = pp; NY(k) = q; tmp=k+1; k=tmp;
    end
end
nn=k-1;

else
    NX=NaN;
    NY=NaN;
    nn=0;
end

end