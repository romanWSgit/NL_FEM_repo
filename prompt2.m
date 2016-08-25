function [RB_Sperre,F_Kanten,t_x]=prompt2() 

    prompt = {'Gesperrte Knoten:','Belastete Kanten:',...
        'Lastvektor:'};
    dlg_title = 'Rand und Belastung';
    num_lines = [1 60];
    defaultans = {'1 8 15','19 20; 20 21','0 -1000; 0 -1000'};
    options.Resize = 'on';
    x2 = inputdlg(prompt,dlg_title,num_lines,defaultans,options);

    RB_Sperre=[str2num(x2{1,:})];
    F_Kanten=[str2num(x2{2,:})];
    t_x=[str2num(x2{3,:})];

end