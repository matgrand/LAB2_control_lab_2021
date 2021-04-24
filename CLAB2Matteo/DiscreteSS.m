%initialize variables
load_params_inertial_case();
controldesign();

%state space regulator in continous time
regulatorCT();

Ts = 0.001; 
% Ts = 0.01; 
% Ts = 0.05;

% Discrete state-space model
ss_CT = ss(A, B, C, D);
ss_DT = c2d(ss_CT, Ts, 'zoh');
[Ad, Bd, Cd, Dd] = ssdata(ss_DT);

% Reduced-order observer
polesL_d = exp(lo*Ts);
Ld = place(Ad(2,2), Ad(1,2), polesL_d);
Phi_o = Ad(2,2)-Ld*Ad(1,2);
Gam_o = [Bd(2)-Ld*Bd(1), Phi_o*Ld+Ad(2,1)-Ld*Ad(1,1)];
H_o = [0; 1];
J_o = [0 1;0 Ld];

% Controller
polesK_d = [exp(l1*Ts), exp(l2*Ts)];
Kd = place(Ad, Bd, polesK_d);
S = [Ad-eye(2) Bd; Cd 0];
Nd = S\b;
Nd_x = [Nd(1) Nd(2)];
Nd_u = Nd(3);