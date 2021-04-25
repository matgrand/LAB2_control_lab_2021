% CREATES A DISCRETE TIME REDUCED ORDER ESTIMATOR FOR THE DISC. T. SS

% NEEDS reduced_order_estimator_cont_ss 
% NEEDS discretize_state_space 


% Reduced-order discrete observer
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
b = [0; 0; 1];
Nd = S\b;
Nd_x = [Nd(1) Nd(2)];
Nd_u = Nd(3);