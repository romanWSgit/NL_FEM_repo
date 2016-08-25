
clear all;
close all;
clc

%------------------------------------------
% Netzdimensionen
%------------------------------------------
a=6;                               % Unterteilung in x-Richtung
b=2;                               % Unterteilung in y-Richtung

TKKBound=[1 0; 10 0; 10 3; 1 3];    % Rand des Gebietes
[ne,TKK,EZT]=net_Fct(a,b,TKKBound);  % plotten des Netzes

%------------------------------------------
% Parameter
%------------------------------------------


ne;                                 % Anzahl der Finiten Elemente 	
nnode=(a+1)*(b+1);                  % Anzahl der Knoten
elementNodes=4;                     % Anzahl der Knoten pro Element
nodeDOF=2;                          % Anzahl der Freiheitsgrade pro Knoten
sdof=nnode*nodeDOF;                 % Freiheitsgrade im System
elementDOF=elementNodes*nodeDOF; 	% Freiheitsgrade pro Element
E=210000;                           % E-Modul
nu=0.3;                             % Poissonzahl
ng_x=2;                             % 2x2 Gauss Integration
ng_y=2;                             % 2x2 Gauss Integration



%------------------------------------------
% Randbedingungen
%------------------------------------------

EZT(1,1)
bc_nodes=[1 2 15 15 29 30];		% Angabe der gesperrten Knoten

%------------------------------------------
% Initialisierung
%------------------------------------------


F_vec=zeros(sdof,1);                % globaler Kraftvektor
K_mat=zeros(sdof,sdof);             % globale Steifigkeitsmatrix


%------------------------------------------
% Kräfte 
%------------------------------------------
	
F_vec(7*2)=-600;
F_vec(14*2)=-600;
F_vec(21*2)=-600;
	



%------------------------------------------
% Berechnung der Matrizen
%------------------------------------------

[point,weight]=numInt(ng_x,ng_y);       % Gewichte und Integrationspunkte

C_mat=E/(1-nu*nu)*...                   % C-Matrix (ebener Spannungszustand)
	[1 nu 0;...
	nu 1 0;...
	0 0 (1-nu)/2];		

for ielement=1:ne                       % Schleife über alle finiten Elemente

    elementCoord=[TKK(EZT(ielement,1),1) TKK(EZT(ielement,1),2);...
        TKK(EZT(ielement,2),1) TKK(EZT(ielement,2),2);...
        TKK(EZT(ielement,3),1) TKK(EZT(ielement,3),2);...
        TKK(EZT(ielement,4),1) TKK(EZT(ielement,4),2);];
    
   
	k_mat=zeros(elementDOF,elementDOF);
    f_vec=zeros(elementDOF);
	
	%------------------------------------------
	% Numerische Integration und Erstellung: K-Matrix
	%------------------------------------------
	
	for ix=1:ng_x
		xi_point=point(ix,1);
		wt_x=weight(ix,1);
		for iy=1:ng_y
			eta_point=point(iy,2);
			wt_y=weight(iy,2);
            [Nfct, dNfct_xi, dNfct_eta ]=shape(xi_point,eta_point);
			
			F0=jacob(dNfct_xi,dNfct_eta,elementCoord); % Jacobi-Matrix
			detF0=det(F0);
			invF0=inv(F0);
			
			[dNfct_x,dNfct_y]=einheits2original(elementNodes,dNfct_xi,dNfct_eta,invF0);
			
			Bmat=B_mat(elementNodes,dNfct_x,dNfct_y);
			
            
			
			k_mat=k_mat + (detF0*Bmat'*C_mat*Bmat*wt_x*wt_y); 
			
            %f_vec=f_vec + (detF0*N_mat*)
		end 
		
	end % Ende numerische Integration
    pos=[EZT(ielement,1)*2-1,EZT(ielement,1)*2 ...
        EZT(ielement,2)*2-1,EZT(ielement,2)*2 ...
        EZT(ielement,3)*2-1,EZT(ielement,3)*2 ...
        EZT(ielement,4)*2-1,EZT(ielement,4)*2];
    
    %------------------------------------------
    % Assemblierung
    %------------------------------------------

    
	K_mat=assembl(K_mat,k_mat,pos); 
	
end % Ende Schleife über alle Elemente

%------------------------------------------
% Randbedingungen einbauen
%------------------------------------------

[K_mat,F_vec]=bound(K_mat,F_vec,bc_nodes); 

%------------------------------------------
% Lösen des Gleichungssystems
%------------------------------------------

u_vec=K_mat\F_vec;

vgf=1;    
TKK_def=zeros(nnode,2);

k=1;
for i=1:nnode
    TKK_def(i,1)=vgf *   u_vec(k);
    k=k+1;
    TKK_def(i,2)=vgf *   u_vec(k);
    k=k+1;
end
TKK_def=TKK+TKK_def;

    TKKBound_def=[TKK_def(1,1) TKK_def(1,2); TKK_def(1+a,1) TKK_def(1+a,2);...
        TKK_def(nnode,1) TKK_def(nnode,2); TKK_def(nnode-a,1) TKK_def(nnode-a,2)];




net_Fct_def(TKKBound_def,TKK_def,EZT);  % plotten des Netzes
%num=1:1:sdof;
%Knotenverschiebungen=[num' u_vec]
%test
	