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
        open_system('ExperimentSSRobustModelDigital');
        
        set_param('ExperimentSSRobustModelDigital','StopTime',stop_time)
        
        set_param('ExperimentSSRobustModelDigital','SimulationMode','external')
        set_param('ExperimentSSRobustModelDigital','SimulationCommand','connect')
        set_param('ExperimentSSRobustModelDigital','SimulationCommand','start');
        
        
        save_system('ExperimentSSRobustModelDigital')
        disp('ExperimentSSRobustModelDigital')
        pause(pause_time);
        
        close_system('ExperimentSSRobustModelDigital');
        out.ScopeThl = ScopeThl;
        out.ScopeDataIa = ScopeDataIa;
        out.ts5 = ts5;
        out.Mp = Mp;
        out.Nu = Nu;
        out.Nx = Nx;
        out.p = p;
        out.Ke = Ke;
        out.estP = estP;
        out.p4 = p4;
        out.L = L;
        out.Ts = Ts;
        saver(strcat('ExperimentSSRobustModelDigital',method),out);
        clear out;
    end
end