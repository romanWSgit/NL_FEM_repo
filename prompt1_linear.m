function [a,b,P1,P2,P3,P4]=prompt1_linear() 

    prompt = {'Netzfeinheit horizontal:','Netzfeinheit vertical:',...
        'Berandung P1:', 'Berandung P2:', 'Berandung P3:', 'Berandung P4:'};
    dlg_title = 'Geometrie und Netz';
    num_lines = [1 36];
    defaultans = {'6','6','0 0','48 44','48 60','0 44'};
    options.Resize = 'on';
    x1 = inputdlg(prompt,dlg_title,num_lines,defaultans,options);

    a=str2num(x1{1,:});
    b=str2num(x1{2,:});
    P1=str2num(x1{3,:});
    P2=str2num(x1{4,:});
    P3=str2num(x1{5,:});
    P4=str2num(x1{6,:});

end