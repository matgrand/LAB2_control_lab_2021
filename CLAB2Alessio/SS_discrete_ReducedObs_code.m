% discretization of the continuous-time estimator

SS_continuous_ReducedObs_code();

% Sampling time
Ts = 0.001;
% Ts = 0.01; 
% Ts = 0.05;

% Forward-Euler
% Fo = 1 + Ao*Ts;
% Go = Bo*Ts;
% Ho = Co;
% Jo = Do;

% Exact discretization 
sys_obs_CT = ss(Ao, Bo, Co, Do);
sys_obs_DT = c2d(sys_obs_CT, Ts, 'zoh');
[Fo, Go, Ho, Jo] = ssdata(sys_obs_DT);

% Backward-Euler
% Fo = (1-Ao*Ts)^-1;
% Go = Fo*Bo*Ts;
% Ho = Co*Fo;
% Jo = Do+Co*Fo*Bo*Ts;

% Tustin
% Fo = (1+Ao*Ts/2)*(1-Ao*Ts/2)^-1;
% Go = (1-Ao*Ts/2)^-1*Bo*sqrt(Ts);
% Ho = sqrt(Ts)*Co*(1-Ao*Ts/2)^-1;
% Jo = Do+Co*(1-Ao*Ts/2)^-1*Bo*Ts*0.5;