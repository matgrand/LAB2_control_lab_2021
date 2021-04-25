% Sampling time
Ts = 0.001;
% Ts = 0.01; 
% Ts = 0.05;

A = [0, 1; 0, -1/Tm];
B = [0; km/(gbox.N*Tm)];
C = [1, 0];
D = 0;

% exact discretization of (A,B,C,D)
CONT_ss = ss(A, B, C, D);
DISC_ss = c2d(CONT_ss, Ts, 'zoh');
[F, G, H, J] = ssdata(DISC_ss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% discrete-time state-space control law
Nxu = [F-eye(size(F)), G; H, 0]\[0; 0; 1];
Nx = [Nxu(1); Nxu(2)];
Nu = Nxu(3);

t_sett_5 = 0.08;
Mp = 0.1;
dump = log(1/Mp) / sqrt(pi^2 + log(1/Mp)^2);
wn = 3/(dump * t_sett_5);

cont_p0 = (-dump*wn) + 1i*(wn*sqrt(1-dump^2));
disc_p0 = exp(cont_p0*Ts);
p = [disc_p0, conj(disc_p0)];
K = place(F, G, p);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% discrete-time reduced order observer
eig_cont = -5*wn;
eig_disc = exp(Ts*eig_cont);
Ld = place(F(2,2), F(1,2), eig_disc);
Fo = F(2,2)-Ld*F(1,2);
Go = [G(2)-Ld*G(1), Fo*Ld+F(2,1)-Ld*F(1,1)];
Ho = [0;1];
Jo = [0, 1; 0, Ld];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% discrete-time state-space control law with integral action
% Nu, Nx and the observer are the same
Fe = [1, H; zeros(2,1), F];
Ge = [0; G];

sigma  = -dump*wn;
wd = wn*sqrt(1-dump^2);
poles_Ke = [sigma + 1i*wd, sigma - 1i*wd, sigma];
% poles_Ke = [2*sigma + 1i*wd, 2*sigma - 1i*wd, 3*sigma];
% poles_Ke = [sigma, sigma, sigma];
% poles_Ke = [1.5*sigma + 1.5*1i*wd, 0.5*sigma - 0.2*1i*wd, sigma];
poles_Ked = exp(poles_Ke*Ts);

Ked = place(Fe, Ge, poles_Ked);
K_robust = [Ked(2), Ked(3)];
Ki_robust = Ked(1);