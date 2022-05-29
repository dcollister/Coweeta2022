function [flies,maxPositions]=checkMaxMovements(flies,maxPositions,inBoundsAgs)

a=(sqrt((flies(inBoundsAgs,1)-flies(inBoundsAgs,6)).^2+(flies(inBoundsAgs,2)-flies(inBoundsAgs,7)).^2));
b=maxPositions(flies(inBoundsAgs,9),9);
for i=1:size(a,1)

    if flies(inBoundsAgs(i),1)<maxPositions(flies(inBoundsAgs(i),9),1)
        maxPositions(flies(inBoundsAgs(i),9),1:2)=flies(inBoundsAgs(i),1:2);
        maxPositions(flies(inBoundsAgs(i),9),21)=flies(inBoundsAgs(i),5);
    elseif flies(inBoundsAgs(i),1)>maxPositions(flies(inBoundsAgs(i),9),3)
        maxPositions(flies(inBoundsAgs(i),9),3:4)=flies(inBoundsAgs(i),1:2);
        maxPositions(flies(inBoundsAgs(i),9),22)=flies(inBoundsAgs(i),5);
    elseif flies(inBoundsAgs(i),2)<maxPositions(flies(inBoundsAgs(i),9),6)
        maxPositions(flies(inBoundsAgs(i),9),5:6)=flies(inBoundsAgs(i),1:2);
        maxPositions(flies(inBoundsAgs(i),9),23)=flies(inBoundsAgs(i),5);
    elseif flies(inBoundsAgs(i),2)>maxPositions(flies(inBoundsAgs(i),9),8)
        maxPositions(flies(inBoundsAgs(i),9),7:8)=flies(inBoundsAgs(i),1:2);
        maxPositions(flies(inBoundsAgs(i),9),24)=flies(inBoundsAgs(i),5);
    end
end
%     a=(sqrt((flies(i,1)-flies(i,6))^2+(flies(i,2)-flies(i,7))^2));
%     b=maxPositions(flies(i,9),9);
%     b=(sqrt((maxPositions(flies(i,9),10)-flies(i,6))^2+(maxPositions(flies(i,9),11)-flies(i,7))^2));
for i=1:height(a)
    if a(i)>b(i)
        maxPositions(flies(inBoundsAgs(i),9),9)=a(i);
        maxPositions(flies(inBoundsAgs(i),9),10:11)=flies(inBoundsAgs(i),1:2);
        maxPositions(flies(inBoundsAgs(i),9),25)=flies(inBoundsAgs(i),5);
    end
end
%     maxPositions(flies(i,9),12:13)=flies(i,1:2);
% scatterPlotPerTimestep{t}=scatter(flies(1:i,1),flies(1:i,2));
% close all;
end
