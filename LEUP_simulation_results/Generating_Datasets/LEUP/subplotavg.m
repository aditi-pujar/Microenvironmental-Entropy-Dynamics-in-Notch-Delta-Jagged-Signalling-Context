clear all;
R=[1,2,7,10];%[1,2,3,4,5,10,15,20,25];
%BETA=[0.1,0.5,0.9,1,5,7,10,15,20,25,50,70,100,250];%[0.1,0.5,0.99,1,5,7,10,15,20,25,100,250];
%0.1,0.5,0.9,1,5,7,10,15,20,25,50,75,100,250,500,1000

BETA=[5,25,100,250];

C=cell(1,5);
figure
sgtitle({['\beta = 25, Hexagonal Lattice (24x24)']}),%['Histograms averaged over 50 simulations']})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% for lindex=1:5
% for kindex=1:length(R)
%     for mindex=1:length(BETA)
%         if mindex<4
%             filename=sprintf('/r=%d/minuscircle_beta%0.1f_r%d_t%d.mat',R(kindex),(-1)*BETA(mindex),R(kindex),lindex);
%         else
%             filename=sprintf('/r=%d/minuscircle_beta%d_r%d_t%d.mat',R(kindex),(-1)*BETA(mindex),R(kindex),lindex);
%         end
%             
%         load(fullfile(cd,'datasets','square',filename));
%         tmp1=LEUP(:,:,51);
%         %sample=normalise(tmp1);
%         sample=tmp1/max(tmp1(:));
%         %sample2=tmp1/max(abs(tmp1(:)));
%         sample2=normalise(tmp1);
%         sample3=tmp1/max(abs(tmp1(:)));
%         

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for index=1:length(R)
        tmp1=0; SBI=0;
        
        for ll=1:5
        %if index<4
         %   filename=sprintf('/r=3/MOORBETA%0.1f_r3_t%d.mat',BETA(index),ll);
        %else
            filename=sprintf('/r=%d/MOORBETA25_r%d_t%d.mat',R(index),R(index),ll);
        %end
            
        load(fullfile(cd,'hexagonal',filename));
        LEUPval=LEUP(:,:,51);
        sample=LEUPval/max(abs(LEUPval(:)));
        C{ll}=sample(:);
        %SBI=SBI+SarleBimodalityIndex(sample(:));
        end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    final=cell2mat(C);
    SBCval=SarleBimodalityIndex(final(:));
    subplot(1,4,index)
     edges=linspace(-1,1,21);
    histogram(final(:),'Normalization','probability','BinEdges',edges);
    title({[strcat("r=",num2str(R(index)))],[strcat('SBC=',num2str(SBCval))]});         


    end
