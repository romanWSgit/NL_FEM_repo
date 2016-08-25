function[K_mat,F_vec]=bound(K_mat,F_vec,bc_nodes)
	
	
	for i=1:length(bc_nodes)
		pos=bc_nodes(i);
		for j=1:size(K_mat)
			K_mat(pos,j)=0;     % Matrizeneinträge Null setzen
            K_mat(j,pos)=0;     % Matrizeneinträge Null setzen
		end
		K_mat(pos,pos)=1;       % "pos" Eins setzen
		F_vec(pos)=0; % Kraftvektor auf den jeweiligen Wert setzten
	end	
end

%penalty still to add