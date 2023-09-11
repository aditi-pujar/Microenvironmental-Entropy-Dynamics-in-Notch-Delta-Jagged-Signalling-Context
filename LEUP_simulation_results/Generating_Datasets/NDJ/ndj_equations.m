%% Functions: NotchDelta ODEs, Shifted Hill function:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Notch,Delta,Jagged,NICD]=ndj_equations(Nx,Dx,Jx,Ix,Dextx,Jextx,N_D_I_ext,N_J_I_ext)
global dt gamma gammaI N0 D0 J0 kTD kTJ kC I0 nN nD nJ nF lambdaN lambdaJ lambdaD ldf ljf 
delN=N0*Hill(Ix,I0,nN,lambdaN)-Nx*((kC*Dx+kTD*Dextx)*Hill(Ix,I0,nF,ldf)+(kC*Jx+kTJ*Jextx)*Hill(Ix,I0,nF,ljf))-gamma*Nx;
delD=D0*Hill(Ix,I0,nD,lambdaD)-kC*Dx*Nx*Hill(Ix,I0,nF,ldf)-kTD*Dx*N_D_I_ext-gamma*Dx;
delJ=J0*Hill(Ix,I0,nJ,lambdaJ)-kC*Jx*Nx*Hill(Ix,I0,nF,ljf)-kTJ*Jx*N_J_I_ext-gamma*Jx;
delI=kTJ*Nx*Jextx*Hill(Ix,I0,nF,ljf)+kTD*Nx*Dextx*Hill(Ix,I0,nF,ldf)-gammaI*Ix;
        
Notch=Nx+delN*dt;
Delta=Dx+delD*dt;
Jagged=Jx+delJ*dt;
NICD=Ix+delI*dt;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%