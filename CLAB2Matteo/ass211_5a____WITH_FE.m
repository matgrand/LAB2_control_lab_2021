
%ass 2.1.1 (5) (a)

%repeat (1) and (2) using alternative discretizations: (a) forward euler
% (b) tustin, (c) exact

%(5) (a)

clear all
%load the motor params
load_params_inertial_case();
controldesign(); 

%(1)
%PID CONTROLLER 
% Useful results
ts_5 = 0.08;
Mp = 0.1;

CT_PID();

%sample time
Ts = 0.01;
z = tf('z', Ts);

% 2nd test
% % F-Euler
s = (z-1)/Ts;

sysC_d = Kp+Ki/s+Kd*s/(Tl*s+1);
sysC_d = minreal(sysC_d)

[numC_d, denC_d] = tfdata(sysC_d, 'v')


%run simulink
open_system('discretePIDTustinExact');










