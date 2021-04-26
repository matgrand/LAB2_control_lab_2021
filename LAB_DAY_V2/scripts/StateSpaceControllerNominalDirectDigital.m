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
z = -dampingFactor*wn*3 + 1i*3*wn*sqrt(1-dampingFactor^2);
p = [z,conj(z)]*Ts;
p = exp(p);

[Phi,Gamma,H,J] = discretizedStateSpace(A,B,C,D,'zoh',Ts);

bb = zeros(size(Phi,1),1);
bb = [bb;ones(size(H,1))];
xx = [Phi - eye(size(Phi,1)),Gamma;H,zeros(size(H,1))]\bb;
Nx = xx(1:end-1);
Nx = reshape(Nx,[],1);
Nu = xx(end);
Nu = reshape(Nu,[],1);

K = place(Phi,Gamma,p);

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