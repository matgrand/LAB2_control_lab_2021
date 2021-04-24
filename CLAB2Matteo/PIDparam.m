Kp = delta_K*cos(delta_phi)
Ki = Kp/Ti
Kd = Kp*Td
Tw = ts_5/5;
Kw = 1/Tw % anti wind-up

% Controller PID
s = tf('s');
sysC = Kp*(1+(1/(Ti*s))+Td*s);
sysC_rd = Kp+Ki/s+Kd*s/(Tl*s+1);
[num_C, den_C] = tfdata(sysC, 'v');