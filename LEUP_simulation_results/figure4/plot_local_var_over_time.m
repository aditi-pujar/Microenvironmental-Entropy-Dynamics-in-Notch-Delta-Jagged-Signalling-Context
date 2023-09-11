%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_local_var_over_time(sigmavals,BETA,col,linespec)
no = size(sigmavals{1},2);
for j = 1:length(BETA)
    val = sigmavals{j};
    stdshade(val,0.3,col{j},1:no,linespec);
    hold on;
end

xlim([0,no]); ylim([0 inf])
xticks(0:10:50);
xlabel('$t (s)$','interpreter','latex','FontSize',18); 
ylabel('$\langle \sigma^2\rangle_L$','interpreter','latex','FontSize',18);
set(gca,'FontSize',14);
end
