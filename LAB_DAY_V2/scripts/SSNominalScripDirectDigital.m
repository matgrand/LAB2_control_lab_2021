for j = 1:3
    Ts = tmpTs(j);
    StateSpaceControllerNominalDirectDigital;
    open_system('ExperimentSSNominalModelDirectDigital');
    
    set_param('ExperimentSSNominalModelDirectDigital','StopTime',stop_time)
    
    set_param('ExperimentSSNominalModelDirectDigital','SimulationMode','external')
    set_param('ExperimentSSNominalModelDirectDigital','SimulationCommand','connect')
    set_param('ExperimentSSNominalModelDirectDigital','SimulationCommand','start');
    
    
    save_system('ExperimentSSNominalModelDirectDigital')
    disp('ExperimentSSNominalModelDirectDigital')
    pause(pause_time);
    
    close_system('ExperimentSSNominalModelDirectDigital');
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
    saver(strcat('ExperimentSSNominalModelDirectDigital'),out);
    clear out;
end