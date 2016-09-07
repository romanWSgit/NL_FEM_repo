%-------------------------------------------------------------------------
% assembl.m
%-------------------------------------------------------------------------
%
% Funktion zur assemblierung des Gleichungssystems
%
% --- Parameter -----------------------------------------------------------
%
% EINGABE:  kk .......Linker Knoten
%           k ........lokale Steifigkeitsmatrix
%           pos ......Position an der eingefügt wird
% AUSGABE:  kk .......globale Steifigkeitsmatrix
%           
% 
%=========================================================================


function[kk] = assembl(kk,k,pos)
	edof=length(pos);
	for i=1:edof
		ii=pos(i);
		for j=1:edof
			jj=pos(j);
			kk(ii,jj)=kk(ii,jj)+k(i,j);
		end
	end
end