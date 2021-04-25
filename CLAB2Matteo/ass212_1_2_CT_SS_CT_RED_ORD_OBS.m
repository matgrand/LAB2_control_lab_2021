
%assignment 2.1.2 (1) (2)

%continous time reduced order observer and simulation
%with 40 70 and 120 deg step

%(1)

clear all;
%initialize variables
initialize_vars();

%sample time
Ts = 0.001;

%create the continous state space for the motor
continous_state_space();

%reduced order cont time estimator
reduced_order_estimator_cont_ss();

open_system('regulatorCTcase');
