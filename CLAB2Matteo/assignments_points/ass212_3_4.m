%assignment 2.1.2 (3) (4)

%FORWARD EULER DISCRETIZATION REDUCED ORDER OBSERVER

%(3)

clear all;
%initialize variables
load_params_inertial_case();
controldesign();

%sample time
Ts = 0.001;

setup_state_space();

% Discrete estimator
% FE
Fo = 1 + Ao*Ts;
Go = Bo*Ts;
Ho = Co;
Jo = Do;

open_system('regulatorDTcase');















