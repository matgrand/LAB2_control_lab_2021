%% ATTENTION ppr "MOTORE 8"  and "MOTORE 10"
% for other motors sens.enc.deg2pulse = 500*4
% for "MOTORE8" and "MOTORE 10" sens.enc.deg2pulse = 1024*4
load_params_resonant_case;
load ./EstParam/BeqTauSfEst.mat
mld.tausf = tauSfEst;
Beq = BeqEst;
Req = mot.R + sens.curr.Rs;
%mld.Jh = 6.84e-4 alumininum
%mld.Bb = 1.4e-3 alumininum
%mld.Jh = 5.1e-4 Quanser
%mld.Bb = 2.0e-3 Quanser
Ts = 0.001;
Jeq = mot.J+(mld.Jh/gbox.N1^2);