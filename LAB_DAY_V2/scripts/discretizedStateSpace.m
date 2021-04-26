function [Phi,Gamma,H,J] = discretizedStateSpace(A,B,C,D,method,Ts)
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    if strcmp(method,'FE')
        Phi = eye(size(A,1)) + A*Ts;
        Gamma = B*Ts;
        H = C;
        J = D;
    elseif strcmp(method,'BE')
        tmp = inv(eye(size(A,1)) - A*Ts);
        Phi = tmp;
        Gamma = tmp*B*Ts;
        H = C*tmp;
        J = D+C*tmp*B*Ts;
    elseif strcmp(method,'tustin')
        tmp = inv(eye(size(A,1)) - (A*Ts)/2);
        Phi = (eye(size(A,1))+(A*Ts)/2)*tmp;
        Gamma = tmp*B*sqrt(Ts);
        H = sqrt(Ts)*C*tmp;
        J = D+C*tmp*B*Ts/2;
    elseif strcmp(method,'zoh')
        sysc = ss(A,B,C,D);
        sysD = c2d(sysc,Ts,'zoh');
        [Phi,Gamma, H, J] = ssdata(sysD);
    else
        disp('ERROR : Insert a proper method');
    end
end

