function BC=SarleBimodalityIndex(xpdf)
smalln=length(xpdf);
        g=skewness(xpdf,0);
        KK=kurtosis(xpdf,0)-3;
        BC = (g^2+1)/(KK+3*(smalln-1)^2/((smalln-2)*(smalln-3)));
end
