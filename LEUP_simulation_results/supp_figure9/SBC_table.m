function val = SBC_table(t,bit)
R=[2,3,4,5,6,7,8,9,10];%,15,20,25];%,1,1,1,1,1,1,1,1,1,1,1];%,2,1,10];%,3,4,5,6,7,8,9,10,15,25];
BETA=[0.1,0.5,1,5,7,10,15,20,25,50,100,250,500,1000];

SBI=zeros(length(R),length(BETA));

for kindex=1:length(R)
    for mindex=1:length(BETA)
        if bit==1 %square nghbd
        if mindex<3
            filename = sprintf('neighborhoods/square_beta%0.1f_r%d_dt0.01_TMAX50_T%d.mat',BETA(mindex),R(kindex),t);
        else
            filename = sprintf('neighborhoods/square_beta%d_r%d_dt0.01_TMAX50_T%d.mat',BETA(mindex),R(kindex),t);
        end
        
        elseif bit==2 %diag
        %DIAG
        if mindex<3
            filename = sprintf('neighborhoods/diag_beta%0.1f_r%d_dt0.01_TMAX50_T%d.mat',BETA(mindex),R(kindex),t);
        else
            filename = sprintf('neighborhoods/diag_beta%d_r%d_dt0.01_TMAX50_T%d.mat',BETA(mindex),R(kindex),t);
        end

        elseif bit==3 %radial
        %RADIAL
        if mindex<3
            filename=sprintf('radial/r=%d/radbeta%0.1f_r%d_t%d.mat',R(kindex),BETA(mindex),R(kindex),t);
        else
            filename=sprintf('radial/r=%d/radbeta%d_r%d_t%d.mat',R(kindex),BETA(mindex),R(kindex),t);
        end
        end
        
        
        load(fullfile(cd,'../Datasets/LEUP',filename),'LEUP');
        tmp1=LEUP(:,:,end);
        sample3=tmp1/max(abs(tmp1(:)));
        SBI(kindex,mindex)=SarleBimodalityIndex(sample3(:));
    end
end

val = SBI;
end

