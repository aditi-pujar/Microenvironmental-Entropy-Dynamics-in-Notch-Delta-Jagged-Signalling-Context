function chessboard()

NN=24;
col = zeros(NN);

for xtt=1:NN
       for ytt=1:NN
           if mod(xtt+ytt,2)==0
               col(xtt,ytt)= 1;
           else
               col(xtt,ytt)= -1;
           end
       end
end

chessboard_g = grandGsq(col);

val = abs(fft2(col));
val = val/max(abs(val(:)));
chessboard_ps = sqpowspec(val);

save('mychessboard.mat','chessboard_g','chessboard_ps');