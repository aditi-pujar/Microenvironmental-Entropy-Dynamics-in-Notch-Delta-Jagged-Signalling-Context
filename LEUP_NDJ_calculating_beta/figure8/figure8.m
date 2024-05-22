D0val = [1600,600,1700,1800,1700,1300];
J0val = [700,1200,1000,600,300,400];
I0 = 1500;
ind_title = {['(iii)'],['(vi)'],['(iv)'],['(ii)'],['(i)'],['(v)']};

gvals = zeros(length(D0val),12);
psvals = zeros(length(D0val),13);

correln_chessboard_g = zeros(length(D0val),1);
correln_random_g = zeros(length(D0val),1);
correln_chessboard_ps = zeros(length(D0val),1);
correln_random_ps = zeros(length(D0val),1);
% chessboard()
load('mychessboard.mat');


for i =1:length(D0val)
    %load files (D0,J0)
    D0 = D0val(i); J0 = J0val(i);
    filename = strcat('./../Datasets/lat_D0_',num2str(D0),'_J0_',num2str(J0),'.mat');
    load(filename,'I');
    If = I(:,:,end);

    If_discretised = (If)./(1400); % min-max normalisation
    
    figure('Position', [494,446,752,291])
    sgtitle(ind_title{i},'interpreter','latex','FontSize',24)
    % heatmap of NICD
        subplot(1,2,1)
        pcolor(If_discretised)
        colorbar
        colormap('parula')
        ax = gca;
        ax.FontSize = 20;
        set(gca,'clim',[0,1],'xtick',[]);
        xticks([]); yticks([]); 
        title(sprintf('$(D_0,J_0)=(%d,%d)$',D0,J0),'interpreter','latex','FontSize',24)
    
    % KDE of populations
        data = If_discretised;
        n = 2^5;
        [bandwidth,density,xmesh,cdf]=kde(data,n,-1,1);
        
        subplot(1,2,2)
        a = area(xmesh,density);
        a.FaceAlpha = 0.4;
        a.LineWidth = 2;
        a.FaceColor = [0 0.4470 0.7410]; %[0.8500 0.3250 0.0980];
        a.EdgeColor = [0 0.4470 0.7410]; %[0.8500 0.3250 0.0980];
    
        ax = gca;
        ax.XAxis.FontSize = 15;
        ax.YAxis.FontSize = 15;
        
        ylim([0 max(max(density),1)])
        xlim([-0.1 1])
        xticks = [min(xmesh), max(xmesh)];
        title(sprintf('Modality Index: %0.3f',0.55555-SarleBimodalityIndex(If_discretised(:))),'interpreter','latex','FontSize',24)
        
        print(sprintf('fig8A_%d.eps',i),'-depsc');

    % radial distribution function
      If = If_discretised; %If./I0;
      rdf = grandGsq(If);
      gvals(i,:) = rdf;
      correln_chessboard_g(i) = sum(rdf.*chessboard_g)/(norm(rdf)*norm(chessboard_g));
      correln_random_g(i) = sum(rdf.*random_g)/(norm(rdf)*norm(random_g));  

    % power spectrum
      fftval = abs(fft2(If_discretised));
      fftval = fftval/(max(abs(fftval(:))));
      psval = sqpowspec(fftval);
      psvals(i,:) = psval;
      correln_chessboard_ps(i) = sum(psval.*chessboard_ps)/(norm(psval)*norm(chessboard_ps));
      correln_random_ps(i) = sum(psval.*random_ps)/(norm(psval)*norm(random_ps));  


end


% plotting radial distribution functions 
figure('Position',[455,291,680,555])
for j=1:length(D0val)
    plot(gvals(j,:), 'LineWidth',3, 'DisplayName',sprintf('(%d,%d)',D0val(j),J0val(j)));
    hold on;
end

plot(1:12,chessboard_g,'--','LineWidth',3,'Color','black','DisplayName','Ref. Chessboard');
plot(1:12,random_g,'--','LineWidth',3,'DisplayName','Random','Color',[.7 .7 .7]);
legend();
xlim([1,12]); ylim([0 2.5]);
xticks(); yticks();
xlabel('Radial Distance $(r)$','interpreter','latex','FontSize',22); 
ylabel('Radial Distribution Function $g(r)$','interpreter','latex','FontSize',22);
set(gca,'FontSize',18);
title('Radial Distribution Function','FontSize',24,'interpreter','latex');
legend()
print('fig8B.eps','-depsc');

% plotting power spectrum 
figure('Position',[455,291,680,555])
for j=1:length(D0val)
    plot(psvals(j,:), 'LineWidth',3, 'DisplayName',sprintf('(%d,%d)',D0val(j),J0val(j)));
    hold on;
end

plot(chessboard_ps,'--','LineWidth',3,'Color','black','DisplayName','Ref. Chessboard');
plot(random_ps,'--','LineWidth',3,'DisplayName','Random','Color',[.7 .7 .7]);

legend()
xlim([1,13]); ylim([0 inf]);
xticks(); yticks();
xlabel('Radial Distance $(r)$','interpreter','latex','FontSize',22); 
ylabel('Radial Power Spectrum $p_r(r)$','interpreter','latex','FontSize',22);
set(gca,'FontSize',18);
title('Radial Power Spectrum','FontSize',24,'Interpreter','latex');

print('fig8C.eps','-depsc');

fprintf('D0\tJ0\tcorreln_chessboard_g\tcorreln_random_g\n');
for kk = 1:length(D0val)
    fprintf('%d\t%d\t%f\t\t%f\n',D0val(kk), J0val(kk),correln_chessboard_g(kk),correln_random_g(kk))
end

fprintf('\n\n\nD0\tJ0\tcorreln_chessboard_ps\tcorreln_random_ps\n');
for kk = 1:length(D0val)
    fprintf('%d\t%d\t%f\t\t%f\n',D0val(kk), J0val(kk),correln_chessboard_ps(kk),correln_random_ps(kk))
end