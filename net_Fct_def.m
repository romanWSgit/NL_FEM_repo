function []=net_Fct_def(TKKBound_def,TKK_def,EZT)





    nb = size(TKKBound_def,1);
% 
% 
%     o1=TKKBound_def(1,:);
%     o2=TKKBound_def(2,:);
%     o3=TKKBound_def(3,:);
%     o4=TKKBound_def(4,:);
%     dist=zeros(b+1,2);
%     l=zeros((b-1)*2,2);
%     i=1;
%     while i <= b+1
%         if i==1
%             dist(i,:)=o2-o1;
%             i=i+1;
%         elseif i==b+1
%             dist(i,:)=o3-o4;
%             i=i+1;
%         else
%             k=1;
%             for j=1:2:(b-1)*2
%                 l(j+1,:)=o2+(o3-o2)/norm(o3-o2)*k*norm(o3-o2)/(b);
%                 l(j,:)=o1+(o4-o1)/norm(o4-o1)*k*norm(o4-o1)/(b);
%                 dist(i,:)=l(j+1,:)-l(j,:);
%                 i=i+1;
%                 k=k+1;
%             end
%         end
%     end
%     l(length(l)+1,:)=o4;
%     l(length(l)+1,:)=o3;

    % name_str = 'Netz:';
    % figure('Name',name_str,'NumberTitle','off');
    % 

    for i = 1:nb
        point(TKKBound_def(i,1),TKKBound_def(i,2));
    end
    hold on;

    %xlim([0 8])
   nn=length(TKK_def)
%     TKK_def=zeros(nn,2);
% 
% 
%     TKK_def(1,:)=TKKBound_def(1,:); % erstes Randelement
%     for j=0:b
%         for i=(a+1)*j + 2: (a+1)*j + a+1
%            TKK_def(i,:)=TKK_def(i-1,:)+ (dist(j+1,:)/norm(dist(j+1,:)))*(norm(dist(j+1,:))/a);
%         end
%         if (j < b)
%             TKK_def((a+1)*(j+1) + 1,:)=l((j*2+1),:);
%         end
%     end

 

    for i = 1:nn
        point_s_b(TKK_def(i,1),TKK_def(i,2));
        x1 = TKK_def(i,1);
        y1 = TKK_def(i,2);
        s1='\leftarrow';
        s2=num2str(i);
        txt1 = [s1 s2];
        text(x1,y1,txt1)
        hold on;
    end
    hold on;


    [ne s]=size(EZT);
    

    for i=1:ne
        

        S.Vertices = [TKK_def(EZT(i,1),:); TKK_def(EZT(i,2),:); TKK_def(EZT(i,3),:); TKK_def(EZT(i,4),:)];
        S.Faces = [1 4 3 2];
        S.FaceVertexCData = 0;
        S.FaceColor = 'flat';
        S.EdgeColor = 'blue';
        S.FaceAlpha = 0.2;
        S.LineWidth = 1.5;

        patch(S)
 
        
%         
%        lineDrawer(TKK_def(EZT(i,1),:),TKK_def(EZT(i,2),:));
%        lineDrawer(TKK_def(EZT(i,2),:),TKK_def(EZT(i,3),:));
%        lineDrawer(TKK_def(EZT(i,3),:),TKK_def(EZT(i,4),:));
%        lineDrawer(TKK_def(EZT(i,4),:),TKK_def(EZT(i,1),:));
       hold on;
    end
    grid on;

   




end