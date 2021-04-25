%ADDS A CONT TIME REDUCED ORDER ESTIMATOR

% NEEDS continous_state_space

% reduced order estimator
lo = -5*wn; %*sqrt(1-dump^2);
A22 = -1/Tm;
A12 = 1;
L = place(A22, A12, lo)
Ao = A22-L;
Bo = [km/(gbox.N*Tm), ((-1/Tm)-L)*L];
Co = [0; 1];
Do = [0, 1; 0, L];