function []=net_Fct_def(TKKBound_def,TKK_def,EZT)





    nb = size(TKKBound_def,1);

    for i = 1:nb
        point(TKKBound_def(i,1),TKKBound_def(i,2));
    end
    hold on;


   nn=length(TKK_def);

 

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
 
        

       hold on;
    end
    grid on;

   




end