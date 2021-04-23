function [Kp,Ki,Kd] = PIDesigner(type,P,wgc,phm,alpha)
    Pjw = freqresp(P,wgc);
    deltaK = 1/abs(Pjw);
    deltaPhm =  -pi + phm - angle(Pjw);
    Kp = deltaK*cos(deltaPhm);
    if type == "PID"
        Td = (tan(deltaPhm)+sqrt(tan(deltaPhm)^2 + 4/alpha))/(2*wgc);
        Ti = alpha*Td;
        Kd = Kp*Td;
        Ki = Kp/Ti;
    elseif type == "PI" || type == "PD"
        if type == "PD"
            Kd = deltaK*sin(deltaPhm)/wgc;
            Ki = 0;
        else
            Ki = -wgc*deltaK*sin(deltaPhm);
            Kd = 0;
        end
    end
    
end