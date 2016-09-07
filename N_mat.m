function [Nmat,dNmat]=N_mat(Nfct,sel)

    Nmat = [Nfct(1) 0 Nfct(2) 0 Nfct(3) 0 Nfct(4) 0; 0 Nfct(1) 0 Nfct(2) 0 Nfct(3) 0 Nfct(4)];

    
    if sel == 1
        dNmat=[-0.5 0 0.5 0 0 0 0 0; 0 -0.5 0 .5 0 0 0 0];
    elseif sel== 2
        dNmat=[0 0 -0.5 0 0.5 0 0 0; 0 0 0 -0.5 0 0.5 0 0];
    elseif sel == 3
        dNmat=[0 0 0 0 0.5 0 -0.5 0; 0 0 0 0 0 0.5 0 -0.5];
    elseif sel ==4
        dNmat=[-0.5 0 0 0 0 0 0.5 0; 0 -0.5 0 0 0 0 0 0.5];
    else
        error('Mmat error');
    end
    
end
	