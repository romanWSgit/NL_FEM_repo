function [B_mat_nl]=B_mat_nl(nnel,dNfct_xi,dNfct_eta,F,invF0,i)


    for i=1:nnel
		dNfct_x(i)=invF0(1,1)*dNfct_xi(i)+invF0(1,2)*dNfct_eta(i);
		dNfct_y(i)=invF0(2,1)*dNfct_xi(i)+invF0(2,2)*dNfct_eta(i);
	end


	B_mat_nl=[F(1,1)*dNfct_x(i)  F(2,1)*dNfct_x(i) ; ...
     F(1,2)*dNfct_y(i)  F(2,2)*dNfct_y(i) ; ...
     F(1,1)*dNfct_y(i) + F(1,2)*dNfct_x(i)  F(2,1)*dNfct_y(i) + F(2,2)*dNfct_x(i) ];
end
	