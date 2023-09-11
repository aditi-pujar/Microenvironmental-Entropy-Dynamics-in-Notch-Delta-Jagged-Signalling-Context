function [NX,NY,nn]=SquareNeighbours(r)

%nn=2*r*(r+1);
%NX=zeros(nn,1);
%NY=zeros(nn,1);

k=1;
if (r>0)
for pp=-r:r
for qq=-r:r
    if (pp==0)&&(qq==0)
    continue
    end
NX(k)=pp; NY(k)=qq; tmp=k+1; k=tmp;
end
end
nn=k-1;

else
    NX=NaN;
    NY=NaN;
    nn=0;
end

end