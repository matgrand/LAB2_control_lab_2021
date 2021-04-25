
%assignmente 2.2 (1) (2) (3)

%(1) discretize the tf of the motor with zoh
%(2) design a discrete time state space observer and controller for nominal tracking
%(3) test in simulation

clear all;
initialize_vars();

%SAMPLE TIME
Ts = 0.001;

%create the continous state space for the motor
continous_state_space();

%reduced order cont time estimator
reduced_order_estimator_cont_ss();

%dicretize the state space
discretize_state_space();

%discretize estimator
reduced_order_estimator_disc_ss();

%(3)
open_system('SSDiscreteDirect');



















