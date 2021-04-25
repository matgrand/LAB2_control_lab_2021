
%assignment 2.1.2 (6) (7)

%FORWARD EULER DISCRETIZATION, INTEGRAL ACTION SS, REDUCED ORDER OBSERVER

%(6)

clear all;

%sample time
Ts = 0.001;

continous_state_space();

reduced_order_estimator_cont_ss();

integral_action_cont_ss();

% forward euler discrete estimator
Fo = 1 + Ao*Ts;
Go = Bo*Ts;
Ho = Co;
Jo = Do;

%(7)
open_system('IntActDiscreteRegulator');
