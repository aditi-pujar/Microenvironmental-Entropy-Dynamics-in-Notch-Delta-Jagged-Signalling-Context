% running this will generate all the LEUP datasets required for analysing LEUP simulations

% creating file structure to store datasets
create_LEUP_dataset_file_structure()

% ---------------------------------------------------------------------------------------------
R=[1,2,3,4,5,6,7,8,9,10];
BETA=[0.1,0.5,0.9,1,5,7,10,15,20,25,50,75,100,250,500,1000];

% Positive and Negative betas for a range of r
for i=1:length(R)
for j=1:length(BETA)
   r = R(i); beta = BETA(j);
   parfor seed=1:5
   rad_fn(25,r,beta,seed);
   rad_fn(25,r,-beta,seed);
   end
end
end


% Different Neighborhoods - extended Moore (square_fn) and extended Von Neumann (diag_fn)
for i=1:length(R)
for j=1:length(BETA)
    r = R(i); beta = BETA(j);
    parfor seed=1:3
    square_fn(25,r,beta,seed);
    diag_fn(25,r,beta,seed);
    end
end
end
