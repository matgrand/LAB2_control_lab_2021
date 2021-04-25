%THIS ADDS INTEGRAL ACTION TO A CONTINOUS SATE SPACE [A B C D]

% NEEDS continous_state_space

% Robust tracking with integral action
% Extended sate-space model
Ae = [0 C; zeros(2,1) A];
Be = [0; B];
sigma = -dump*wn;
wd = wn*sqrt(1-dump^2);

% poles 
lc1 = sigma+1i*wd; lc2 = sigma-1i*wd; lc3 = sigma;
%lc1 = sigma; lc2 = lc1; lc3 = lc1;
%lc1 = 2*sigma+1i*wd; lc2 = 2*sigma-1i*wd; lc3 = 2*sigma;
%lc1 = 2*sigma+1i*wd; lc2 = 2*sigma-1i*wd; lc3 = 3*sigma;
p_e = [lc1 lc2 lc3];

% controller
Ke = acker(Ae, Be, p_e);
K_I = Ke(1);
K_e = [Ke(2) Ke(3)];