for k = 1:2
    for j = 1:3
        Ts = tmpTs(j);
        if k == 1
            method = 'FE';
            [Phi0,Gamma0,H0,J0] = discretizedStateSpace(A0,B0,C0,D0,'FE',Ts);
        elseif k == 2
            method = 'zoh';
            [Phi0,Gamma0,H0,J0] = discretizedStateSpace(A0,B0,C0,D0,'zoh',Ts);
        end
        open_system('ExperimentSSNominalModelDigital');
        
        set_param('ExperimentSSNominalModelDigital','StopTime',stop_time)
        
        set_param('ExperimentSSNominalModelDigital','SimulationMode','external')
        set_param('ExperimentSSNominalModelDigital','SimulationCommand','connect')
        set_param('ExperimentSSNominalModelDigital','SimulationCommand','start');
        
        
        save_system('ExperimentSSNominalModelDigital')
        disp('ExperimentSSNominalModelDigital')
        pause(pause_time);
     
        close_system('ExperimentSSNominalModelDigital');
        out.ScopeThl = ScopeThl;
        out.ScopeDataIa = ScopeDataIa;
        out.ts5 = ts5;
        out.Mp = Mp;
        out.Nu = Nu;
        out.Nx = Nx;
        out.p = p;
        out.K = K;
        out.estP = estP;
        out.L = L;
        out.Ts = Ts;
        saver(strcat('ExperimentSSNominalModelDigital',method),out);
        clear out;
    end
end