function [dNfct_x,dNfct_y]=einheits2original(nnel,dNfct_xi,dNfct_eta,invF0)	
	for i=1:nnel
		dNfct_x(i)=invF0(1,1)*dNfct_xi(i)+invF0(1,2)*dNfct_eta(i);
		dNfct_y(i)=invF0(2,1)*dNfct_xi(i)+invF0(2,2)*dNfct_eta(i);
	end
end