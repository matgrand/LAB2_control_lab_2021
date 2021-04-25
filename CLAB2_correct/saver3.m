% Saver per la terza sezione di test

discretePID.T_sampl = Ts;

DirectDiscrete.Phi_o = Phi_o;
DirectDiscrete.Gam_o = Gam_o;
DirectDiscrete.H_o = H_o;
DirectDiscrete.J_o = J_o;
DirectDiscrete.polesL = polesL_d;

DirectDiscrete.L = Ld;
DirectDiscrete.Nu = Nd_u;
DirectDiscrete.Nx = Nd_x;
DirectDiscrete.polesK = polesK_d;
DirectDiscrete.K = Kd;

% with integral action 
% DirectDiscrete.K_I = Kid;
% DirectDiscrete.K = Ke_d; 
% DirectDiscrete.polesKe = poles_Ked;