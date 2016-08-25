function [B_mat_nl]=B_mat_nl(dNfct_x, dNfct_y,F,i)

	B_mat_nl=[F(1,1)*dNfct_x(i)  F(2,1)*dNfct_x(i) ; ...
     F(1,2)*dNfct_y(i)  F(2,2)*dNfct_y(i) ; ...
     F(1,1)*dNfct_y(i) + F(1,2)*dNfct_x(i)  F(2,1)*dNfct_y(i) + F(2,2)*dNfct_x(i) ];
end
	