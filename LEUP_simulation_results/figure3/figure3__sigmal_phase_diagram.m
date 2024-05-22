% FIGURE 3 - Phase diagram over (r, beta) of average local variance at
% equilibrium

nboot = 500;
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Phase diagrams
R=1:10;
BETA=[0.1,0.5,0.9,1,5,7,10,15,20,25,50,75,100,250,500,1000];

sigmaval1=zeros(length(R),length(BETA));
sigmaval2=zeros(length(R),length(BETA));

Csigma1=cell(1,5);
Csigma2=cell(1,5);

% POSITIVE Local Variance Phase diagram
for lindex=1:5
for kindex=1:length(R)
    for mindex=1:length(BETA)
        if mindex<4
            filename=sprintf('/r=%d/minuscircle_beta%0.1f_r%d_t%d.mat',R(kindex),-BETA(mindex),R(kindex),lindex);
        else
            filename=sprintf('/r=%d/minuscircle_beta%d_r%d_t%d.mat',R(kindex),-BETA(mindex),R(kindex),lindex);
        end
            
        load(fullfile(cd,'../Datasets/LEUP/datasets/square',filename));
        tmp1=LEUP(:,:,51);
        sample3=tmp1/max(abs(tmp1(:)));
        tmp_sigma = LocalEnt_SqFn(sample3,25,3);
        sigmaval1(kindex,mindex)= mean(tmp_sigma(:));
    end
end
Csigma1{1,lindex}=sigmaval1;
end

    
% NEGATIVE Local Variance Phase diagram
for lindex=1:5
for kindex=1:length(R)
    for mindex=1:length(BETA)
        if mindex<4
            filename=sprintf('/r=%d/radbeta%0.1f_r%d_t%d.mat',R(kindex),BETA(mindex),R(kindex),lindex);
        else
            filename=sprintf('/r=%d/radbeta%d_r%d_t%d.mat',R(kindex),BETA(mindex),R(kindex),lindex);
        end
            
        load(fullfile(cd,'../Datasets/LEUP/radial',filename));
        tmp1=LEUP(:,:,51);
        sample3=tmp1/max(abs(tmp1(:)));
        
        tmp_sigma = LocalEnt_SqFn(sample3,24,3);
        sigmaval2(kindex,mindex)= mean(tmp_sigma(:));
    end
end
Csigma2{1,lindex}=sigmaval2;
end

avgSIGMAplushex=(Csigma1{1,1}+Csigma1{1,2}+Csigma1{1,3}+Csigma1{1,4}+Csigma1{1,5})/5;
avgSIGMAminushex=(Csigma2{1,1}+Csigma2{1,2}+Csigma2{1,3}+Csigma2{1,4}+Csigma2{1,5})/5;

avgsigma = cat(2,flip(avgSIGMAminushex,2),avgSIGMAplushex);
avg_entropy = 0.5 + 0.5*log(2*pi*avgsigma);

save('fig3.mat')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('fig3.mat')
   figure
           imagesc(avgsigma);
           ax = gca;
           ax.FontSize = 16;

           colorbar
           colormap default
           brighten(-0.2);
           
           title('$\langle\sigma^2\rangle_L$ Phase Diagram','interpreter','latex','FontSize',22);
           xlabel('Sensitivity $(\beta)$','interpreter','latex','FontSize',20);
           ylabel('Radius $(r)$','interpreter','latex','FontSize',20);

           yticks(1:2:10)
           yticklabels(1:2:10); 
           xticks(1:4:32);
           xticklabels({'-1000','-75','-15','-1','0.1','5','20','100'});
           print('fig3.eps','-depsc')
toc
   
%    figure
%            imagesc(avg_entropy);
%            colorbar
%            title('$Average Local Entropy Phase Diagram \frac{1}{2}\log(2\pi e\sigma^2_L)$','interpreter','latex','FontSize',26);
%            xlabel('$Sensitivity (\beta)$','interpreter','latex','FontSize','25');
%            ylabel('Radius (r)','FontSize','25');
%            yticklabels(1:10);  
%            xticklabels([-75,-25,-1,10,50,250])