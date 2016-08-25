function [Nfct,dNfctxi,dNfcteta]=shape(xi,eta)
	
	% shape Funktionen
	Nfct(1)= 1/4*(1-xi)*(1-eta);
	Nfct(2)= 1/4*(1+xi)*(1-eta);
	Nfct(3)= 1/4*(1+xi)*(1+eta);
	Nfct(4)= 1/4*(1-xi)*(1+eta);
	
	% Ableitungen der Shape Funktionen
	
	dNfctxi(1)=-1/4*(1-eta);
	dNfctxi(2)=1/4*(1-eta);
	dNfctxi(3)=1/4*(1+eta);
	dNfctxi(4)=-1/4*(1+eta);
	
	dNfcteta(1)=-1/4*(1-xi);
	dNfcteta(2)=-1/4*(1+xi);
	dNfcteta(3)=1/4*(1+xi);
	dNfcteta(4)=1/4*(1-xi);
end