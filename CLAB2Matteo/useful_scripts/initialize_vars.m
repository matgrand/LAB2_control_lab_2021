load_params_inertial_case();

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