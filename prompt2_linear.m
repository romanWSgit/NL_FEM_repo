function [RB_Sperre,F_Kanten,t_x]=prompt2_linear() 

    prompt = {'Gesperrte Knoten:','Belastete Kanten:',...
        'Lastvektor:'};
    dlg_title = 'Rand und Belastung';
    num_lines = [1 60];
    %defaultans = {'1 7 13 19 25','25 26; 26 27; 27 28; 28 29; 29 30;','0 -1000; 0 -500; 0 -500; 0 -500; 0 -1000;'};
    defaultans = {'1 2','2 4; 3 4;','0 -1/sqrt(2);  0 2/sqrt(5)'};
    options.Resize = 'on';
    x2 = inputdlg(prompt,dlg_title,num_lines,defaultans,options);

    RB_Sperre=[str2num(x2{1,:})];
    F_Kanten=[str2num(x2{2,:})];
    t_x=[str2num(x2{3,:})];

end