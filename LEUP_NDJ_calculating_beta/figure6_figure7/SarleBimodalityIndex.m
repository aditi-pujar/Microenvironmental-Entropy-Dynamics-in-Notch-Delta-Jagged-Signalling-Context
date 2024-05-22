function BC=SarleBimodalityIndex(x)

skewns = @(x) (sum((x-mean(x)).^3)./length(x))./(var(x,1).^1.5);
kurtss = @(x) (sum((x-mean(x)).^4)./length(x))./(var(x,1).^2);

smalln=length(x);
        g=skewns(x);
        KK=kurtss(x)-3;
        BC = (g^2+1)/(KK+3*(smalln-1)^2/((smalln-2)*(smalln-3)));
end
