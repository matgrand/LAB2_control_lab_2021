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
%create the PID constants from the same files
%PIDparam();
%PID GAINS
Kp = delta_K*cos(delta_phi)
Ki = Kp/Ti
Kd = Kp*Td
Tw = ts_5/5;
Kw = 1/Tw % anti wind-up
%PID TF
s = tf('s');
sysC = Kp*(1+(1/(Ti*s))+Td*s);
sysC_rd = Kp+Ki/s+Kd*s/(Tl*s+1);
[num_C, den_C] = tfdata(sysC, 'v');