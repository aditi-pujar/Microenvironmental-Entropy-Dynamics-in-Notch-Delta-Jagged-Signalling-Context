D0val = 500:100:2000;
J0val = 200:100:1300;

for i=4:length(D0val)
    D0 = D0val(i);
    tic
    parfor j=1:length(J0val)
        J0 = J0val(j);
        periodic_square_NDJ(D0,J0);
    end
    fprintf(1,'*\n');
    toc
    fprintf(1,'******\n\n');
end