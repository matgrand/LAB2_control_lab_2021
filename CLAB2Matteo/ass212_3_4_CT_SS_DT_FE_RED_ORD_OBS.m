
%assignment 2.1.2 (3) (4)

%FORWARD EULER DISCRETIZATION REDUCED ORDER OBSERVER

%(3)

clear all;

%initialize variables
initialize_vars();

%sample time
Ts = 0.01;

%create the continous state space for the motor
continous_state_space();

%reduced order cont time estimator
reduced_order_estimator_cont_ss();

% FORWARD euler Discrete estimator
Fo = 1 + Ao*Ts;
Go = Bo*Ts;
Ho = Co;
Jo = Do;

open_system('regulatorDTcase');















