function [point,weight]=numInt(ng_x,ng_y) 





% [pointx,weightx]=numIntDat(ng_x); 
% [pointy,weighty]=numIntDat(ng_y);
% 

pointx(1)=-1/sqrt(3);
pointx(2)=1/sqrt(3);
weightx(1)=1.0;
weightx(2)=1.0;

for intx=1:ng_x 
	point(intx,1)=pointx(intx);
	weight(intx,1)=weightx(intx);
end

for inty=1:ng_y 
	point(inty,2)=pointx(inty);
	weight(inty,2)=weightx(inty);
end
end