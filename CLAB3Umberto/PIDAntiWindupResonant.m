clear;
loadParNominalHubBeam;

alpha = 4;
ts5 = 0.85;
Mp = 0.30;

s = tf('s');

D1 = Jeq*mld.Jb*s^3 + (Jeq*mld.Bb+mld.Jb*Beq)*s^2 +(Beq*mld.Bb+mld.k*(Jeq+(mld.Jb)/gbox.N1^2))*s +mld.k*(Beq+(mld.Bb)/gbox.N1^2);

PuOh = drv.dcgain*mot.Kt*(mld.Jb*s^2+mld.Bb*s+mld.k)/gbox.N1/s/(Req*D1+mot.Kt*mot.ke*(mld.Jb*s^2+mld.Bb*s+mld.k));

delta = log(1/Mp)/sqrt(pi^2+(log(1/Mp))^2);
phm = atan((2*delta)/(sqrt(sqrt(1+4*(delta)^4)-2*(delta)^2)));

wgc = 3/(delta*ts5);
Tl = 1/(10*wgc);

[Kp,Ki,Kd] = PIDesigner("PID",PuOh,wgc,phm,alpha);

Tw = ts5 / 5;
Kw = 1/Tw;