%assignment 2.1.2 (6) (7)

%FORWARD EULER DISCRETIZATION, INTEGRAL ACTION SS, REDUCED ORDER OBSERVER

%(6)

clear all;

%sample time
Ts = 0.001;

setup_state_space();

% Discrete estimator
% FE
Fo = 1 + Ao*Ts;
Go = Bo*Ts;
Ho = Co;
Jo = Do;

open_system('IntActDiscreteRegulator');