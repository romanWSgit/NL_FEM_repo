function [u_k,qj,delta]=eval_uk(j,count,epsilon,u_k)
            qj=0;
            delta=0;
            if j==1 
                qj=u_k(1,1);
                delta = sqrt(epsilon)*max([1,qj]);
                if count==1 
                    u_k(1,1)=u_k(1,1)+delta;
                elseif count==2
                    u_k(1,1)=u_k(1,1)-2*delta;
                end
            elseif j==2 
                qj=u_k(1,2);
                delta = sqrt(epsilon)*max([1,qj]);
                 if count==1 
                    u_k(1,2)=u_k(1,2)+delta;
                else
                    u_k(1,2)=u_k(1,2)-2*delta;
                end
            elseif j==3 
                qj=u_k(2,1);
                delta = sqrt(epsilon)*max([1,qj]);
                 if count==1 
                    u_k(2,1)=u_k(2,1)+delta;
                else
                    u_k(2,1)=u_k(2,1)-2*delta;
                end
            elseif j==4
                qj=u_k(2,2);
                delta = sqrt(epsilon)*max([1,qj]);
                 if count==1 
                    u_k(2,2)=u_k(2,2)+delta;
                else
                    u_k(2,2)=u_k(2,2)-2*delta;
                end
            elseif j==5 
                qj=u_k(3,1);
                delta = sqrt(epsilon)*max([1,qj]);
                 if count==1 
                    u_k(3,1)=u_k(3,1)+delta;
                else
                    u_k(3,1)=u_k(3,1)-2*delta;
                end
            elseif j==6 
                qj=u_k(3,2);
                delta = sqrt(epsilon)*max([1,qj]);
                 if count==1 
                    u_k(3,2)=u_k(3,2)+delta;
                else
                    u_k(3,2)=u_k(3,2)-2*delta;
                end
            elseif j==7 
                qj=u_k(4,1);
                delta = sqrt(epsilon)*max([1,qj]);
                 if count==1 
                    u_k(4,1)=u_k(4,1)+delta;
                else
                    u_k(4,1)=u_k(4,1)-2*delta;
                end
            elseif j==8 
                qj=u_k(4,2);
                delta = sqrt(epsilon)*max([1,qj]);
                if count==1 
                    u_k(4,2)=u_k(4,2)+delta;
                else
                    u_k(4,2)=u_k(4,2)-2*delta;
                end
            end

end