A = [0 1; 0 -1/Tm];
B = [0; km/(gbox.N*Tm)];
C = [1 0];
D = 0;
wc = 2*pi*50;
t_sett = 0.15;%0.1;
Mpk = 0.1;%0.08;
dump = (log(1/Mpk))/sqrt(pi^2+(log(1/Mpk))^2);
wn = 3/(dump*t_sett);
l1 = -dump*3*wn+1i*3*wn*sqrt(1-dump^2);
l2 = -dump*3*wn-1i*3*wn*sqrt(1-dump^2);
% l1 = -dump*wn+1i*wn*sqrt(1-dump^2);
% l2 = -dump*wn-1i*wn*sqrt(1-dump^2);
p = [l1 l2];
% controller
K = place(A, B, p);
F = [A B; C 0];
b = [0; 0; 1];
N = F\b;
Nx = [N(1); N(2)];
Nu = N(3);

% reduced order estimator
lo = -5*dump*wn; %*sqrt(1-dump^2);
A22 = -1/Tm;
A12 = 1;
L = place(A22, A12, lo)
Ao = A22-L;
Bo = [km/(gbox.N*Tm), ((-1/Tm)-L)*L];
Co = [0; 1];
Do = [0, 1; 0, L];