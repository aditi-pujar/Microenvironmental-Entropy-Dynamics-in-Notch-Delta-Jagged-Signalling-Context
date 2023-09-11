function X=Hill(IX,KX,nX,lambdaX)
Hminus=(KX).^(nX)/((KX).^(nX)+(IX).^(nX));
Hplus=(IX).^(nX)/((KX).^(nX)+(IX).^(nX));

X=Hminus+lambdaX*Hplus;
%lambda>1 means Hs+, lambda<1 means Hs-
end