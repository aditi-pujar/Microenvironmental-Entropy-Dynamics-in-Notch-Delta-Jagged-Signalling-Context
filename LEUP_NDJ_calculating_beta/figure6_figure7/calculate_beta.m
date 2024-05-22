function [beta_new, Gx_term, Gy_term, dsY, dsY_X, MI, beta_old] = calculate_beta(Nf,Df,Jf,D0,J0)
%parameter values
N0 = 1400; I0 = 200;
kT = 5e-5; kC = 5e-4;
hN = 2; hD = 2; hJ = 5;
lN = 2; lD = 0; lJ = 2;
gamma = 0.1; gammaI = 0.5; 

a = kT/gammaI;
c2 = hN*N0*(lN-1)/(4*I0);
c4 = hD*D0*(lD-1)/(4*I0) + hJ*J0*(lJ-1)/(4*I0);
K = kT - c2*a;

M = 5000*sqrt(2); % characteristic value of molecules, for the partition function approximation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% getting equilibrium X and Y values
Ns = mean(Nf(:));
Ds = mean(Df(:));
Js = mean(Jf(:));
Ls = Ds + Js;

Lf = Df+Jf;

[Nextval,Lextval] = devr(Nf,Df,Jf);
%[Nextval,Lextval] = devr2(Nf,Df,Jf);

Next_s = mean(Nextval(:));
Lext_s = mean(Lextval(:));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dynamics terms

Gy_term = abs(Ns*Ls*kT*K);

gx1 = Ns*Lext_s*kC*(K+a*c4);
gx2 = Next_s*Ls*kC*kT;
gx3 = Next_s*Lext_s*kT*K;
gx4 = gamma*(kC*(Ns+Ls)+kT*Next_s+K*Lext_s+gamma);
Gx_term = abs(gx1+gx2+gx3+gx4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% statistical terms
sYY = cov(Nextval(:),Lextval(:));
sXX = cov(Nf(:),Lf(:));

sXY = zeros(2);

dummy = cov(Nf(:),Nextval(:));
sXY(1,1) = dummy(1,2);
dummy = cov(Nf(:),Lextval(:));
sXY(1,2) = dummy(1,2);
dummy = cov(Lf(:),Nextval(:));
sXY(2,1) = dummy(1,2);
dummy = cov(Lf(:),Lextval(:));
sXY(2,2) = dummy(1,2);

sYX = transpose(sXY);
sY_X = sYY - sYX*(inv(sXX))*sXY;

MI = 0.5*(log(det(sYY))-log(det(sY_X))); 
dsY = log(det(sYY));
dsY_X = log(det(sY_X));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beta_new = -(1+log(2*pi)-log(Gx_term)+log(Gy_term)+0.5*dsY)/MI;
beta_old = -(log(2*pi)-log(M)+log(Gy_term)+0.5*dsY)/MI;
end

