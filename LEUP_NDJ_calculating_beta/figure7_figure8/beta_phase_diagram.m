function beta_phase_diagram()

D0val = 500:100:2000;
J0val = 200:100:1300;

ld = length(D0val); lj = length(J0val);
beta_new = zeros(ld,lj);
beta_old = zeros(ld,lj);

% betaval = zeros(ld,lj);
% betaval_ext = zeros(ld,lj);
% betaval_plus = zeros(ld,lj);
% betaval_plus_ext = zeros(ld,lj);
% betaval_stat = zeros(ld,lj);
% grad_term = zeros(ld,lj);

Gx = zeros(ld,lj);
Gy = zeros(ld,lj);

dsY_matrix = zeros(ld,lj);
dsY_X_matrix = zeros(ld,lj);
MI_matrix = zeros(ld,lj);

sbc = zeros(ld,lj);
dip = zeros(ld,lj);
pval = zeros(ld,lj);

for i=1:length(D0val)
    D0 = D0val(i);
    for j=1:length(J0val)
        J0 = J0val(j);
        
        filename = strcat('./../Datasets/lat_D0_',num2str(D0),'_J0_',num2str(J0),'.mat');
        load(filename,'N','D','J','I');
        
        Nf = N(:,:,end);
        Df = D(:,:,end);
        Jf = J(:,:,end);
        If = I(:,:,end);
        ii = ld-i+1;
        
        [beta_new(ii,j), Gx(ii,j), Gy(ii,j), dsY_matrix(ii,j),dsY_X_matrix(ii,j),MI_matrix(ii,j), beta_old(ii,j)] = calculate_beta(Nf,Df,Jf,D0,J0);
        %[betaval(ii,j), betaval_ext(ii,j), betaval_plus(ii,j), betaval_plus_ext(ii,j), betaval_stat(ii,j), dsY_matrix(ii,j), dsY_X_matrix(ii,j), grad_term(ii,j)] = beta_calc(Nf,Df,Jf);
        sbc(ii,j) = SarleBimodalityIndex(If(:));
        [dip(ii,j),pval(ii,j)] = HartigansDipSignifTest(If(:),500);
    end
end
modality_index = 0.5555555-sbc;
dynamics_term = log(Gx)-log(Gy);
save('beta_phase_diagram_variables.mat');
end
% 
% figure
% imagesc(beta_new)
% title('new \beta Phase Diagram');hold on;
% contour(beta_new)
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_beta_new.jpg');
% 
% 
% figure
% imagesc(beta_old);hold on;
% contour(beta_old)
% title('old \beta Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_beta_old.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DYNAMICAL QUANTITY PDS 
% 
% figure
% imagesc(log(Gx))
% title('log(Gx) Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_Gx.jpg');
% 
% 
% figure
% imagesc(log(Gy))
% title('log(Gy) Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_Gy.jpg');
% 
% 
% figure
% imagesc(log(Gx)-log(Gy))
% title('log(\grad_X G/\grad_Y G) Dynamics Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_dynamics.jpg');
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STATISTICAL QUAANTITY PDS 
% 
% figure
% imagesc(dsY_matrix)
% title('log(|\Sigma_Y|) Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_dSy.jpg');
% 
% 
% figure
% imagesc(dsY_X_matrix)
% title('log(|\Sigma_{Y|X}|) Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_dSy_x.jpg');
% 
% 
% figure
% imagesc(MI_matrix)
% title('Mutual Information Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_MI.jpg');
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALTERNATE OLD BETA FORMULA PDS
% figure
% imagesc(betaval_ext)
% title('\beta_{ext} Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_new/pd_beta_ext.jpg');
% 
% figure
% imagesc(betaval_plus)
% title('\beta plus Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_new/pd_beta_plus.jpg');
% 
% figure
% imagesc(betaval_stat)
% title('Purely Statistical \beta Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_new/pd_beta_stat.jpg');
% 
% figure
% imagesc(betaval_plus_ext)
% title('\beta_{ext} plus Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_new/pd_beta_plus_ext.jpg');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % STATISTICAL INDICES PDS 
% figure
% imagesc(sbc); hold on;
% contour(sbc)
% title('SBC Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_sbc.jpg');

% 
% figure
% imagesc(dip)
% title('Dip Statistic Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_dip.jpg');
% 
% figure
% imagesc(pval)
% title('P value (Hartigans Dip) Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_pval.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % DISCRETISATION PDS
% figure
% imagesc(sign(0.555-sbc))
% title('sign(0.555-SBC) Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_sbc_sign.jpg');
% 
% figure
% imagesc(sign(beta_new))
% title('sign(new \beta) Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_beta_new_sign.jpg');
% 
% 
% figure
% imagesc(sign(beta_old))
% title('sign(old \beta) Phase Diagram');
% xlabel('J_0'); ylabel('D_0');
% colorbar;
% xticklabels({'300','500','700','900','1100','1300'}); 
% %yticklabels({'600','800','1000','1200','1400','1600','1800','2000'});
% yticklabels({'2000','1800','1600','1400','1200','1000','800','600'});
% saveas(gca,'./plots_4/pd_beta_old_sign.jpg');