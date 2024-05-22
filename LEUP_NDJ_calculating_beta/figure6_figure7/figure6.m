% Figure 6 - phase diagrams of a statistical index characterising
% populations and their calculated beta values

% SMOOTHENED OUT CONTOUR PLOTS

J0val = 200:100:1300; % along x axis
D0val = 500:100:2000; % along y axis

beta_phase_diagram(); %computes and loads all the variables we need
load('beta_phase_diagram_variables.mat');

newpoints = 100;
[Jq,Dq] = meshgrid(linspace(200,1300,newpoints), linspace(500,2000,newpoints)); % cubic interpolation

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
print('fig6__beta.eps','-depsc');
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
print('fig6__modality_index.eps','-depsc');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% representative unimodal and bimodal distributions
mygauss = @(x,mu,var) exp(-(x-mu).^2/(2*var));
x = 1:100;
figure('Position',[380,458,143,118])
plot(x,mygauss(x,25,70)+mygauss(x,75,90),'LineWidth',3,'Color','black')
ylim([0,1.1])
xticks([]); yticks([]);
title('Bimodal','interpreter','latex','FontSize',18)
print('fig6__bimodal_representative.eps','-depsc');

figure('Position',[380,458,143,118])
plot(x,mygauss(x,50,100),'LineWidth',3,'Color','black')
ylim([0,1.1])
xticks([]); yticks([]);
title('Unimodal','interpreter','latex','FontSize',18)
print('fig6__unimodal_representative.eps','-depsc');

save('fig6.mat');
