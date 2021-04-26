function [CInt,CDer] = discretizedPID(method,Ts,Tl)
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    if strcmp(method,'FE')
        z = tf('z',Ts);
        s = (z-1)/Ts;
        CFEDer = s/(Tl*s + 1);
        CDer = minreal(CFEDer);
        CFEInt = 1/s;
        CInt = minreal(CFEInt);
    elseif strcmp(method,'BE')
        z = tf('z',Ts);
        CBEDer = (z-1)/((Tl+Ts)*z-Tl);
        CDer = minreal(CBEDer);
        CBEInt = (Ts*z)/(z-1);
        CInt = minreal(CBEInt);
    elseif strcmp(method,'tustin')
        s = tf('s');
        CTustinDer = c2d(s/(Tl*s + 1),Ts,'tustin');
        CDer = minreal(CTustinDer);
        CTustinInt = c2d(1/s,Ts,'tustin');
        CInt = minreal(CTustinInt);
    elseif strcmp(method,'zoh')
        s = tf('s');
        CZohDer = c2d(s/(Tl*s + 1),Ts,'zoh');
        CDer = minreal(CZohDer);
        CZohInt = c2d(1/s,Ts,'zoh');
        CInt = minreal(CZohInt);
    else
        disp('ERROR : Insert a proper method');
    end
end

