function [figure]=makeIdentifierLines(figure,handle,x1,x2,y1,y2,tagname,color)

    meanArrowAnnotate=annotation('textarrow','VerticalAlignment','bottom',...
        'Interpreter','latex',...
        'HorizontalAlignment','left',...
        'HeadStyle','vback3',...
        'FontSize',16);
    meanArrowAnnotate.Parent=handle;
    P1=[x1 x2];
    P2=[y1 y2];
    %     [xnorm, ynorm] = coord2norm(axes1,P1,P2);
    meanArrowAnnotate.X=P1;
    meanArrowAnnotate.Y=P2;
    meanArrowAnnotate.String=tagname;
    meanArrowAnnotate.HeadStyle='vback3';
    meanArrowAnnotate.Color=color;

end