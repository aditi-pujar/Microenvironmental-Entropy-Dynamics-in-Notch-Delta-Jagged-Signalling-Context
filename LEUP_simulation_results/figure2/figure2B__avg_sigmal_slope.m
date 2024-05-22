% LEUP Simulations FIGURE 3B -- Average slope of \sigmal v/s time graphs;

R=[1,5];
BETA = [0.1,0.5,0.9,1,5,7,10,15,20,25,50,75,100,250,500,1000];
no = length(BETA);

sd_neg_beta = zeros(1,no);
variance_neg = zeros(1,no);
ent_neg_beta = zeros(1,no);
ent_variance_neg = zeros(1,no);

sd_pos_beta = zeros(1,no);
variance_pos = zeros(1,no);
ent_pos_beta = zeros(1,no);
ent_variance_pos = zeros(1,no);

for r = [1,5]
    [sd_neg_beta, variance_neg, ent_neg_beta, ent_variance_neg] = avg_sigma_L(r,BETA, 0);
    [sd_pos_beta, variance_pos, ent_pos_beta, ent_variance_pos] = avg_sigma_L(r,BETA, 1);

    filename = sprintf('fig2B_r%d.mat',r);
    save(filename)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Plotting average slope of sigma_L v/s time (time averaged d/dt(sigma_L))
    figure
    ax = gca;
    ax.FontSize = 160;
    errorbar(1:16,sd_neg_beta,variance_neg,'o','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',[0 0.4470 0.7410], 'Color', [0 0.4470 0.7410]);
    hold on
    errorbar(17:32,sd_pos_beta,variance_pos,'^','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',[0.4660 0.6740 0.1880], 'Color', [0.4660 0.6740 0.1880]);
    hold on
    plot(zeros(32,1),'--','Color',[0 0 0 0.5],'LineWidth',2)
    grid on

%     xticks(1:3:32); 
%     % xaxis = cat(2,-fliplr(BETA),BETA);
%     % xaxis(1:3:32) % helps us get the correct xticklabels
%     xticklabels({'-1000','-100','-25','-10','-1','-0.1','0.9','7','20','75','500'});

    xticks(1:4:32); 
    % xaxis = cat(2,-fliplr(BETA),BETA);
    % xaxis(1:3:32) % helps us get the correct xticklabels
    xticklabels({'-1000','-75','-15','-1','0.1','5','20','100'});


    if r==1
        title(sprintf('(i) $r = %d$',r),'Interpreter','latex','FontSize',25);
    else
        title(sprintf('(ii) $r = %d$',r),'Interpreter','latex','FontSize',25);
    end

    ax.XAxis.FontSize = 20;
    ax.YAxis.FontSize = 20;

%     xlabel('$\beta$','Interpreter','latex','FontSize',25); 
%     ylabel('$\langle\frac{d\sigma^2}{dt}\rangle (s^{-1})$','Interpreter','latex','FontSize',26); 
    legend({'$\beta < 0$','$\beta > 0$'},'FontSize',20,'Interpreter','latex','Location','northeast');
    ylim([-2e-3,1.5e-3])
    xlim([0.5,32.5])

    picfilename = sprintf('fig2B_r%d.eps',r);
    print(picfilename,'-depsc')
end

%     % Plotting time averaged d/dt(entropy))
%     xaxis = cat(2,-fliplr(BETA),BETA);
%     figure
%     ax = gca;
%     ax.FontSize = 160;
%     errorbar(1:16,ent_neg_beta,ent_variance_neg,'o','MarkerSize',10,'MarkerFaceColor',[0.4660,0.6740,0.1880],'MarkerEdgeColor','green');
%     hold on
%     errorbar(17:32,ent_pos_beta,ent_variance_pos,'o','MarkerSize',10,'MarkerFaceColor','blue','MarkerEdgeColor','blue');
%     xticklabels({'-75','-15','-1','1','15','75','250'})
%     set(gca,'FontSize',16); xlabel('\beta'); ylabel('Avg. d\bar{S}(Y|X)/dt'); title(strcat('Avg. dS/dt v/s \beta for r=',r));
%     legend({'\beta<0','\beta>0'},'FontSize',20);

