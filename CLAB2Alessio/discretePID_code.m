Kp = delta_K*cos(delta_phi);
Ki = Kp/Ti;
Kd = Kp*Td;
Tw = ts_5/5;
Kw = 1/Tw; % anti wind-up

% % lab 1 PID
% Kp = 20.9211;
% Kd = 0.2744;
% Ki = 3.190194e+02;
% Kw = 62.5;

inertia_FF = gbox.N*Req*Jeq/(drv.dcgain*mot.Kt);
friction_FF = Req/(gbox.N*drv.dcgain*mot.Kt);
BEMF_FF = gbox.N*mot.Ke/drv.dcgain;

% Sampling time
Ts = 0.001; 
% Ts = 0.01; 
% Ts = 0.05;
z = tf('z', Ts);

% Backward-Euler
s = (1-z^-1)/Ts;

% % Forward-Euler
% s = (z-1)/Ts;

sysC_rd = Kp+Ki/s+Kd*s/(Tl*s+1);

% % Tustin (trapezioidal)
% sysC_d = c2d(sysC_rd, Ts, 'tustin')

% % Check Backward-Euler
% sysC_PID = Kp + Ki*Ts*z/(z-1) + Kd*(z-1)/((Tl+Ts)*z-Tl);
% sysC_PID = minreal(sysC_PID)

% % Exact (Zero-order Hold)
% sysC_d = c2d(sysC_rd, Ts, 'zoh');
% [numC_d, denC_d] = tfdata(sysC_d, 'v');