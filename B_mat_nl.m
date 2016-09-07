%-------------------------------------------------------------------------
% B_mat_nl.m
%-------------------------------------------------------------------------
% Funktion zur Berechnung der B-Matrix  (nichtlineare FEM Implementierung)
%
% --- Parameter -----------------------------------------------------------
%
% EINGABE:  nnel .........Linker Knoten
%           dNfct_xi .....lokale Steifigkeitsmatrix
%           dNfct_eta ....Position an der eingefügt wird
%           F0............Jacobi-Matrix
%           invF0.........inverse Jacobi-Matrix
%           i.............Knoten
%
% AUSGABE:  B_mat_nl .....globale Steifigkeitsmatrix
%           
% 
%=========================================================================


function [B_mat_nl]=B_mat_nl(nnel,dNfct_xi,dNfct_eta,F0,invF0,l)


    for i=1:nnel
		dNfct_x(i)=invF0(1,1)*dNfct_xi(i)+invF0(1,2)*dNfct_eta(i);
		dNfct_y(i)=invF0(2,1)*dNfct_xi(i)+invF0(2,2)*dNfct_eta(i);
	end


	B_mat_nl=[F0(1,1)*dNfct_x(l)  F0(2,1)*dNfct_x(l) ; ...
        F0(1,2)*dNfct_y(l)  F0(2,2)*dNfct_y(l) ; ...
        F0(1,1)*dNfct_y(l) + F0(1,2)*dNfct_x(l)  F0(2,1)*dNfct_y(l) + F0(2,2)*dNfct_x(l) ];
end
	
