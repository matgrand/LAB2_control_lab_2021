%Assignment 2.1.2 6

%to set up parameters:
RobustTrackInt();
regulatorDT();

% Discrete-time sate space controller with integral action
poles_Ked = [exp(lc1*Ts), exp(lc2*Ts), exp(lc3*Ts)];
Fe = [1 Cd; zeros(2,1) Ad];
Ge = [0; Bd];
Ked = place(Fe, Ge, poles_Ked);
Kid = Ked(1);
Ke_d = [Ked(2) Ked(3)];