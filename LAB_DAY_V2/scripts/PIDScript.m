for k = 1:4                                             % try all method (BE, FE, tustin and zoh)
    for j = 1:3                                         % try all sample time
        Ts = tmpTs(j);
        if k == 1
            method = 'BE';
            [CInt,CDer] = discretizedPID(method,Ts,Tl);
            return;
        elseif k == 2
            method = 'FE';
            [CInt,CDer] = discretizedPID(method,Ts,Tl);
        elseif k == 3
            method = 'tustin';
            [CInt,CDer] = discretizedPID(method,Ts,Tl);
        elseif k == 4
            method = 'zoh';
            [CInt,CDer] = discretizedPID(method,Ts,Tl);
        end
        open_system('ExperimentModelPIDDigital');
        
        set_param('ExperimentModelPIDDigital','StopTime',stop_time)
        
        set_param('ExperimentModelPIDDigital','SimulationMode','external')
        set_param('ExperimentModelPIDDigital','SimulationCommand','connect')
        set_param('ExperimentModelPIDDigital','SimulationCommand','start');
        
        
        save_system('ExperimentModelPIDDigital')
        disp('ExperimentModelPIDDigital')
        pause(pause_time);
        
        close_system('ExperimentModelPIDDigital');
        out.ScopeThl = ScopeThl;
        out.ScopeDataIa = ScopeDataIa;
        out.ts5 = ts5;
        out.Mp = Mp;
        out.Ki = Ki;
        out.Kp = Kp;
        out.Kd = Kd;
        out.Tl = Tl;
        out.Ts = Ts;
        out.alpha = alpha;
        saver(strcat('ExperimentModelPIDDigital',method),out);
        clear out;
    end
end