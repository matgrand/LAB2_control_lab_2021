
% assignment 2.2 (4)(5) 

%(4) ADD INTEGRAL ACTION

clear all;

initialize_vars();

%SAMPLE TIME
Ts = 0.001;

%create the continous state space for the motor
continous_state_space();

%reduced order cont time estimator
reduced_order_estimator_cont_ss();

%DISCRETIZATION
%discretize state space
discretize_state_space();

%discretize estimator
reduced_order_estimator_disc_ss();

%INTEGRAL ACTION
%continous integral action (for variables)
integral_action_cont_ss();

%discrete integral action
% Discrete-time sate space controller with integral action
poles_Ked = [exp(lc1*Ts), exp(lc2*Ts), exp(lc3*Ts)];
Fe = [1 Cd; zeros(2,1) Ad];
Ge = [0; Bd];
Ked = place(Fe, Ge, poles_Ked);
Kid = Ked(1);
Ke_d = [Ked(2) Ked(3)];


%(3)
open_system('SSDiscreteRegulatorIntAct');
sim('SSDiscreteRegulatorIntAct');
