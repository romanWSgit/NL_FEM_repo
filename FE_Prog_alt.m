
clear all;
close all;
clc


prompt = {'Netzfeinheit horizontal:','Netzfeinheit vertical:',...
    'Berandung P1:', 'Berandung P2:', 'Berandung P3:', 'Berandung P4:'};
dlg_title = 'Geometrie und Netz';
num_lines = [1 36];
defaultans = {'6','2','1 0','10 0','10 3','1 3'};
options.Resize = 'on';
x1 = inputdlg(prompt,dlg_title,num_lines,defaultans,options);

a=str2num(x1{1,:});
b=str2num(x1{2,:});
P1=str2num(x1{3,:});
P2=str2num(x1{4,:});
P3=str2num(x1{5,:});
P4=str2num(x1{6,:});



%------------------------------------------
% Netzdimensionen
%------------------------------------------
% a=6;                               % Unterteilung in x-Richtung
% b=2;                               % Unterteilung in y-Richtung





TKKBound=[P1; P2; P3; P4];    % Rand des Gebietes
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




prompt = {'Gesperrte Knoten:','Belastete Knoten:',...
    'Belastung:'};
dlg_title = 'Rand und Belastung';
num_lines = [1 40];
defaultans = {'1 2 15 15 29 30','14 28 42','0 0 0'};
options.Resize = 'on';
x2 = inputdlg(prompt,dlg_title,num_lines,defaultans,options);

bc_nodes_dialog=str2num(x2{1,:});
f_nodes_dialog=str2num(x2{2,:});
f_val_nodes_dialog=str2num(x2{3,:});




%------------------------------------------
% Randbedingungen
%------------------------------------------

bc_nodes=bc_nodes_dialog;
%bc_nodes=[1 2 15 16 29 30];		% Angabe der gesperrten Knoten

%------------------------------------------
% Initialisierung
%------------------------------------------


F_vec=zeros(sdof,1);                % globaler Kraftvektor
K_mat=zeros(sdof,sdof);             % globale Steifigkeitsmatrix


%------------------------------------------
% Belastungen
%------------------------------------------



F_Kanten=[7 14];
tx=[1000;0];


[find1x,find1y]=find(EZT==F_Kanten(1));
[find2x,find2y]=find(EZT==F_Kanten(2));
f_element=intersect(find1x,find2x);
f_element_pos1=find(EZT(f_element,:)==F_Kanten(1));
f_element_pos2=find(EZT(f_element,:)==F_Kanten(2));
x_f=[TKK(EZT(f_element,1),:)'; TKK(EZT(f_element,2),:)'; TKK(EZT(f_element,3),:)';TKK(EZT(f_element,4),:)'];



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
    f_vec=zeros(elementDOF,1);
	
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
			
            Bmat=B_mat(dNfct_x,dNfct_y);
            
            
            
			
			k_mat=k_mat + (detF0*Bmat'*C_mat*Bmat*wt_x*wt_y); 
            
			
            
		end 
		
	end % Ende numerische Integration
    
    
    for ix=1:ng_x
		xi_point=point(ix,1);
		wt_x=weight(ix,1);
        
        if ielement == f_element
            [Nfct, dNfct_xi, dNfct_eta ]=shape(1,xi_point); 
            [Nmat,dNmat]=N_mat(Nfct,2);
            j_vec=dNmat*x_f;
            j=sqrt(j_vec(1,1)^2 + j_vec(2,1)^2);
            f_vec=f_vec + (j*Nmat'*tx*wt_x);
         end
        
    end
    
    
    
    pos=[EZT(ielement,1)*2-1,EZT(ielement,1)*2 ...
        EZT(ielement,2)*2-1,EZT(ielement,2)*2 ...
        EZT(ielement,3)*2-1,EZT(ielement,3)*2 ...
        EZT(ielement,4)*2-1,EZT(ielement,4)*2];
    
    %------------------------------------------
    % Assemblierung
    %------------------------------------------

    F_vec(pos) = F_vec(pos) + f_vec;
    
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
TKK_def=zeros(nnode,2);

k=1;
for i=1:nnode
    TKK_def(i,1)=u_vec(k);
    k=k+1;
    TKK_def(i,2)=u_vec(k);
    k=k+1;
end
TKK_def=TKK+TKK_def;

    TKKBound_def=[TKK_def(1,1) TKK_def(1,2); TKK_def(1+a,1) TKK_def(1+a,2);...
        TKK_def(nnode,1) TKK_def(nnode,2); TKK_def(nnode-a,1) TKK_def(nnode-a,2)];

 DEF=TKK_def-TKK;   


[ne,TKK,EZT]=net_Fct(a,b,TKKBound);  % plotten des Netzes
net_Fct_def(TKKBound_def,TKK_def,EZT);  % plotten des Netzes
num=1:1:sdof;
Knotenverschiebungen=[num' u_vec]
	