function [F]=F_mat(dN_fct_xi,dN_fct_eta,elementCoord,invF0)
    F_h=zeros(2,2);
	F=zeros(2,2);
	%F_h=invF0';
% 	for i=1:4
% 		F(1,1)=F(1,1)+F_h(1,1)*dN_fct_xi(i)*elementCoord((i),1);     %elementCoord x-Koord.
% 		F(1,2)=F(1,2)+F_h(1,2)*dN_fct_xi(i)*elementCoord((i),2);     %elementCoord y-Koord.
% 		F(2,1)=F(2,1)+F_h(2,1)*dN_fct_eta(i)*elementCoord((i),1);    %elementCoord x-Koord.
% 		F(2,2)=F(2,2)+F_h(2,2)*dN_fct_eta(i)*elementCoord((i),2);    %elementCoord y-Koord.
%     end
%     
    
   for i=1:4
		F_h(1,1)=dN_fct_xi(i)*elementCoord((i),1);     %elementCoord x-Koord.
		F_h(1,2)=dN_fct_xi(i)*elementCoord((i),2);     %elementCoord y-Koord.
		F_h(2,1)=dN_fct_eta(i)*elementCoord((i),1);    %elementCoord x-Koord.
		F_h(2,2)=dN_fct_eta(i)*elementCoord((i),2);    %elementCoord y-Koord.
        
       % F=F+invF0'*F_h;
        F=F+F_h;
   end
	
end