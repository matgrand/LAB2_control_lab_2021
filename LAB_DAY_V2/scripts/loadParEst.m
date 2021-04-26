%% ATTENTION ppr "MOTORE 8"  and "MOTORE 10"
% for other motors sens.enc.deg2pulse = 500*4
% for "MOTORE8" and "MOTORE 10" sens.enc.deg2pulse = 1024*4
load_params_inertial_case_1;
load ./EstParam/JeqEst.mat
load ./EstParam/BeqTauSfEst.mat
Req = mot.R + sens.curr.Rs;
Beq = BeqEst;
Jeq = JeqEst;
mld.tausf = tauSfEst;