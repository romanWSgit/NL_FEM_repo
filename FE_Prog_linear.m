
clear all;
close all;
clc

%------------------------------------------
% Eingabefenster 1 (Geometrie)
%------------------------------------------
[a,b,P1,P2,P3,P4]=prompt1();


%------------------------------------------
% Definition des Randes und graphische Darstellung
%------------------------------------------


 
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
EIy=E*(4^3)/12;
l=10;
q0=1000/l;

%------------------------------------------
% Exakte Lsg.:
%------------------------------------------

w_exakt=wDurch(10,l,q0,EIy)

%------------------------------------------
% Eingabefenster 1 (RB, Äußere Belastungen)
%------------------------------------------
[RB_Sperre,F_Kanten,t_x]=prompt2();


%------------------------------------------
% Randbedingungen
%------------------------------------------
[h n_RB]= size(RB_Sperre);
k=1;
bc_nodes=zeros(1,2*n_RB);
for i=1:n_RB
    bc_nodes(1,k)=2*RB_Sperre(1,i);
    k=k+1;
    bc_nodes(1,k)=(2*RB_Sperre(1,i))-1;
    k=k+1;
    
end

%------------------------------------------
% Initialisierung
%------------------------------------------


F_vec=zeros(sdof,1);                % globaler Kraftvektor
K_mat=zeros(sdof,sdof);             % globale Steifigkeitsmatrix


%------------------------------------------
% Belastungen
%------------------------------------------




[n_kanten, c]= size(F_Kanten);

f_check=zeros(ne,4);
for i = 1:n_kanten
    
    [find1x,find1y]=find(EZT==F_Kanten(i,1));
    [find2x,find2y]=find(EZT==F_Kanten(i,2));
    f_element=intersect(find1x,find2x);
    f_check(f_element,1)=1;
    f_element_pos1=find(EZT(f_element,:)==F_Kanten(i,1));
    f_element_pos2=find(EZT(f_element,:)==F_Kanten(i,2));
    kante = 4;
    if     (f_element_pos1==1 && f_element_pos2==2) || (f_element_pos1==2 && f_element_pos2==1)
        kante = 1;
    elseif (f_element_pos1==2 && f_element_pos2==3) || (f_element_pos1==3 && f_element_pos2==2)
        kante = 2;
    elseif (f_element_pos1==4 && f_element_pos2==3) || (f_element_pos1==3 && f_element_pos2==4)
        kante = 3;
    elseif (f_element_pos1==4 && f_element_pos2==1) || (f_element_pos1==1 && f_element_pos2==4)
        kante = 4;
    end
     f_check(f_element,2)=kante;
     f_check(f_element,3)=t_x(i,1);
     f_check(f_element,4)=t_x(i,2);
end




%--------------------------------------------------------
% Gewichte und Stützpunkte für die numerische Integration
%--------------------------------------------------------



[point,weight]=numInt(ng_x,ng_y);       % Gewichte und Integrationspunkte


%--------------------------------------------------------
% Konstitutive Beziehung (Ebener Spannungszustand)
%--------------------------------------------------------


C_mat=E/(1-nu*nu)*...                   % C-Matrix (ebener Spannungszustand)
	[1 nu 0;...
	nu 1 0;...
	0 0 (1-nu)/2];		

%--------------------------------------------------------
% Schleife über alle Elemente
%--------------------------------------------------------



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
		
            Bmat=B_mat(elementNodes,dNfct_xi,dNfct_eta,invF0);
            
			k_mat=k_mat + (detF0*Bmat'*C_mat*Bmat*wt_x*wt_y); % Ermittlung der Elements-k-Matrix
 
		end 
		
	end % Ende numerische Integration
    
    %------------------------------------------
	% Ermittlung des Elementslastvektors
	%------------------------------------------
    
    x_f=[TKK(EZT(ielement,1),:)'; TKK(EZT(ielement,2),:)';...
        TKK(EZT(ielement,3),:)';TKK(EZT(ielement,4),:)'];
    % x_f ... Koordinaten des belasteten elements
    for ix=1:ng_x
		xi_point=point(ix,1);
		wt_x=weight(ix,1);
        
        if f_check(ielement,1) == 1
            f_kante=f_check(ielement,2);
            if     f_kante == 1
               [Nfct, dNfct_xi, dNfct_eta ]=shape(xi_point,-1);  
            elseif f_kante == 2
                [Nfct, dNfct_xi, dNfct_eta ]=shape(1,xi_point); 
            elseif f_kante == 3
                [Nfct, dNfct_xi, dNfct_eta ]=shape(xi_point,1); 
            elseif f_kante == 4
                [Nfct, dNfct_xi, dNfct_eta ]=shape(-1,xi_point); 
            end
            [Nmat,dNmat]=N_mat(Nfct,f_kante);
            j_vec=dNmat*x_f;
            j=sqrt(j_vec(1,1)^2 + j_vec(2,1)^2);
            t=[f_check(ielement,3);f_check(ielement,4)];
            
            f_vec=f_vec + (j*Nmat'*t*wt_x);         % Ermittlung der Elements-f-Vektors
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

%------------------------------------------
% Graphische Darstellung
%------------------------------------------


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

	