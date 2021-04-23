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

Tw = ts5 / 5;
Kw = 1/Tw;

T1 = 0.001;
T2 = 0.01;
T3 = 0.05;
Ts = T2;
z = tf('z',Ts);
%%%BE
CBE = Kp + Ki*(Ts*z)/(z-1) + Kd*(z-1)/((Tl+Ts)*z-Tl);
CBE = minreal(CBE);
CBEDer = (z-1)/((Tl+Ts)*z-Tl);
CBEInt = (Ts*z)/(z-1);
%%%FE
s = (z-1)/Ts;

CFE = Kp + Ki/s + Kd*s/(Tl*s + 1);
CFE = minreal(CFE);
CFEDer = s/(Tl*s + 1);
CFE = minreal(CFEDer);
CFEInt = 1/s;

%%%Tustin
s = tf('s');
CTustin = c2d(Kp + Ki/s + Kd*s/(Tl*s + 1),Ts,'tustin');
CTustin = minreal(CTustin);
CTustinDer = c2d(s/(Tl*s + 1),Ts,'tustin');
CTustinDer = minreal(CTustinDer);
CTustinInt = c2d(1/s,Ts,'tustin');
CTustinInt = minreal(CTustinInt);

CInt = CBEInt;
CDer = CBEDer;
loadParEst;