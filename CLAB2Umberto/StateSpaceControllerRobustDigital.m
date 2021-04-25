clear;
loadParEst;
T1 = 0.001;
T2 = 0.01;
T3 = 0.05;

Ts=T1;
km = drv.dcgain*mot.Kt/(Req*Beq + mot.Kt*mot.ke);

Tm = Req*Jeq/(Req*Beq+mot.Kt*mot.ke);

A = [0,1;...
    0,-1/Tm];
B = [0;...
    km/gbox.N1/Tm];
C = [1,0];
D = 0;

bb = zeros(size(A,1),1);
bb = [bb;1];
xx = [A,B;C,0]\bb;
Nx = xx(1:end-1);
Nx = reshape(Nx,[],1);
Nu = xx(end);
Nu = reshape(Nu,[],1);
S = ss(A,B,C,D);

ts5 = 0.15;
Mp = 0.1;
dampingFactor = log(1/Mp)/sqrt(pi^2+log(1/Mp)^2);
wn = 3/ts5/dampingFactor;
%tr = 0.1;
%wn = 1.8/tr;
z = -dampingFactor*wn + 1i*wn*sqrt(1-dampingFactor^2);
p = [z,conj(z)];
K = place(A,B,p);

sigma = 0.5*real(z);
wd = 0.25*imag(z);

p1 = [z,conj(z),3*sigma];
p2 = [sigma,sigma,sigma];
p3 = [3*sigma + 1i*wd,3*sigma - 1i*wd,3*sigma];
p4 = [2*sigma + 1i*wd,2*sigma - 1i*wd,5*sigma];
Ae = [0,C;zeros(size(A,1),1),A];
Be = [0;B];
Ke_1 = place(Ae,Be,p1);
Ke_2 = acker(Ae,Be,p2);
Ke_3 = place(Ae,Be,p3);
Ke_4 = place(Ae,Be,p4);
Ke = Ke_4;

pOutput = size(C,1);
mInput = size(B,2);
T = eye(size(A));
Tinv = inv(T);
Atmp = A;
Btmp = B;
A = Tinv*A*T;
B = Tinv*B;
A11 = A(1:pOutput,1:pOutput);
A12 = A(1:pOutput,pOutput + 1:end);
A21 = A(pOutput + 1:end,1:pOutput);
A22 = A(pOutput + 1:end,pOutput + 1:end);
B1 = B(1:pOutput,:);
B2 = B(pOutput + 1:end,:);
estP = -dampingFactor*wn*5;
L = place(A22',A12',estP);
L = L';
A0 = A22 - L*A12;
B0 = [B2 - L*B1,(A22 - L*A12)*L+A21-L*A11];
C0 = T*[zeros(pOutput,size(A,1) - pOutput);eye(size(A,1) - pOutput)];
D0 = T*[zeros(pOutput,mInput),eye(pOutput);...
        zeros(size(A,1) - pOutput,mInput),L];
A = Atmp;
B = Btmp;
[Phi0,Gamma0,H0,J0] = discretizedStateSpace(A0,B0,C0,D0,'FE',Ts);