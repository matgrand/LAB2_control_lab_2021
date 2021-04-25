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
T1 = 0.001;
T2 = 0.01;
T3 = 0.05;
Ts = T1;
%%%BE
z = tf('z',Ts);
CBE = Kp + Ki*(Ts*z)/(z-1) + Kd*(z-1)/((Tl+Ts)*z-Tl);
CBE = minreal(CBE);
CBEDer = (z-1)/((Tl+Ts)*z-Tl);
CBEDer = minreal(CBEDer);
CBEInt = (Ts*z)/(z-1);
CBEInt = minreal(CBEInt);

%%%FE
s = (z-1)/Ts;

CFE = Kp + Ki/s + Kd*s/(Tl*s + 1);
CFE = minreal(CFE);
CFEDer = s/(Tl*s + 1);
CFE = minreal(CFEDer);
CFEInt = 1/s;
CFEInt = minreal(CFEInt);

%%%Tustin
s = tf('s');
CTustin = c2d(Kp + Ki/s + Kd*s/(Tl*s + 1),Ts,'tustin');
CTustin = minreal(CTustin);
CTustinDer = c2d(s/(Tl*s + 1),Ts,'tustin');
CTustinDer = minreal(CTustinDer);
CTustinInt = c2d(1/s,Ts,'tustin');
CTustinInt = minreal(CTustinInt);

CInt = CTustinInt;
CDer = CTustinDer;
loadParEst;