
%assignment 2.1.2 (9a) BACKWARD EULER

%BACKWARD EULER DISCRETIZATION, INTEGRAL ACTION SS, REDUCED ORDER OBSERVER

%(9ab)
clear all;

%sample time
Ts = 0.01;

continous_state_space();

reduced_order_estimator_cont_ss();

integral_action_cont_ss();

% Backward euler discretization estimator
Fo = (1-Ao*Ts)^-1;
Go = Fo*Bo*Ts;
Ho = Co*Fo;
Jo = Do+Co*Fo*Bo*Ts;

open_system('IntActDiscreteRegulator');
