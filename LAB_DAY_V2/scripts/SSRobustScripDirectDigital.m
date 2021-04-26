for j = 1:3
    Ts = tmpTs(j);
    StateSpaceControllerRobustDirectDigital;
    open_system('ExperimentSSRobustModelDirectDigital');
    
    set_param('ExperimentSSRobustModelDirectDigital','StopTime',stop_time)
    
    set_param('ExperimentSSRobustModelDirectDigital','SimulationMode','external')
    set_param('ExperimentSSRobustModelDirectDigital','SimulationCommand','connect')
    set_param('ExperimentSSRobustModelDirectDigital','SimulationCommand','start');
    
    
    save_system('ExperimentSSRobustModelDirectDigital')
    disp('ExperimentSSRobustModelDirectDigital')
    pause(pause_time);
     
    close_system('ExperimentSSRobustModelDirectDigital');
    out.ScopeThl = ScopeThl;
    out.ScopeDataIa = ScopeDataIa;
    out.ts5 = ts5;
    out.Mp = Mp;
    out.Nu = Nu;
    out.Nx = Nx;
    out.p = p;
    out.Ke = Ke;
    out.estP = estP;
    out.L = L;
    out.Ts = Ts;
    saver(strcat('ExperimentSSRobustModelDirectDigital'),out);
    clear out;
end