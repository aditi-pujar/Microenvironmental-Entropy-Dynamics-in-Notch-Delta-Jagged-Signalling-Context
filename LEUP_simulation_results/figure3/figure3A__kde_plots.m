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
sgtitle(strcat('$r = ', num2str(r),',\;\;\beta > 0$'), 'interpreter','latex','FontSize',20)

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
    
    ylim([0 max(max(density),1)])
    xticks = [-1,0,1];
    yticks = [0,0.5,1];
    titlestr = strcat('$\beta= $',num2str(BETA(index)));
    title(titlestr,'interpreter','latex','FontSize',15);         
end
print(sprintf('fig3A_r%d_beta_pos.eps',r),'-depsc');
save(sprintf('fig3A_r%d_beta_pos.mat',r),"C2",'BETA','r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% negative beta

figure('Position',[100,100,560,145])
sgtitle(strcat('$r = ', num2str(r),',\;\;\beta < 0$'), 'interpreter','latex','FontSize',20)
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

    xticks = [-1,0,1];
    yticks = [0,0.5,1];
    ylim([0 max(max(density),1)])
    titlestr = strcat('$\beta= ',num2str(-BETA(index)),'$');
    title(titlestr,'interpreter','latex','FontSize',15);         
end
print(sprintf('fig3A_r%d_beta_neg.eps',r),'-depsc');
save(sprintf('fig3A_r%d_beta_neg.mat',r),"C2",'BETA','r');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end