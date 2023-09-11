%load('fig2B_r1.mat');

load('fig2B_r1.mat')
BETA = [0.1,0.5,0.9,1,5,7,10,15,20,25,50,75,100,250,500,1000];

% Plotting average slope of sigma_L v/s time (time averaged d/dt(sigma_L))
    xaxis = cat(2,-fliplr(BETA),BETA);
    figure
    ax = gca;
    ax.FontSize = 160;
    errorbar(1:16,sd_neg_beta,variance_neg,'o','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',[0 0.4470 0.7410], 'Color', [0 0.4470 0.7410]);
    hold on
    errorbar(17:32,sd_pos_beta,variance_pos,'o','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',[0.4660 0.6740 0.1880], 'Color', [0.4660 0.6740 0.1880]);
    
    % xticks(1:4:32); % helps us get the correct xticklabels
    % xticklabels({'-1000','-750','-15','-1','0.1','5','20','100'})

    xticks(1:3:32); 
    % xaxis(1:3:32) % helps us get the correct xticklabels
    xticklabels({'-1000','-100','-25','-10','-1','-0.1','0.9','7','20','75','500'})

    set(gca,'FontSize',16); 
    xlabel('$\beta$','Interpreter','latex','FontSize',25); 
    ylabel('$\langle\frac{d\sigma^2}{dt}\rangle (s^{-1})$','Interpreter','latex','FontSize',26); 
    title(sprintf('$r = %d$',r),'Interpreter','latex','FontSize',25); %title({['Avg. d\sigma^2/dt v/s \beta'],[sprintf('r=%d',r)]});
    legend({'$\beta < 0$','$\beta > 0$'},'FontSize',20,'Interpreter','latex','Location','northeast');
    ylim([-1.8e-3,0.2e-3])

    print('fig2B_r1.eps','-depsc') 
    %  %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
