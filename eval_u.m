function [u,qj,delta]=eval_u(j,count,epsilon,u)
            qj=0;
            delta=0;
           
                qj=u(j,1);
                delta = sqrt(epsilon)*max([1,qj]);
                if count==1 
                    u(j,1)=u(j,1);
                elseif count==2
                    u(j,1)=u(j,1)+delta;
                elseif count==3
                    u(j,1)=u(j,1)-2*delta;
                end
            

end