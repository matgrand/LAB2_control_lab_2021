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
        set_param('ExperimentModelPIDDigital','SimulationMode','external')
        set_param('ExperimentModelPIDDigital','SimulationCommand','connect')
        set_param('ExperimentModelPIDDigital','SimulationCommand','start');
        while strcmp('stopped',get_param('ExperimentModelPIDDigital','SimulationStatus'))
            pause(2);
        end
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
            set_param('ExperimentModelPIDAntiwindupDigital','SimulationMode','external')
            set_param('ExperimentModelPIDAntiwindupDigital','SimulationCommand','connect')
            set_param('ExperimentModelPIDAntiwindupDigital','SimulationCommand','start');
            while strcmp('stopped',get_param('ExperimentModelPIDAntiwindupDigital','SimulationStatus'))
                pause(2);
            end
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
        set_param('ExperimentModelPIDFeedFowardDigital','SimulationMode','external')
        set_param('ExperimentModelPIDFeedFowardDigital','SimulationCommand','connect')
        set_param('ExperimentModelPIDFeedFowardDigital','SimulationCommand','start');
        while strcmp('stopped',get_param('ExperimentModelPIDFeedFowardDigital','SimulationStatus'))
            pause(2);
        end
        
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
        set_param('ExperimentSSNominalModelDigital','SimulationMode','external')
        set_param('ExperimentSSNominalModelDigital','SimulationCommand','connect')
        set_param('ExperimentSSNominalModelDigital','SimulationCommand','start');
        while strcmp('stopped',get_param('ExperimentSSNominalModelDigital','SimulationStatus'))
            pause(2);
        end
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
        set_param('ExperimentSSRobustModelDigital','SimulationCommand','connect')
        set_param('ExperimentSSRobustModelDigital','SimulationCommand','start');
        while strcmp('stopped',get_param('ExperimentSSRobustModelDigital','SimulationStatus'))
            pause(2);
        end
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

for j = 1:3
    Ts = tmpTs(j);
    StateSpaceControllerNominalDirectDigital;
    open_system('ExperimentSSNominalModelDirectDigital');
    set_param('ExperimentSSNominalModelDirectDigital','SimulationMode','external')
    set_param('ExperimentSSNominalModelDirectDigital','SimulationCommand','connect')
    set_param('ExperimentSSNominalModelDirectDigital','SimulationCommand','start');
    while strcmp('stopped',get_param('ExperimentSSNominalModelDirectDigital','SimulationStatus'))
        pause(2);
    end
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

for j = 1:3
    Ts = tmpTs(j);
    StateSpaceControllerRobustDirectDigital;
    open_system('ExperimentSSRobustModelDirectDigital');
    set_param('ExperimentSSRobustModelDirectDigital','SimulationMode','external')
    set_param('ExperimentSSRobustModelDirectDigital','SimulationCommand','connect')
    set_param('ExperimentSSRobustModelDirectDigital','SimulationCommand','start');
    while strcmp('stopped',get_param('ExperimentSSRobustModelDirectDigital','SimulationStatus'))
        pause(2);
    end
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