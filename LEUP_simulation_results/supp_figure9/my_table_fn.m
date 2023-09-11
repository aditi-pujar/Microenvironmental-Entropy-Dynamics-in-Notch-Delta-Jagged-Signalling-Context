function val = my_table_fn(SBC)
val = zeros(1,9);
BETA=[0.1,0.5,1,5,7,10,15,20,25,50,100,250,500,1000];

for r = 1:9
    for k = 1:14
        if SBC(r,k) < 0.555
            val(r) = BETA(k);
            break;
        end
    end
end 

