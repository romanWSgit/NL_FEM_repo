function [ne,TKK,EZT]=net_Fct(a,b,TKKBound)



ne = a*b;



nb = size(TKKBound,1);




o1=TKKBound(1,:);
o2=TKKBound(2,:);
o3=TKKBound(3,:);
o4=TKKBound(4,:);
dist=zeros(b+1,2);
l=zeros((b-1)*2,2);
i=1;
while i <= b+1
    if i==1
        dist(i,:)=o2-o1;
        i=i+1;
    elseif i==b+1
        dist(i,:)=o3-o4;
        i=i+1;
    else
        k=1;
        for j=1:2:(b-1)*2
            l(j+1,:)=o2+(o3-o2)/norm(o3-o2)*k*norm(o3-o2)/(b);
            l(j,:)=o1+(o4-o1)/norm(o4-o1)*k*norm(o4-o1)/(b);
            dist(i,:)=l(j+1,:)-l(j,:);
            i=i+1;
            k=k+1;
        end
    end
end
l(length(l)+1,:)=o4;
l(length(l)+1,:)=o3;

name_str = 'Netz:';
figure('Name',name_str,'NumberTitle','off');


for i = 1:nb
    point(TKKBound(i,1),TKKBound(i,2));
end
hold on;

%xlim([0 8])
nn=(a+1)*(b+1);
TKK=zeros(nn,2);


TKK(1,:)=TKKBound(1,:); % erstes Randelement
for j=0:b
    for i=(a+1)*j + 2: (a+1)*j + a+1
       TKK(i,:)=TKK(i-1,:)+ (dist(j+1,:)/norm(dist(j+1,:)))*(norm(dist(j+1,:))/a);
    end
    if (j < b)
        TKK((a+1)*(j+1) + 1,:)=l((j*2+1),:);
    end
end
  


for i = 1:nn
    point_s(TKK(i,1),TKK(i,2));
    x1 = TKK(i,1);
    y1 = TKK(i,2);
    s1='\leftarrow';
    s2=num2str(i);
    txt1 = [s1 s2];
    text(x1,y1,txt1)
    hold on;
end
hold on;


EZT=zeros(a*b,4);
                            
i=1;
k=1;
while i <=b
    j=1;
    while j <= a
        EZT(k,1)=(i-1)*(a+1)+j;
        EZT(k,2)=(i-1)*(a+1)+j+1;
        EZT(k,3)=(i)*(a+1)+j+1;
        EZT(k,4)=(i)*(a+1)+j;
        j=j+1;
        k=k+1;
    end
    i=i+1;
end;



for i=1:ne
   lineDrawer(TKK(EZT(i,1),:),TKK(EZT(i,2),:));
   lineDrawer(TKK(EZT(i,2),:),TKK(EZT(i,3),:));
   lineDrawer(TKK(EZT(i,3),:),TKK(EZT(i,4),:));
   lineDrawer(TKK(EZT(i,4),:),TKK(EZT(i,1),:));
   hold on;
end
grid on;

for i = 1:ne
    x1=[TKK(EZT(i,1),1),TKK(EZT(i,2),1),TKK(EZT(i,3),1),TKK(EZT(i,4),1)];
    y1=[TKK(EZT(i,1),2),TKK(EZT(i,2),2),TKK(EZT(i,3),2),TKK(EZT(i,4),2)];

    cx = mean(x1);
    cy = mean(y1);
    s1='';
    s2=num2str(i);
    txt1 = [s1 s2];
    t=text(cx,cy,txt1);
    t.FontSize = 250/round(2*sqrt(a^2+b^2));
    t.FontWeight='bold';
    t.Color='blue';
    hold on;
end







end