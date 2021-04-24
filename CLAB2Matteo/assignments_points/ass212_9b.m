%assignment 2.1.2 (9b) TUSTIN

%TUSTIN DISCRETIZATION, INTEGRAL ACTION SS, REDUCED ORDER OBSERVER

%(9b)
clear all;

%sample time
Ts = 0.01;

setup_state_space();

% BE
Fo = (1+Ao*Ts/2)*(1-Ao*Ts/2)^-1;
Go = (1-Ao*Ts/2)^-1*Bo*sqrt(Ts);
Ho = sqrt(Ts)*Co*(1-Ao*Ts/2)^-1;
Jo = Do+Co*(1-Ao*Ts/2)^-1*Bo*Ts*0.5;

open_system('IntActDiscreteRegulator');




