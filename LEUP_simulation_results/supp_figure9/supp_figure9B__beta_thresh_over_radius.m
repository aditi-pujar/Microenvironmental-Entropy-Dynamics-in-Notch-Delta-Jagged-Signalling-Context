radial_bc = zeros(3,9);
square_bc = zeros(3,9);
diagonal_bc = zeros(3,9);

for t = [1,2,3]
    square_bc(t,:) = my_table_fn(SBC_table(t,1));
    diagonal_bc(t,:) = my_table_fn(SBC_table(t,2));
    radial_bc(t,:) = my_table_fn(SBC_table(t,3));
end

rx = 2:10;
nx_rad = [12,36,56,96,128,184,228,300,356];
nx_sq = [24,48,80,120,168,224,288,380,440];
nx_diag = [12,24,40,60,84,112,144,180,220];

save('supp_fig9B.mat');

figure
stdshade(log(square_bc),0.5,[0.4940 0.1840 0.5560],rx,'-'); hold on;
stdshade(log(diagonal_bc),0.5,[0.6350 0.0780 0.1840],rx,'-'); hold on;
stdshade(log(radial_bc),0.5,[0.9290 0.6940 0.1250],rx,'-');
xlabel('Radial Distance $(r)$','interpreter','latex','FontSize',22); 
ylabel('$log(\beta_{threshold})$ for Sensing','interpreter','latex','FontSize',22)
legend({'Moore','Von Neumann','Radial'},'interpreter','latex');
set(gca,'FontSize',20); 
title('$\beta_{threshold}$ for different neighborhood types','FontSize',22,'Interpreter','latex');
print('supp_fig9B.eps','-depsc');
 
% figure
% stdshade(log(square_bc),0.5,[0.4940 0.1840 0.5560],nx_rad,'-'); hold on;
% stdshade(log(diagonal_bc),0.5,[0.6350 0.0780 0.1840],nx_sq,'-'); hold on;
% stdshade(log(radial_bc),0.5,[0.9290 0.6940 0.1250],nx_diag,'-');
% xlabel('Number of Neighboring Cells $(n)$','interpreter','latex','FontSize',22); 
% ylabel('$log(\beta_{threshold})$ for Sensing','interpreter','latex','FontSize',22)
% legend({'Moore','Von Neumann','Radial'},'interpreter','latex');
% set(gca,'FontSize',20);