function [sigmavals] = extract_local_variance(r,BETA,bit)
sigmavals = cell(1,length(BETA));
if bit == 1 % positive betas (keep in mind the signs are flipped in the dataset and our interpretation
    filename1 = '/r=%d/minuscircle_beta%0.1f_r%d_t%d.mat';
    filename2 = '/r=%d/minuscircle_beta%d_r%d_t%d.mat';
    foldername = '../Datasets/LEUP/datasets/square';

elseif bit == 0 % negative betas
    filename1 = '/r=%d/radbeta%0.1f_r%d_t%d.mat';
    filename2 = '/r=%d/radbeta%d_r%d_t%d.mat';
    foldername = '../Datasets/LEUP/radial';
end


for i=1:length(BETA) % averaging over 5 simulations 
    beta = ((-1)^bit)*BETA(i);
    TT = 51;
    val = zeros(5,TT);
    
    for trial=1:5    
        if abs(beta)<1
            filename=sprintf(filename1,r,beta,r,trial);
        else
            filename=sprintf(filename2,r,beta,r,trial);
        end
    
        load(fullfile(cd,foldername,filename),'LEUP');
        val(trial,:) = LocalSigma(LEUP,TT,1);
     end
        sigmavals{i} = val;
end
end