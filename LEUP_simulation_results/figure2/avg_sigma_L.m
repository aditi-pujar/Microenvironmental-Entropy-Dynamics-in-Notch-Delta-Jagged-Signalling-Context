function [sd_beta, variance_beta, ent_beta, ent_variance_beta] = avg_sigma_L(r,BETA,bit)


no = length(BETA);
sd_beta = zeros(1,no);
variance_beta = zeros(1,no);
ent_beta = zeros(1,no);
ent_variance_beta = zeros(1,no);

if bit == 1 % positive betas (keep in mind the signs are flipped in the dataset and our interpretation
    filename1 = '/r=%d/minuscircle_beta%0.1f_r%d_t%d.mat';
    filename2 = '/r=%d/minuscircle_beta%d_r%d_t%d.mat';
    foldername = '../Datasets/LEUP/datasets/square';
    lowlim = int8(1);
%     uplim = int8(51);

elseif bit == 0 % negative betas
    filename1 = '/r=%d/radbeta%0.1f_r%d_t%d.mat';
    filename2 = '/r=%d/radbeta%d_r%d_t%d.mat';
    foldername = '../Datasets/LEUP/radial';
    lowlim = int8(2);
%     uplim = int8(20);
end


for i=1:no % averaging over 5 simulations 
    beta = ((-1)^bit)*BETA(i);
    temp = zeros(1,5);
    temp_entropy = zeros(1,5);
    
    for ll=1:5    
        if i<4
            filename=sprintf(filename1,r,beta,r,ll);
        else
            filename=sprintf(filename2,r,beta,r,ll);
        end
    
        load(fullfile(cd,foldername,filename),'LEUP');
    
        tmp1=LocalSigma(LEUP,51,1);
        tmp2 = mean(diff(tmp1(lowlim:51)));
        temp(ll) = tmp2;
        temp_entropy(ll) = tmp2/(2*mean(tmp1(lowlim:51)));
    end
    
    sd_beta(i) = mean(temp);
    variance_beta(i) = std(temp);

    ent_beta(i) = mean(temp_entropy);
    ent_variance_beta(i) = std(temp_entropy);
end

if bit == 0
    sd_beta = fliplr(sd_beta);
    variance_beta =  fliplr(variance_beta);
    ent_beta = fliplr(ent_beta);
    ent_variance_beta =  fliplr(ent_variance_beta);
end
