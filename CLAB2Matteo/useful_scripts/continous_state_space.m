%CREATES A STATE SPACE MODEL OF THE MOTOR AND ITS CONTROLLER

%NEED NOTHING BEFORE

initialize_vars();


%if t_sett and Mpk doesn't exist use defaults
if exist('t_sett', 'var') == 1
else
    t_sett = 0.15;   %0.1
end
if exist('Mpk', 'var') == 1
else
    Mpk = 0.10;  %0.08
end

%regulatorCT();
A = [0 1; 0 -1/Tm];
B = [0; km/(gbox.N*Tm)];
C = [1 0];
D = 0;
wc = 2*pi*50;
delta = 1/sqrt(2);

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
Nx = [N(1); N(2)];
Nu = N(3);
