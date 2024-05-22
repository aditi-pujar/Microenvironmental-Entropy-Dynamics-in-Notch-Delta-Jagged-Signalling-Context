figure
imagesc(beta_old);hold on;
%contour(beta_old,'Color','black','LineWidth',2)
title('(i) $\beta$ Phase Diagram','interpreter','latex','FontSize',24);
xlabel('$J_0$','interpreter','latex','FontSize',24); ylabel('$D_0$','interpreter','latex','FontSize',24);
colorbar;
xticklabels({'300','500','700','900','1100','1300'}); 
%yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
print('./plots/figA_beta.eps','-depsc');

modality_index = 0.55555555555-sbc;
figure
imagesc(modality_index); hold on;
%contour(sbc,'Color','black','LineWidth',2)
title('(ii) Modality Index Phase Diagram','interpreter','latex','FontSize',24);
xlabel('$J_0$','interpreter','latex','FontSize',24); ylabel('$D_0$','interpreter','latex','FontSize',24);
colorbar;
xticklabels({'300','500','700','900','1100','1300'}); 
%yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
print('./plots/figA_sbc.eps','-depsc');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DISCRETIZED PDS
figure
imagesc(sign(beta_old));hold on;
%contour(sign(beta_old),'Color','black','LineWidth',1)
title('(i) Discretised $\beta$ Phase Diagram','interpreter','latex','FontSize',20);
xlabel('$J_0$','interpreter','latex','FontSize',20); ylabel('$D_0$','interpreter','latex','FontSize',20);
colorbar;
xticklabels({'300','500','700','900','1100','1300'}); 
%yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
print('./plots/figB_beta.eps','-depsc');

figure
imagesc(sign(0.55555555555-sbc)); hold on;
%contour(sign(0.55555555555-sbc),'Color','black','LineWidth',1)
title('(ii) Discretised Modality Index Phase Diagram','interpreter','latex','FontSize',20);
xlabel('$J_0$','interpreter','latex','FontSize',20); ylabel('$D_0$','interpreter','latex','FontSize',20);
colorbar;
xticklabels({'300','500','700','900','1100','1300'}); 
%yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
print('./plots/figB_sbc.eps','-depsc');

% PHASE SPACE BOUNDARY
dynamics_term = log(Gx)-log(Gy);
figure
imagesc(dynamics_term); hold on;
%contour(log(Gx)-log(Gy),'Color','black','LineWidth',0.5)
title('$\log(\frac{\nabla_XG}{\nabla_YG})$ Dynamics Phase Diagram','interpreter','latex','FontSize',24);
xlabel('$J_0$','interpreter','latex','FontSize',24); ylabel('$D_0$','interpreter','latex','FontSize',24);
colorbar;
xticklabels({'300','500','700','900','1100','1300'}); 
%yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
print('./plots/figC.eps','-depsc');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mygauss = @(x,mu,var) exp(-(x-mu).^2/(2*var));
x = 1:100;
figure('Position',[380,458,143,118])
plot(x,mygauss(x,25,70)+mygauss(x,75,90),'LineWidth',3,'Color','black')
ylim([0,1.1])
xticks([]); yticks([]);
title('Bimodal','interpreter','latex','FontSize',18)
print('./plots/figA_a.eps','-depsc');

figure('Position',[380,458,143,118])
plot(x,mygauss(x,50,100),'LineWidth',3,'Color','black')
ylim([0,1.1])
xticks([]); yticks([]);
title('Unimodal','interpreter','latex','FontSize',18)
print('./plots/figA_b.eps','-depsc');