% DISCRETIZED
% BETA PHASE DIAGRAM 
figure
imagesc(flipud(sign(beta_old_q)));
colormap parula;
%colormap winter;
%contourf(Jq,Dq,beta_old_q,50)
title('(i) Discretised $\beta$ Phase Diagram','interpreter','latex','FontSize',24);
xlabel('$J_0$','interpreter','latex','FontSize',24); ylabel('$D_0$','interpreter','latex','FontSize',24);
colorbar;
xticks(my_ticks);yticks(my_ticks);
% create a cell of string entries of where ticks appear
xticklabels(strcat(string(num2cell(floor(jqplot(my_ticks))))));
yticklabels(strcat(string(num2cell(fliplr(floor(dqplot(my_ticks))))))); 
print('fig8A__discrete_beta.eps','-depsc');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODALITY INDEX PHASE DIAGRAM
figure
imagesc(flipud(sign(modality_index_q)));
colormap parula;
%colormap winter;
%contourf(Jq,Dq,0.555555555-sbc_q,50)
title('(ii) Discretised Modality Index Phase Diagram','interpreter','latex','FontSize',24);
xlabel('$J_0$','interpreter','latex','FontSize',24); ylabel('$D_0$','interpreter','latex','FontSize',24);
colorbar;
xticks(my_ticks);yticks(my_ticks);
% create a cell of string entries of where ticks appear
xticklabels(strcat(string(num2cell(floor(jqplot(my_ticks))))));
yticklabels(strcat(string(num2cell(fliplr(floor(dqplot(my_ticks))))))); 
print('fig8A__discrete_modality_index.eps','-depsc');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dynamics_term_q = interp2(J0val,D0val,flipud(dynamics_term),Jq,Dq,'cubic');
% PHASE BOUNDARY PHASE DIAGRAM
figure
%imagesc(flipud(dynamics_term_q));
contourf(Jq,Dq,dynamics_term_q,50)
%colormap autumn;
colormap turbo
title('$\log(\frac{\nabla_XG}{\nabla_YG})$ Phase Diagram','interpreter','latex','FontSize',24);
xlabel('$J_0$','interpreter','latex','FontSize',24); ylabel('$D_0$','interpreter','latex','FontSize',24);
colorbar;
xticks(my_ticks);yticks(my_ticks);
% create a cell of string entries of where ticks appear
xticklabels(strcat(string(num2cell(floor(jqplot(my_ticks))))));
yticklabels(strcat(string(num2cell(fliplr(floor(dqplot(my_ticks))))))); 
print('fig8B__interpolated_boundary_contour.eps','-depsc');

save('fig8.mat');