BETA = [0.1,0.5,1,5]; % figure 4A - low thresholding l-var plots 
% BETA = [5,10,50]; % figure 4B - post beta_critical

col = {[0.9290 0.6940 0.1250],[0.8500 0.3250 0.0980],[0.6350 0.0780 0.1840],[0.4940 0.1840 0.5560]}; % for 4A
% col = {[0.4940 0.1840 0.5560],[0 0.4470 0.7410], [0.4660 0.6740 0.1880], [0.3010 0.7450 0.9330]}; % for 4B

TT=51;
mysubtitle = {'(i) ','(ii) ','(iii) ','(iv) ','(v) ','(vi)'};

tic
i = 0;
figure('Position',[290 305 470 600])
for rval = [1,2,5]
i = i+1;
pos_val = extract_local_variance(rval,BETA,1);
subplot(3,2,i)
plot_local_var_over_time(pos_val,BETA,col,'-')
title(strcat(mysubtitle{i},32,sprintf('$r = %d,',rval),'\beta > 0$'),"FontSize",19,'interpreter', 'latex');
% legendCell = strcat('$\beta= ',string(num2cell(BETA)),'$');
% legend(legendCell,'interpreter','latex','FontSize',16,'Location','best');

i = i+1;
subplot(3,2,i)
neg_val = extract_local_variance(rval,BETA,0);
plot_local_var_over_time(neg_val,BETA,col,':');
title(strcat(mysubtitle{i},32,sprintf('$r = %d,',rval),'\beta < 0$'),"FontSize",19,'interpreter', 'latex');
% legendCell = strcat('$\beta= ',string(num2cell(-BETA)),'$');
% legend(legendCell,'interpreter','latex','FontSize',16,'Location','best');

save(sprintf('fig4A_r%d.mat',rval));
% save(sprintf('fig4B_r%d.mat',rval));
end

print('fig4A.eps','-depsc');
% print('fig4B.eps','-depsc');

toc