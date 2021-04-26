clear;
loadParNominal;

alpha = 5;
ts5 = 0.15;
Mp = 0.1;

km = drv.dcgain*mot.Kt/(Req*Beq + mot.Kt*mot.ke);

Tm = Req*Jeq/(Req*Beq+mot.Kt*mot.ke);

s = tf('s');
P = (km/gbox.N1)/(Tm*s+1)/s;

delta = log(1/Mp)/sqrt(pi^2+(log(1/Mp))^2);
phm = atan((2*delta)/(sqrt(sqrt(1+4*(delta)^4)-2*(delta)^2)));

wgc = 3/(delta*ts5);
Tl = 1/(2*wgc);

[Kp,Ki,Kd] = PIDesigner("PID",P,wgc,phm,alpha);