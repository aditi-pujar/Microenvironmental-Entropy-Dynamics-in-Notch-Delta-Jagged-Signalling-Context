figure('Position',[433,450,851,184])
colormap pink;

color=zeros(25)+0.25;
NN=25;
color(13,13) = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
color=zeros(25)+0.25;
color(13,13) = 1;
[NX,NY,nn]=SquareNeighbours(9);
for i=1:nn
    nx=NX(i);
    if nx~=NN
        nx = mod(13+nx,NN);
    end
    
    ny=NY(i);
    if ny~=NN
        ny = mod(13+ny,NN);
    end
    color(nx,ny)=0.5;
end

subplot(1,3,1)
pcolor(color);
colorbar
set(gca,'clim',[0,1])
xticklabels([]); yticklabels([]);
title('(i) Moore','interpreter','latex','FontSize',20)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
color=zeros(25)+0.25;
color(13,13) = 1;
[NX,NY,nn]=DiagNeighbours(9);
for i=1:nn
    nx=NX(i);
    if nx~=NN
        nx = mod(13+nx,NN);
    end
    
    ny=NY(i);
    if ny~=NN
        ny = mod(13+ny,NN);
    end
    color(nx,ny)=0.5;
end

subplot(1,3,2)
pcolor(color); 
colorbar
set(gca,'clim',[0,1])
xticklabels([]); yticklabels([]);
title('(ii) Von Neumann','interpreter','latex','FontSize',20)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%radial
[NX,NY,nn]=RadialNeighbours(9);
for i=1:nn
    nx=NX(i);
    if nx~=NN
        nx = mod(13+nx,NN);
    end
    
    ny=NY(i);
    if ny~=NN
        ny = mod(13+ny,NN);
    end
    color(nx,ny)=0.5;
end


subplot(1,3,3)
pcolor(color);
colorbar
set(gca,'clim',[0,1])
xticklabels([]); yticklabels([]);
title('(iii) Radial','interpreter','latex','FontSize',20)

save('supp_figure9A.mat');
print('supp_fig9A.eps','-depsc');
