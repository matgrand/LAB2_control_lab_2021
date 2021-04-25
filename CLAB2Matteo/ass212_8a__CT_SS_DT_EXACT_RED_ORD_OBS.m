
%assignment 2.1.2 (8) ((3)(4))

%EXACT DISCRETIZATION REDUCED ORDER OBSERVER

%(8)

clear all;

%sample time
Ts = 0.001;

continous_state_space();

reduced_order_estimator_cont_ss();

% Discrete estimator
% exact discretization 
sys_obs_CT = ss(Ao, Bo, Co, Do);
sys_obs_DT = c2d(sys_obs_CT, Ts, 'zoh');
[Fo, Go, Ho, Jo] = ssdata(sys_obs_DT);


open_system('regulatorDTcase'); %note: regulatorDTexact is useless 















