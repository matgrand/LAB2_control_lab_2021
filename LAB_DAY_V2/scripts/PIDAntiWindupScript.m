for k = 1:4
    for j = 1:3
        for l = 1:2
            if l == 1
                antiWindup = 'YesAntiWindup';
            else
                antiWindup = 'NoAntiWindup';
                Kw = 0;
            end
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
            elseif k == 4
                method = 'zoh';
                [CInt,CDer] = discretizedPID(method,Ts,Tl);
            end
            open_system('ExperimentModelPIDAntiwindupDigital');
            set_param('ExperimentModelPIDAntiwindupDigital','SimulationMode','external')
            
            set_param('ExperimentModelPIDAntiwindupDigital','StopTime',stop_time)
            
            set_param('ExperimentModelPIDAntiwindupDigital','SimulationCommand','connect')
            set_param('ExperimentModelPIDAntiwindupDigital','SimulationCommand','start');
            
            save_system('ExperimentModelPIDAntiwindupDigital')
            disp('ExperimentModelPIDAntiwindupDigital')
            pause(pause_time);
%             while strcmp('stopped',get_param('ExperimentModelPIDAntiwindupDigital','SimulationStatus'))
%                 disp('waiting')
%                 pause(2);
%             end
            close_system('ExperimentModelPIDAntiwindupDigital');
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
            saver(strcat('ExperimentModelPIDAntiwindupDigital',method,antiWindup),out);
            clear out;
        end
    end
end