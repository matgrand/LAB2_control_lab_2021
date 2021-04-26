
for k = 1:10
    open_system('sldrtex_model');
    set_param('sldrtex_model','SimulationMode','external');
    set_param('sldrtex_model','SimulationCommand','connect');
    set_param('sldrtex_model','SimulationCommand','start');
    while not(strcmp('stopped',get_param('sldrtex_model','SimulationStatus')))
    pause(2);
    end
    close_system('sldrtex_model');
    out.ScopeData = ScopeData;
    out.ScopeData1 = ScopeData1;
    saver(strcat('sldrtex_model'),out);
   
end