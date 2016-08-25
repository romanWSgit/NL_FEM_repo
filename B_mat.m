function [B_mat]=B_mat(nnel,dNfct_xi,dNfct_eta,invF0)

%------------------------------------------
% Matrix der abgeleiteten Ansatzfunktionen
%------------------------------------------
    for i=1:nnel
		dNfct_x(i)=invF0(1,1)*dNfct_xi(i)+invF0(1,2)*dNfct_eta(i);
		dNfct_y(i)=invF0(2,1)*dNfct_xi(i)+invF0(2,2)*dNfct_eta(i);
	end


    B_mat= [[dNfct_x(1) 0; 0 dNfct_y(1); dNfct_y(1) dNfct_x(1)],...
        [dNfct_x(2) 0; 0 dNfct_y(2); dNfct_y(2) dNfct_x(2)],...
        [dNfct_x(3) 0; 0 dNfct_y(3); dNfct_y(3) dNfct_x(3)]...
        [dNfct_x(4) 0; 0 dNfct_y(4); dNfct_y(4) dNfct_x(4)]];

end
	