% state space nominal tracking (same as Lab1)
A = [0, 1; 0, -1/Tm];
B = [0; km/(gbox.N*Tm)];
C = [1, 0];

Nxu = inv([A, B; C, 0]);
Nx = [Nxu(1,3); Nxu(2,3)];
Nu = Nxu(3,3);

t_sett_5 = 0.08;
Mp = 0.1;
dump = log(1/Mp) / sqrt(pi^2 + log(1/Mp)^2);
wn = 3/(dump * t_sett_5);

p0 = (-dump*wn) + 1i*(wn*sqrt(1-dump^2));
p = [p0, conj(p0)];
K = place(A, B, p);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% continuous-time reduced order observer
eig_o = -5*wn;
% T=I
A12 = 1;
A22 = -1/Tm;
Lc = place(A22, A12, eig_o);
Ao = -1/Tm -Lc;
Bo = [km/(gbox.N*Tm), (-1/Tm -Lc)*Lc];
Co = [0;1];
Do = [0, 1; 0, Lc];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% integral action with exo-system for step reference
Ae = [[zeros(1), C]; [zeros(2,1), A]];
Be = [0; B];
Ce = [0, C];

sigma  = -dump*wn;
wd = wn*sqrt(1-dump^2);
poles_Ke = [sigma + 1i*wd, sigma - 1i*wd, sigma];
% poles_Ke = [2*sigma + 1i*wd, 2*sigma - 1i*wd, 3*sigma];
% poles_Ke = [sigma, sigma, sigma];
% poles_Ke = [1.5*sigma + 1.5*1i*wd, 0.5*sigma - 0.2*1i*wd, sigma];

Ke = acker(Ae, Be, poles_Ke);
K_robust = [Ke(2), Ke(3)];
Ki_robust = Ke(1);
