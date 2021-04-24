% Saver per la prima sezione di test

discretePID.T_sampl = Ts;
discretePID.controller = sysC_d;
discretePID.Kp = Kp;
discretePID.Ki = Ki;
discretePID.Kd = Kd;
discretePID.Tl = Tl;