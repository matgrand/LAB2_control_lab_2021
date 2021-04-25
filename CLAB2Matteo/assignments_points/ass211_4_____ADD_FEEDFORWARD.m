
%assignment 2.1.1 (4) (OPTIONAL)
%PID + FEEDFORWARD and simulation


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

%sampling time at 10 ms
Ts = 0.01; 
z = tf('z', Ts);

% 1st test 
% B-Euler
s = (1-z^-1)/Ts;

sysC_d = Kp+Ki/s+Kd*s/(Tl*s+1);
sysC_d = minreal(sysC_d)

[numC_d, denC_d] = tfdata(sysC_d, 'v')

%run simulink
open_system('discretePIDmodelFF');