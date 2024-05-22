function chessboard()

NN=24;
col = zeros(NN);

for xtt=1:NN
       for ytt=1:NN
           if mod(xtt+ytt,2)==0
               col(xtt,ytt)= 1;
           else
               col(xtt,ytt)= 0;
           end
       end
end

chessboard_g = grandGsq(col);
fftval = abs(fft2(col));
fftval = fftval/(max(abs(fftval(:))));
chessboard_ps = sqpowspec(fftval);

random_col = rand(NN,NN);
random_g = grandGsq(random_col);
fftval = abs(fft2(random_col));
fftval = fftval/(max(abs(fftval(:))));
random_ps = sqpowspec(fftval);


save('mychessboard.mat','chessboard_g','random_g','chessboard_ps','random_ps'); %,'chessboard_ps');