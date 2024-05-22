% SMOOTHENED OUT CONTOUR PLOTS

J0val = 200:100:1300; % along x axis
D0val = 500:100:2000; % along y axis
newpoints = 100;
[Jq,Dq] = meshgrid(linspace(200,1300,newpoints), linspace(500,2000,newpoints));

jqplot = linspace(200,1300,newpoints);
dqplot = linspace(500,2000,newpoints);
my_ticks = 1:9:100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BETA PHASE DIAGRAM 
beta_old_q = interp2(J0val,D0val,flipud(beta_old),Jq,Dq,'cubic');
figure
imagesc(flipud(beta_old_q));
colormap parula;
%colormap winter;
%contourf(Jq,Dq,beta_old_q,50)
title('(i) $\beta$ Phase Diagram','interpreter','latex','FontSize',24);
xlabel('$J_0$','interpreter','latex','FontSize',24); ylabel('$D_0$','interpreter','latex','FontSize',24);
colorbar;
xticks(my_ticks);yticks(my_ticks);
% create a cell of string entries of where ticks appear
xticklabels(strcat(string(num2cell(floor(jqplot(my_ticks))))));
yticklabels(strcat(string(num2cell(fliplr(floor(dqplot(my_ticks))))))); 
print('./plots/interpolated_beta.eps','-depsc');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODALITY INDEX PHASE DIAGRAM
modality_index_q = interp2(J0val,D0val,flipud(modality_index),Jq,Dq,'cubic');
figure
imagesc(flipud(modality_index_q));
colormap parula;
%colormap winter;
%contourf(Jq,Dq,modality_index_q,50)
title('(ii) Modality Index Phase Diagram','interpreter','latex','FontSize',24);
xlabel('$J_0$','interpreter','latex','FontSize',24); ylabel('$D_0$','interpreter','latex','FontSize',24);
colorbar;
xticks(my_ticks);yticks(my_ticks);
% create a cell of string entries of where ticks appear
xticklabels(strcat(string(num2cell(floor(jqplot(my_ticks))))));
yticklabels(strcat(string(num2cell(fliplr(floor(dqplot(my_ticks))))))); 
print('./plots/interpolated_sbc.eps','-depsc');

% PHASE BOUNDARY PHASE DIAGRAM
dynamics_term_q = interp2(J0val,D0val,flipud(dynamics_term),Jq,Dq,'cubic');
figure
imagesc(flipud(dynamics_term_q));
colormap turbo;
% colormap autumn;
%contourf(Jq,Dq,dynamics_term_q,[0 0],50)
title('$\log(\frac{\nabla_XG}{\nabla_YG})$ Phase Diagram','interpreter','latex','FontSize',24);
xlabel('$J_0$','interpreter','latex','FontSize',24); ylabel('$D_0$','interpreter','latex','FontSize',24);
colorbar;
xticks(my_ticks);yticks(my_ticks);
% create a cell of string entries of where ticks appear
xticklabels(strcat(string(num2cell(floor(jqplot(my_ticks))))));
yticklabels(strcat(string(num2cell(fliplr(floor(dqplot(my_ticks))))))); 
print('./plots/interpolated_boundary.eps','-depsc');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
print('./plots/interpolated_discrete_beta.eps','-depsc');
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
print('./plots/interpolated_discrete_sbc.eps','-depsc');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
print('./plots/interpolated_boundary_contour.eps','-depsc');
