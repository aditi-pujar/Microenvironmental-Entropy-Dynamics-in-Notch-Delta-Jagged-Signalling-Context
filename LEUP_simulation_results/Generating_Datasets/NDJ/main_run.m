% this will generate all the Notch Delta datasets required for comparison with LEUP simulations 

% for lateral induction
parfor seed=1:5
periodic_square_NDJ(1400,1300,seed);
end

% for lateral inhibition
parfor seed=1:5
periodic_square_NDJ(1600,700,seed);
end

