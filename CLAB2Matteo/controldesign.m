% Approximated plant 
Req = mot.R + sens.curr.Rs;

Jeq = mot.J + mld.J/gbox.N^2; % 1st test
%Beq = mot.B + mld.B/gbox.N^2;
Beq = 0; % 1st test

BeqEst = 1.0675e-06;  % 1.2195e-06;
JeqEst = 6.7903e-07;  % 5.5489e-07;
tauSfEst = 0.0125;  % 0.0057; 

% Beq = BeqEst; % 2nd test
% Jeq = JeqEst; % 2nd test

km = (mot.Kt*drv.dcgain)/(Req*Beq+mot.Kt*mot.Ke);
num = [km/gbox.N];
Tm = (Req*Jeq)/(Req*Beq+mot.Kt*mot.Ke);
den = [Tm, 1, 0];
sysP = tf(num, den);

% Useful results
ts_5 = 0.08;
Mp = 0.1;
psi = log(1/Mp)/sqrt(pi^2+(log(1/Mp))^2);
wgc_star = 3/(psi*ts_5);
Tl = 1/(2*wgc_star);
phim_star = atan((2*psi)/sqrt(sqrt(1+4*psi^4)-2*psi^2));
[magP_star, phaseP_star_deg] = bode(sysP, wgc_star);
phaseP_star = phaseP_star_deg*deg2rad;

% Parameters for the controller design
delta_K = magP_star^(-1);
delta_phi = -pi+phim_star-phaseP_star;
alpha = 5;
Td = (tan(delta_phi)+sqrt((tan(delta_phi))^2+4/alpha))/(2*wgc_star);
Ti = alpha*Td;