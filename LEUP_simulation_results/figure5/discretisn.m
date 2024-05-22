function LEUPn = discretisn(LEUP,nval)

LEUP = LEUP/(max(abs(LEUP(:))));
NN = size(LEUP,1);
LEUPn = zeros(NN);

for l=1:NN
    for m = 1:NN
        
        for n = 0:nval-1
        if (LEUP(l,m) >= -1 + (2/nval)*n) && ((LEUP(l,m) < -1 + (2/nval)*(n+1)) || ( (n==nval-1)&&(LEUP(l,m)==1) ))
            LEUPn(l,m) = n;
        end
        end
        
    end
end
% 
% figure
% imagesc(LEUPn)
% title(strcat('Discretisation # =',num2str(nval)));
% colorbar
end

% 
% [g1,gavg1] = grandGsq(LEUP);
% [g2, gavg2] = grandGsq(LEUPn);
% val1 = g1(13,13,:); val2 = g2(13,13,:);
% 
% figure
% plot(1:12,val1(:),1:12,val2(:),1:12,val(:));
% title('g'); legend('LEUP','LEUPn','salt pepper');
% 
% figure
% plot(1:12,gavg1,1:12,gavg2,1:12,val(:));
% title('g'); legend('LEUP','LEUPn','salt pepper');