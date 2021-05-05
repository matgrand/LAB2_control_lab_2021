clear;
loadPar;

alpha = 4.7;
ts5 = 0.15;
%Mp = 0.16;
Mp = 0.145;
Req = mot.R + sens.curr.Rs;
%Jeq = mot.J+(mld.J/gbox.N1^2);
load ./EstParam/JeqEst.mat
load ./EstParam/BeqTauSfEst.mat
Beq = BeqEst;
Jeq = JeqEst;
mld.tausf = tauSfEst;
km = drv.dcgain*mot.Kt/(Req*Beq + mot.Kt*mot.ke);

Tm = Req*Jeq/(Req*Beq+mot.Kt*mot.ke);

s = tf('s');
P = (km/gbox.N1)/(Tm*s+1)/s;

delta = log(1/Mp)/sqrt(pi^2+(log(1/Mp))^2);
phm = atan((2*delta)/(sqrt(sqrt(1+4*(delta)^4)-2*(delta)^2)));

wgc = 3/(delta*ts5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tr = 0.0098;
Mp = 0.145;
wgc = 1.8/tr;
Tl = 1/(5*wgc);
%%GOOD PARAMETER

[Kp,Ki,Kd] = PIDesigner("PID",P,wgc,phm,alpha);

Tw = tr / 0.32;
Kw = 1/Tw;
%TrialController;
%Kp = 3.7562;
%Ki = 0.1;
%Kd =0.0675;
% Kp = 37.8152;
% Ki = 1.1459;
% Kd = 0.2578;
% Tl = 1/800;


%C = Kp + Ki/s + Kd*s/(Tl*s+1);
%W = feedback(C*P,1);

%figure
%step(W,10,stepDataOptions('StepAmplitude',10));

%hold on;
%Beq = 2e-6;

%out = sim('WholeModel');
%plot(out.thl_meas.time,out.thl_meas.signals.values);
%stepinfo(W,'SettlingTimeThreshold',0.05)
%stepinfo(out.thl_meas.signals.values,out.thl_meas.time,'SettlingTimeThreshold',0.05)

