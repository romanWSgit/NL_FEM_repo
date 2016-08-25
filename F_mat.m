function [F,dNfct_x,dNfct_y]=F_mat(nnel,dNfct_xi,dNfct_eta,u_k,invF0)
    F_h=zeros(2,2);
	F=zeros(2,2);


    for i=1:nnel
		dNfct_x(i)=invF0(1,1)*dNfct_xi(i)+invF0(1,2)*dNfct_eta(i);
		dNfct_y(i)=invF0(2,1)*dNfct_xi(i)+invF0(2,2)*dNfct_eta(i);
	end
    
   for i=1:4
		F_h(1,1)=dNfct_x(i)*u_k((i),1);     %elementCoord x-Koord.
		F_h(1,2)=dNfct_y(i)*u_k((i),1);     %elementCoord y-Koord.
		F_h(2,1)=dNfct_x(i)*u_k((i),2);    %elementCoord x-Koord.
		F_h(2,2)=dNfct_y(i)*u_k((i),2);    %elementCoord y-Koord.
        
      
        F=F+F_h;
   end
    F=F+eye(2);
end