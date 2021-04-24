%assignment 2.1.2 (8) ((3)(4))

%EXACT DISCRETIZATION REDUCED ORDER OBSERVER

%(8)

clear all;

%sample time
Ts = 0.001;

setup_state_space();

% Discrete estimator
% exact discretization 
sys_obs_CT = ss(Ao, Bo, Co, Do);
sys_obs_DT = c2d(sys_obs_CT, Ts, 'zoh');
[Fo, Go, Ho, Jo] = ssdata(sys_obs_DT);


open_system('regulatorDTcase'); %note: regulatorDTexact is useless 















