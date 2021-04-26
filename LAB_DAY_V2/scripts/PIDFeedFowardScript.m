for k = 1:1
    for j = 2:2
        Ts = tmpTs(j);
        if k == 1
            method = 'BE';
            [CInt,CDer] = discretizedPID(method,Ts,Tl);
        elseif k == 2
            method = 'FE';
            [CInt,CDer] = discretizedPID(method,Ts,Tl);
        elseif k == 3
            method = 'tustin';
            [CInt,CDer] = discretizedPID(method,Ts,Tl);
        end
        open_system('ExperimentModelPIDFeedFowardDigital');
        
        
        set_param('ExperimentModelPIDFeedFowardDigital','StopTime',stop_time)
        set_param('ExperimentModelPIDFeedFowardDigital','SimulationMode','external')
        set_param('ExperimentModelPIDFeedFowardDigital','SimulationCommand','connect')
        set_param('ExperimentModelPIDFeedFowardDigital','SimulationCommand','start');
        
        
        save_system('ExperimentModelPIDFeedFowardDigital')
        disp('ExperimentModelPIDFeedFowardDigital')
        pause(pause_time);
        close_system('ExperimentModelPIDFeedFowardDigital');
        out.ScopeThl = ScopeThl;
        out.ScopeDataIa = ScopeDataIa;
        out.ScopeThl = ScopeThl;
        out.ScopeDataIa = ScopeDataIa;
        out.ts5 = ts5;
        out.Mp = Mp;
        out.Ki = Ki;
        out.Kp = Kp;
        out.Kd = Kd;
        out.Tw = Tw;
        out.Tl = Tl;
        out.Ts = Ts;
        out.alpha = alpha;
        saver(strcat('ExperimentModelPIDFeedFowardDigital',method),out);
        clear out;
    end
end