
%%DESIGN BY EMULATION - PID - NOMINAL PARAM.
loadParNominal;
PIDDigital;
finalValue = 50;
T1 = 0.001;
T2 = 0.01;
T3 = 0.05;
tmpTs = [T1 T2 T3];

stop_time = '1';
pause_time = 4;

%PID
% k = 1 -> BE
% k = 2 -> FE
% k = 3 -> tustin
% k = 4 -> zoh

% j = 1 -> T1
% j = 2 -> T2
% j = 3 -> T3

PIDScript;

Tw = ts5 / 5;
Kw = 1/Tw;
finalValue = 360;
stop_time = '1';
pause_time = 3;

%AntiWindup

PIDAntiWindupScript;

loadParEst;

Tw = ts5 / 5;
Kw = 1/Tw;
stop_time = '1';
pause_time = 3;
%FeedFoward

PIDFeedFowardScript

%%DESIGN BY EMULATION - STATE SPACE - EST PARAM.

StateSpaceControllerNominalDigital;
finalValue = 50;
stop_time = '1';
pause_time = 3;
%SSNominal
SSNominalScript;

%SSRobust
StateSpaceControllerRobustDigital;

SSRobustScript;

%%DIRECT DESIGN - STATE SPACE - EST PARAM.

%SSNominal

SSNominalScripDirectDigital;

%SSRobust

SSRobustScripDirectDigital;