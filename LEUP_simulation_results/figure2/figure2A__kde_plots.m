% LEUP Simulations FIGURE 2A -- Kernel Density Estimate plots of phenotype distribution of cell populations;

%BETA=[5,25,100,250];
BETA=[1,10,100,1000];
C1 = cell(1,5);
C2 = cell(1,length(BETA));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for r = [1,5]

% positive beta
figure('Position',[100,100,560,145])
xlabel('Phenotype x');
ylabel('KDE P(x)');

if r==1
    sgtitle(strcat('(iii) $\mathbf{r = ', num2str(r),',\;\;\beta > 0}$'), 'interpreter','latex','FontSize',20)
else
    sgtitle(strcat('(iv) $\mathbf{r = ', num2str(r),',\;\;\beta > 0}$'), 'interpreter','latex','FontSize',20)
end

for index=1:length(BETA)
    for ll=1:5
    filename=sprintf('/r=%d/minuscircle_beta%d_r%d_t%d.mat',r,-BETA(index),r,ll);
        
    load(fullfile(cd,'../Datasets/LEUP/datasets/square',filename));
    LEUPval=LEUP(:,:,51);
    sample=LEUPval/max(abs(LEUPval(:)));
    C1{ll}=sample(:);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
final=cell2mat(C1);
C2{index} = final(:);

subplot(1,4,index)
    data = final(:);
    n = 2^5;
    [bandwidth,density,xmesh,cdf]=kde(data,n,-1,1);
    
    subplot(1,4,index)
    a = area(xmesh,density);
    a.FaceAlpha = 0.4;
    a.LineWidth = 2;
    a.FaceColor = [0.4660 0.6740 0.1880];
    a.EdgeColor = [0.4660 0.6740 0.1880];

    ax = gca;
    ax.XAxis.FontSize = 15;
    ax.YAxis.FontSize = 15;
    
    ylim([0 max(max(density),1)])
    xticks = [-1,0,1];
    yticks = [0,1];
    titlestr = strcat('$\mathbf{\beta= ',num2str(BETA(index)),'}$');
    title(titlestr,'interpreter','latex','FontSize',17);         
end
print(sprintf('fig2A_r%d_beta_pos.eps',r),'-depsc');
save(sprintf('fig2A_r%d_beta_pos.mat',r),"C2",'BETA','r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% negative beta

figure('Position',[100,100,560,145])

if r==1
    sgtitle(strcat('(i) $\mathbf{r = ', num2str(r),',\;\;\beta < 0}$'), 'interpreter','latex','FontSize',20)
else
    sgtitle(strcat('(ii) $\mathbf{r = ', num2str(r),',\;\;\beta <0 0}$'), 'interpreter','latex','FontSize',20)
end

xlabel('Phenotype x');
ylabel('KDE P(x)');
for index=1:length(BETA)
    for ll=1:5
    filename=sprintf('/r=%d/radbeta%d_r%d_t%d.mat',r,BETA(index),r,ll);
        
    load(fullfile(cd,'../Datasets/LEUP/radial',filename));
    LEUPval=LEUP(:,:,51);
    sample=LEUPval/max(abs(LEUPval(:)));
    C1{ll}=sample(:);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
final=cell2mat(C1);
C2{index} = final(:);

subplot(1,4,index)
    data = final(:);
    n = 2^5;
    [bandwidth,density,xmesh,cdf]=kde(data,n,-1,1);
  
    subplot(1,4,index)
    a = area(xmesh,density);
    a.FaceAlpha = 0.4;
    a.LineWidth = 2;
    a.FaceColor = [0 0.4470 0.7410];
    a.EdgeColor = [0 0.4470 0.7410];

    ax = gca;
    ax.XAxis.FontSize = 15;
    ax.YAxis.FontSize = 15;

    xticks = [-1,0,1];
    yticks = [0,1];
    ylim([0 max(max(density),1)])
    titlestr = strcat('$\mathbf{\beta= ',num2str(-BETA(index)),'}$');
    title(titlestr,'interpreter','latex','FontSize',17);         
end
print(sprintf('fig2A_r%d_beta_neg.eps',r),'-depsc');
save(sprintf('fig2A_r%d_beta_neg.mat',r),"C2",'BETA','r');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end