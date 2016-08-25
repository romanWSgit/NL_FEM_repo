function[kk] = assembl(kk,k,pos)
	edof=length(pos);
	for i=1:edof
		ii=pos(i);
		for j=1:edof
			jj=pos(j);
			kk(ii,jj)=kk(ii,jj)+k(i,j);
		end
	end
end