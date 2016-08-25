function [F0]=jacob(dN_fct_xi,dN_fct_eta,elementCoord)

	F0=zeros(2,2);
	
	for i=1:4
		F0(1,1)=F0(1,1)+dN_fct_xi(i)*elementCoord((i),1);     %elementCoord x-Koord.
		F0(1,2)=F0(1,2)+dN_fct_xi(i)*elementCoord((i),2);     %elementCoord y-Koord.
		F0(2,1)=F0(2,1)+dN_fct_eta(i)*elementCoord((i),1);    %elementCoord x-Koord.
		F0(2,2)=F0(2,2)+dN_fct_eta(i)*elementCoord((i),2);    %elementCoord y-Koord.
	end
	
end