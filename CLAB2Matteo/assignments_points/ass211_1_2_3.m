%assignment 2.1.1 (1)(2)
%(1)Backward euler of PID controller designed in lab0
%(2)Simulink implementation with 50 deg step and 3 different sampling time
%(3)ANTI-WINDUP + simulation

clear all;
%load the motor params
load_params_inertial_case();
controldesign(); 

%(1)
%PID CONTROLLER 
% Useful results
ts_5 = 0.08;
Mp = 0.1;

setup_PID();

% Test different sampling times
Ts = 0.001; 
% Ts = 0.01; 
% Ts = 0.05;
z = tf('z', Ts);

% 1st test 
% B-Euler
s = (1-z^-1)/Ts;

sysC_d = Kp+Ki/s+Kd*s/(Tl*s+1);
sysC_d = minreal(sysC_d)

[numC_d, denC_d] = tfdata(sysC_d, 'v')

%(2)(3)
%run simulink
open_system('discretePIDmodel');

























