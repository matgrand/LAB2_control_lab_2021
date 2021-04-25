
%assignment 2.1.2 (9a) BACKWARD EULER

%BACKWARD EULER DISCRETIZATION, REDUCED ORDER OBSERVER

%(9aa)
clear all;

%sample time
Ts = 0.001;

continous_state_space();

reduced_order_estimator_cont_ss();

% Backward euler discretization estimator
Fo = (1-Ao*Ts)^-1;
Go = Fo*Bo*Ts;
Ho = Co*Fo;
Jo = Do+Co*Fo*Bo*Ts;

open_system('regulatorDTcase');
