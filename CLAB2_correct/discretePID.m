% Test different sampling times
Ts = 0.001; 
% Ts = 0.01; 
% Ts = 0.05;
z = tf('z', Ts);

% 1st test 
% % B-Euler
% s = (1-z^-1)/Ts;

% 2nd test
% % F-Euler
% s = (z-1)/Ts;
 
% sysC_d = Kp+Ki/s+Kd*s/(Tl*s+1);
% sysC_d = minreal(sysC_d)

% % Check BE
% sysC_PID = Kp + Ki*Ts*z/(z-1) + Kd*(z-1)/((Tl+Ts)*z-Tl);
% sysC_PID = minreal(sysC_PID)

% 3rd test
% % Tustin
% sysC_d = c2d(sysC_rd, Ts, 'tustin')

% 4th test (optional)
% Exact Zero-order Hold in emulating C(s)
sysC_d = c2d(sysC_rd, Ts, 'zoh')


% tf of the controller: numerator and denominator
[numC_d, denC_d] = tfdata(sysC_d, 'v')