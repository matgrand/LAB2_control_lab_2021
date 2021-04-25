
%assignment 2.1.2 (8b)((6)(7))

%EXACT DISCRETIZATION, INTEGRAL ACTION SS, REDUCED ORDER OBSERVER

%(8b)

clear all;

%sample time
Ts = 0.01;

continous_state_space();

reduced_order_estimator_cont_ss();

integral_action_cont_ss();

% exact discretization discrete estimator
sys_obs_CT = ss(Ao, Bo, Co, Do);
sys_obs_DT = c2d(sys_obs_CT, Ts, 'zoh');
[Fo, Go, Ho, Jo] = ssdata(sys_obs_DT);


open_system('IntActDiscreteRegulator');