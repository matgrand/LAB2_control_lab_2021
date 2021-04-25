
%assignment 2.1.2 (5)

%CONTINOUS TIME, INTEGRAL ACTION SS, REDUCED ORDER OBSERVER

%(3)

clear all;

%sample time
Ts = 0.001;

%create the continous state space for the motor
continous_state_space();

%reduced order cont time estimator
reduced_order_estimator_cont_ss();

%integral action
integral_action_cont_ss();

open_system('IntActionObserver');