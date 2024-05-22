% Figure 5 - FFTs, power spectra and radial distribution function

c = {'../Datasets/LEUP/radial/r=1/radbeta100_r1_t%d.mat', ...
    '../Datasets/LEUP/radial/r=2/radbeta100_r2_t%d.mat', ...
    '../Datasets/NDJ/control300_D0_1600_J0_700_t%d.mat', ...
    './mychessboard.mat'};

all_gvals = cell(3);
all_psvals = cell(3); 
all_fftvals = cell(3);

% LEUP variables
for i =[1,2]
    gval = zeros(5,12);
    psval = zeros(5,13);

    for t = 1:5
    load(sprintf(c{i},t),'LEUP');
    val = LEUP(:,:,end);
    val = val/(max(abs(val(:))));
    
    gval(t,:) = grandGsq(val);

    fftval = abs(fft2(val));
    fftval = fftval/(max(abs(fftval(:))));
    psval(t,:) = sqpowspec(fftval);

    end
    
    all_gvals{i} = gval;
    all_psvals{i} = psval;
    all_fftvals{i} = fftval;
end

% NDJ variable
i = 3;
 gval = zeros(5,12);
 psval = zeros(5,13);

    for t = 1:5
    load(sprintf(c{i},t),'I');
    val = I(:,:,end);
    val = val/(max(abs(val(:))));
    
    gval(t,:) = grandGsq(val);

    fftval = abs(fft2(val));
    fftval = fftval/(max(abs(fftval(:))));
    psval(t,:) = sqpowspec(fftval);

    end

    all_gvals{i} = gval;
    all_psvals{i} = psval;
    all_fftvals{i} = fftval;
% Reference Chessboard
chessboard()
load('mychessboard.mat');
save('fig5.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col = {[0 0.5 0],[0.4660 0.6740 0.1880],[0.8500 0.3250 0.0980]};
linespec = {'-',':','-'};

% plotting radial distribution functions 
figure
for j=1:3
    stdshade(all_gvals{j},0.5,col{j},1:12,linespec{j});
    hold on;
end
plot(1:12,chessboard_g,'--','LineWidth',3,'Color','black');

xlim([1,12]); ylim([0 2.5]);
xticks(); yticks();
xlabel('Radial Distance $(r)$','interpreter','latex','FontSize',22); 
ylabel('Radial Distribution Function $g(r)$','interpreter','latex','FontSize',22);
set(gca,'FontSize',18);
title('Radial Distribution Function','FontSize',24,'interpreter','latex');
legend({'$LEUP:(r,\beta)=(1,-100)$','$LEUP:(r,\beta)=(2,-100)$','$NDJ:(D_0,J_0)=(1600,700)$','Ref. Chessboard'},'Interpreter','latex')

print('fig5C.eps','-depsc');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plotting power spectrum functions
figure
for j=1:3
    stdshade(all_psvals{j},0.5,col{j},1:13,linespec{j});
    hold on;
end
plot(1:13,chessboard_ps,'--','LineWidth',3,'Color','black');

xlim([1,13]); ylim([0 inf]);
xticks(); yticks();
xlabel('Radial Distance $(r)$','interpreter','latex','FontSize',22); 
ylabel('Radial Power Spectrum $p_r(r)$','interpreter','latex','FontSize',22);
set(gca,'FontSize',18);
title('Radial Power Spectrum','FontSize',24,'Interpreter','latex');
legend({'$LEUP:(r,\beta)=(1,-100)$','$LEUP:(r,\beta)=(2,-100)$','$NDJ:(D_0,J_0)=(1600,700)$','Ref. Chessboard'},'Interpreter','latex')

print('fig5D.eps','-depsc');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plotting heatmap (r=2,\beta<0)

load(sprintf(c{2},5),'LEUP');
val = LEUP(:,:,end);
val = val/(max(abs(val(:))));

% figure
% subplot(2,1,1)
% pcolor(val)
% colorbar
% colormap('summer')
% set(gca,'clim',[-1,1])
% title('(i)','FontSize',18); yticks([]); xticks([]); 
% 
% subplot(2,1,2)
% pcolor(discretisn(val,4)-1)
% colorbar
% colormap('summer')
% set(gca,'clim',[-1,1])
% title('(ii)','FontSize',18); yticks([]); xticks([]); 
% 
% print('supp_fig4A.eps','-depsc');

figure
pcolor(val)
colorbar
colormap('summer')
ax = gca;
ax.FontSize = 20;
set(gca,'clim',[-1,1]);
yticks([]); xticks([]); 
title('$LEUP\;:\;(r,\beta)\;=\;(2,-100)$','interpreter','latex','FontSize',24)
print('fig5A.eps','-depsc');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plotting FFTs
all_colormaps = {'summer','summer',flipud('copper')};

% LEUP: (r,beta) = (1,-100)
f = figure('Position',[306, 55, 278, 278]);
pcolor(all_fftvals{1})
colorbar
ax = gca;
ax.FontSize = 18;
colormap(f,all_colormaps{1})
set(gca,'clim',[0,1])
title({['(i) $LEUP$'], ['$\mathbf{(r,\beta)=(1,-100)}$']},'interpreter','latex','FontSize',18); % title('(ii) LEUP Phenotype Heatmap','interpreter','latex','FontSize',20);
yticks([]);
xticks([]); 
print('fig5B_1.eps','-depsc');

% LEUP: (r,beta) = (2,-100)
f = figure('Position',[306, 55, 278, 278]);
pcolor(all_fftvals{2})
colorbar
ax = gca;
ax.FontSize = 18;
colormap(f,all_colormaps{2})
set(gca,'clim',[0,1])
title({['(ii) $LEUP$'], ['$\mathbf{(r,\beta)=(2,-100)}$']},'interpreter','latex','FontSize',18); % title('(ii) LEUP Phenotype Heatmap','interpreter','latex','FontSize',20);
yticks([]);
xticks([]); 
print('fig5B_2.eps','-depsc');

% NDJ: (D0,J0) = (1600,700)
f = figure('Position',[306, 55, 278, 278]);
pcolor(all_fftvals{3})
colorbar
ax = gca;
ax.FontSize = 18;
colormap(flipud(copper))
set(gca,'clim',[0,1])
title({['(iii) $NDJ$'], ['$\mathbf{(D_0,J_0)=(1600,700)}$']},'interpreter','latex','FontSize',18); % title('(ii) LEUP Phenotype Heatmap','interpreter','latex','FontSize',20);
yticks([]);
xticks([]); 
print('fig5B_3.eps','-depsc');





