%%DESIGN BY EMULATION - PID - NOMINAL PARAM.
loadParNominal;
PIDDigital;
finalValue = 50;
T1 = 0.001;
T2 = 0.01;
T3 = 0.05;
tmpTs = [T1 T2 T3];
%PID
% k = 1 -> BE
% k = 2 -> FE
% k = 3 -> tustin
% k = 4 -> zoh

% j = 1 -> T1
% j = 2 -> T2
% j = 3 -> T3

stop_time = '5';
pause_time = 10;



for k = 1:4                                             % try all method (BE, FE, tustin and zoh)
    for j = 1:3                                         % try all sample time
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
        open_system('ExperimentModelPIDDigital');
        set_param('ExperimentModelPIDDigital','SimulationMode','external')
        
        set_param('ExperimentModelPIDDigital','StopTime',stop_time)
        
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

Tw = ts5 / 5;
Kw = 1/Tw;
finalValue = 360;
stop_time = '5';
pause_time = 10;

%AntiWindup
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
            set_param('ExperimentModelPIDAntiwindupDigital','StopTime',stop_time)
            
            set_param('ExperimentModelPIDAntiwindupDigital','SimulationMode','external')
            set_param('ExperimentModelPIDAntiwindupDigital','SimulationCommand','connect')
            set_param('ExperimentModelPIDAntiwindupDigital','SimulationCommand','start');
            
            
            save_system('ExperimentModelPIDAntiwindupDigital')
            disp('ExperimentModelPIDAntiwindupDigital')
            pause(pause_time);
            
            
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

loadParEst;

Tw = ts5 / 5;
Kw = 1/Tw;
stop_time = '5';
pause_time = 10;

%FeedFoward
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

%%DESIGN BY EMULATION - STATE SPACE - EST PARAM.

StateSpaceControllerNominalDigital;
finalValue = 50;
stop_time = '5';
pause_time = 10;

%SSNominal
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

%SSRobust
StateSpaceControllerRobustDigital;
stop_time = '5';
pause_time = 10;

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
        set_param('ExperimentSSRobustModelDigital','SimulationMode','external')
        set_param('ExperimentSSRobustModelDigital','StopTime',stop_time)
        
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


%%DIRECT DESIGN - STATE SPACE - EST PARAM.

%SSNominal
stop_time = '5';
pause_time = 10;

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

%SSRobust
stop_time = '5';
pause_time = 10;

for j = 1:3
    Ts = tmpTs(j);
    StateSpaceControllerRobustDirectDigital;
    open_system('ExperimentSSRobustModelDirectDigital');
    set_param('ExperimentSSRobustModelDirectDigital','SimulationMode','external')
    set_param('ExperimentSSRobustModelDirectDigital','StopTime',stop_time)
    
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