function [TKKdef,TKKBoundDef]=plotFctDef(a,b,disp,EZT,TKK)


    name_str = 'Verformt:';
    figure('Name',name_str,'NumberTitle','off');

    ne = a*b;
    nn=(a+1)*(b+1);
    TKKdef=zeros(nn,2);

    k=1;
    for i=1:nn
        TKKdef(i,1)=disp(i);
        TKKdef(i,2)=disp(i+k);
        k=k+1;
    end
    TKKdef=TKK+TKKdef;

    TKKBoundDef=[TKKdef(1,1) TKKdef(1,2); TKKdef(1+a,1) TKKdef(1+a,2);...
        TKKdef(nn,1) TKKdef(nn,2); TKKdef(nn-a,1) TKKdef(nn-a,2)];


    nb = size(TKKBoundDef,1);




    o1=TKKBoundDef(1,:);
    o2=TKKBoundDef(2,:);
    o3=TKKBoundDef(3,:);
    o4=TKKBoundDef(4,:);
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




    for i = 1:nb
        point(TKKBoundDef(i,1),TKKBoundDef(i,2));
    end
    hold on;

    %xlim([0 8])
    nn=(a+1)*(b+1);
    % TKK=zeros(nn,2);
    % 
    % 
    % TKK(1,:)=TKKBoundDef(1,:); % erstes Randelement
    % for j=0:b
    %     for i=(a+1)*j + 2: (a+1)*j + a+1
    %        TKK(i,:)=TKK(i-1,:)+ (dist(j+1,:)/norm(dist(j+1,:)))*(norm(dist(j+1,:))/a);
    %     end
    %     if (j < b)
    %         TKK((a+1)*(j+1) + 1,:)=l((j*2+1),:);
    %     end
    % end
    %   


    for i = 1:nn
        point_s_g(TKKdef(i,1),TKKdef(i,2));
        x1 = TKKdef(i,1);
        y1 = TKKdef(i,2);
        s1='\leftarrow';
        s2=num2str(i);
        txt1 = [s1 s2];
        text(x1,y1,txt1)
        hold on;
    end
    hold on;




    for i=1:ne
       lineDrawer(TKKdef(EZT(i,1),:),TKKdef(EZT(i,2),:));
       lineDrawer(TKKdef(EZT(i,2),:),TKKdef(EZT(i,3),:));
       lineDrawer(TKKdef(EZT(i,3),:),TKKdef(EZT(i,4),:));
       lineDrawer(TKKdef(EZT(i,4),:),TKKdef(EZT(i,1),:));
       hold on;
    end
    grid on;

    for i = 1:ne
        x1=[TKKdef(EZT(i,1),1),TKKdef(EZT(i,2),1),TKKdef(EZT(i,3),1),TKKdef(EZT(i,4),1)];
        y1=[TKKdef(EZT(i,1),2),TKKdef(EZT(i,2),2),TKKdef(EZT(i,3),2),TKKdef(EZT(i,4),2)];

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