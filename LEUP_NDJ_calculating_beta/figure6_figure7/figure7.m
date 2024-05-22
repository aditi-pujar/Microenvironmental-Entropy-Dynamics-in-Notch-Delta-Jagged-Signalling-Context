% Figure 7 - Boundary of beta = 0 for Caluclated Beta phase diagrams

my_ticks = 1:19:100;

% DISCRETIZED
% BETA PHASE DIAGRAM 
figure('Position',[559,273,639,495])
imagesc(flipud(sign(beta_old_q)));
colormap parula;
%colormap winter;
%contourf(Jq,Dq,beta_old_q,50)
title('(i) Discretised $\beta$ Phase Diagram','interpreter','latex','FontSize',30);
xlabel('$J_0$','interpreter','latex','FontSize',26); ylabel('$D_0$','interpreter','latex','FontSize',28);
ax = gca;
ax.FontSize = 20;
colorbar;
xticks(my_ticks);yticks(my_ticks);
% create a cell of string entries of where ticks appear
xticklabels(strcat(string(num2cell(floor(jqplot(my_ticks))))));
yticklabels(strcat(string(num2cell(fliplr(floor(dqplot(my_ticks))))))); 
print('fig7A__discrete_beta.eps','-depsc');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODALITY INDEX PHASE DIAGRAM
figure('Position',[559,273,639,495])
imagesc(flipud(sign(modality_index_q)));
colormap parula;
%colormap winter;
%contourf(Jq,Dq,0.555555555-sbc_q,50)
title('(ii) Discretised Modality Index Phase Diagram','interpreter','latex','FontSize',30);
xlabel('$J_0$','interpreter','latex','FontSize',26); ylabel('$D_0$','interpreter','latex','FontSize',28);
ax = gca;
ax.FontSize = 20;
colorbar;
xticks(my_ticks);yticks(my_ticks);
% create a cell of string entries of where ticks appear
xticklabels(strcat(string(num2cell(floor(jqplot(my_ticks))))));
yticklabels(strcat(string(num2cell(fliplr(floor(dqplot(my_ticks))))))); 
print('fig7A__discrete_modality_index.eps','-depsc');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
my_ticks = 1:9:100;
dynamics_term_q = interp2(J0val,D0val,flipud(dynamics_term),Jq,Dq,'cubic');
% PHASE BOUNDARY PHASE DIAGRAM
figure('Position', [455,157,896,689])
imagesc(flipud(dynamics_term_q));
% contourf(Jq,Dq,dynamics_term_q,50)
set(gca,'FontSize',18);
colormap turbo
title('$\log\left|\frac{\mathbf{\nabla_X}G(\mathbf{X_n^s,Y_n^s})}{\mathbf{\nabla_Y}G(\mathbf{X_n^s,Y_n^s})}\right|$ Phase Diagram','interpreter','latex','FontSize',36);
xlabel('$J_0$','interpreter','latex','FontSize',24); ylabel('$D_0$','interpreter','latex','FontSize',24);
colorbar;

xticks(my_ticks);yticks(my_ticks);
% create a cell of string entries of where ticks appear
xticklabels(strcat(string(num2cell(floor(jqplot(my_ticks))))));
yticklabels(strcat(string(num2cell(fliplr(floor(dqplot(my_ticks))))))); 
print('fig7B__interpolated_boundary_contour.eps','-depsc');

save('fig7.mat');