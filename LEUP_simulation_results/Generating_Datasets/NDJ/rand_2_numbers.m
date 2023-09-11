function r=rand_2_numbers(size,b,a)
rng(1,'twister');
r = (b-a).*rand(size) + a;
end