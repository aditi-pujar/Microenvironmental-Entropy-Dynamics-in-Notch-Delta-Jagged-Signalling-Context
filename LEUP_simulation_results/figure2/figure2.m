% Figure 2 - Comparing Notch Delta and LEUP systems

% storing paths for easy loading - cell entries are c = {LEUPfolder, LEUPfile, NDJfolder, NDJfile}
cell_bimodal = {'../Datasets/LEUP/radial', ...
                '/r=1/radbeta100_r1_t%d.mat', ...
                '../Datasets/NDJ/', ...
                'control300_D0_1600_J0_700_t%d.mat'};

cell_unimodal = {'../Datasets/LEUP/datasets/square', ...
                '/r=1/minuscircle_beta-10_r1_t%d.mat', ...
                '../Datasets/NDJ/', ...
                'control300_D0_1400_J0_1300_t%d.mat'};

beta = [-100,10]; 
i = 1;
for c = {cell_bimodal,cell_unimodal}
LEUPsigma = zeros(5,51);
NDJsigma = zeros(5,301);
for t = 1:5
    load(fullfile(cd,c{1}{1},sprintf(c{1}{2},t)),'LEUP'); % loading LEUP dataset
    LEUPsigma(t,:) = LocalSigma(LEUP,51,1);

    load(fullfile(cd,c{1}{3},sprintf(c{1}{4},t)),'I','D0','J0'); % loading NDJ dataset
    NDJsigma(t,:) = LocalSigma(I,301,1);
end

% plot NDJ heatmap
temp = I(:,:,end);
ndj_heatmap = temp/(max(abs(temp(:))));
figure 
   pcolor(ndj_heatmap)
   colorbar
   colormap("copper")
   brighten(-0.2);
   set(gca,'clim',[0,1])
   title(sprintf('(i) $NDJ:(D_0,J_0) = (%d,%d)$',D0,J0),'interpreter','latex','FontSize',22); %title('(i) NICD Heatmap (Signalling Phenotype)','interpreter','latex','FontSize',20);
   yticks([])
   xticks([]); 
   print(sprintf('fig2A%d.eps',i),'-depsc')

% plot LEUP heatmap
temp = LEUP(:,:,end);
leup_heatmap = temp/(max(abs(temp(:))));
figure
    pcolor(leup_heatmap)
    colorbar
    colormap("summer")
    set(gca,'clim',[-1,1])
    title(strcat('(ii) $LEUP:(r,\beta)=',sprintf('(1,%d)$',beta(i))),'interpreter','latex','FontSize',22); % title('(ii) LEUP Phenotype Heatmap','interpreter','latex','FontSize',20);
    yticks([])
    xticks([]); 
    print(sprintf('fig2B%d.eps',i),'-depsc')


% plot local variance over time
NDJsigma = NDJsigma(:,1:6:301); % so that both series have the same length; NDJ simulations take longer time scale to settle down
figure
    stdshade(NDJsigma,0.5,[0.8500 0.3250 0.0980],1:51,'-');
    hold on;
    stdshade(LEUPsigma,0.5,[0 0.5 0],1:51,'-');
    
    xlim([0,51]); ylim([0 inf]);
    xticks(); yticks();
    xlabel('$t (s)$','interpreter','latex','FontSize',24); 
    ylabel('Measure of Local Entropy $\langle \sigma^2\rangle_L$','interpreter','latex','FontSize',22);
    set(gca,'FontSize',18);
    title('(iii) $\langle \sigma^2\rangle_L$ Time Evolution','interpreter','latex','FontSize',22); % title('(iii) $\langle\sigma^2\rangle_L v/s t$','interpreter','latex','FontSize',20);
    
    legend(strcat('$NDJ:(D_0,J_0) = $',sprintf('(%d, %d)', D0, J0)), ...
           strcat('$LEUP:(r,\beta) = $',sprintf('(1, %d)', beta(i))), ...
           'Location','southeast','interpreter','latex');
   print(sprintf('fig2C%d.eps',i),'-depsc')
save(sprintf('fig2_%d.mat',i));
i = i+1;
end