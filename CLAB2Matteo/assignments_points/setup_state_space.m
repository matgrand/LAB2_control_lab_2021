%initialize variables
load_params_inertial_case();
controldesign();

%regulatorCT();

A = [0 1; 0 -1/Tm];
B = [0; km/(gbox.N*Tm)];
C = [1 0];
D = 0;
wc = 2*pi*50;
delta = 1/sqrt(2);
t_sett = 0.1;
Mpk = 0.08;
dump = (log(1/Mpk))/sqrt(pi^2+(log(1/Mpk))^2);
wn = 3/(dump*t_sett);
l1 = -dump*3*wn+1i*3*wn*sqrt(1-dump^2);
l2 = -dump*3*wn-1i*3*wn*sqrt(1-dump^2);
p = [l1 l2];
% controller
K = place(A, B, p);
F = [A B; C 0];
b = [0; 0; 1];
N = F\b;
Nx = [N(1) N(2)];
Nu = N(3);

% reduced order estimator
lo = -5*wn; %*sqrt(1-dump^2);
A22 = -1/Tm;
A12 = 1;
L = place(A22, A12, lo)
Ao = A22-L;
Bo = [km/(gbox.N*Tm), ((-1/Tm)-L)*L];
Co = [0; 1];
Do = [0, 1; 0, L];

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