
%ass 2.1.1 (5) (c) EXACT

%repeat (1) and (2) using alternative discretizations: (a) forward euler
% (b) tustin, (c) exact

%(5) (c)

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

% 4th test (optional)
% % Exact Zero-order Hold in emulating C(s)
sysC_d = c2d(sysC_rd, Ts, 'zoh')

[numC_d, denC_d] = tfdata(sysC_d, 'v')


%run simulink
open_system('discretePIDTustinExact');