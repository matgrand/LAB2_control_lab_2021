km = drv.dcgain*mot.Kt/(Req*Beq + mot.Kt*mot.ke);
Tm = Req*Jeq/(Req*Beq+mot.Kt*mot.ke);

A = [0,1;...
    0,-1/Tm];
B = [0;...
    km/gbox.N1/Tm];
C = [1,0];
D = 0;


ts5 = 0.15;
Mp = 0.1;
dampingFactor = log(1/Mp)/sqrt(pi^2+log(1/Mp)^2);
wn = 3/ts5/dampingFactor;
z = -dampingFactor*wn + 1i*wn*sqrt(1-dampingFactor^2);
sigma = 0.5*real(z);
wd = 0.25*imag(z);

p1 = [z,conj(z),3*sigma];
p2 = [sigma,sigma,sigma];
p3 = [3*sigma + 1i*wd,3*sigma - 1i*wd,3*sigma];
p4 = [2*sigma + 1i*wd,2*sigma - 1i*wd,5*sigma];
p = p4*Ts;
p = exp(p);

[Phi,Gamma,H,J] = discretizedStateSpace(A,B,C,D,'zoh',Ts);

Phie = [eye(size(H,1)),H;...
        zeros(size(Phi,1),size(H,1)),Phi];
Gammae = [zeros(size(H,1));...
            Gamma];
Ke = place(Phie,Gammae,p);

bb = zeros(size(Phi,1),1);
bb = [bb;ones(size(H,1))];
xx = [Phi - eye(size(Phi,1)),Gamma;H,zeros(size(H,1))]\bb;
Nx = xx(1:end-1);
Nx = reshape(Nx,[],1);
Nu = xx(end);
Nu = reshape(Nu,[],1);

pOutput = size(H,1);
mInput = size(Gamma,2);
T = eye(size(Phi));
Tinv = inv(T);
Phitmp = Phi;
Gammatmp = Gamma;
Phi = Tinv*Phi*T;
Gamma = Tinv*Gamma;
Phi11 = Phi(1:pOutput,1:pOutput);
Phi12 = Phi(1:pOutput,pOutput + 1:end);
Phi21 = Phi(pOutput + 1:end,1:pOutput);
Phi22 = Phi(pOutput + 1:end,pOutput + 1:end);
Gamma1 = Gamma(1:pOutput,:);
Gamma2 = Gamma(pOutput + 1:end,:);
estP = -dampingFactor*wn*5;
estP = estP*Ts;
estP = exp(estP);
L = place(Phi22',Phi12',estP);
L = L';
Phi0 = Phi22 - L*Phi12;
Gamma0 = [Gamma2 - L*Gamma1,(Phi22 - L*Phi12)*L+Phi21-L*Phi11];
H0 = T*[zeros(pOutput,size(Phi,1) - pOutput);eye(size(Phi,1) - pOutput)];
J0 = T*[zeros(pOutput,mInput),eye(pOutput);...
        zeros(size(Phi,1) - pOutput,mInput),L];
Phi = Phitmp;
Gamma = Gammatmp;






