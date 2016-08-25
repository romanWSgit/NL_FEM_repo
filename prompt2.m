function [RB_Sperre,F_Kanten,t_x]=prompt2() 

    prompt = {'Gesperrte Knoten:','Belastete Kanten:',...
        'Lastvektor:'};
    dlg_title = 'Rand und Belastung';
    num_lines = [1 60];
    defaultans = {'1 8 15','19 20; 20 21;','0 -1000; 0 -1000;'};
    %defaultans = {'1 22 45 64','64 65; 65 66; 66 67 ; 67 68; 68 69; 69 70; 70 71; 71 72; 72 73; 73 74; 74 75; 75 76; 76 77; 77 78; 78 79; 79 80; 80 81; 81 82; 82 83; 83 84;','0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5; 0 -5;'};
    options.Resize = 'on';
    x2 = inputdlg(prompt,dlg_title,num_lines,defaultans,options);

    RB_Sperre=[str2num(x2{1,:})];
    F_Kanten=[str2num(x2{2,:})];
    t_x=[str2num(x2{3,:})];

end