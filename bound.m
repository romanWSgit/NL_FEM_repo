function[K_mat,F_vec]=bound(K_mat,F_vec,bc_nodes)
	
	alpha = 100000;
	for i=1:length(bc_nodes)
		pos=bc_nodes(i);
		%for j=1:size(K_mat)
			%K_mat(pos,j)=K_mat(pos,j)*alpha;     % Matrizeneinträge Null setzen
            %K_mat(j,pos)=K_mat(pos,j)*alpha;;     % Matrizeneinträge Null setzen
		%end
		K_mat(pos,pos)=K_mat(pos,pos)*alpha;       % "pos" Eins setzen
		F_vec(pos)=F_vec(pos)*alpha; % Kraftvektor auf den jeweiligen Wert setzten
	end	
end

