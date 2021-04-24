%assignment 2.1.2 (9a) BACKWARD EULER

%BACKWARD EULER DISCRETIZATION, INTEGRAL ACTION SS, REDUCED ORDER OBSERVER

%(9a)
clear all;

%sample time
Ts = 0.01;

setup_state_space();

% BE
Fo = (1-Ao*Ts)^-1;
Go = Fo*Bo*Ts;
Ho = Co*Fo;
Jo = Do+Co*Fo*Bo*Ts;

open_system('IntActDiscreteRegulator');





