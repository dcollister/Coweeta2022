 function [flies,maxPositions]=move_v3(flies,landGrid,landGrid_prob,t,maxPositions)%water,land,death)
    mover = rand(size(flies,1),1);
    fullTempIDVec=1:size(flies(:,9),1);
    test=sub2ind(size(landGrid_prob,1:2),flies(:,2),flies(:,1));
    test2=test.*linspace(1,9,9);
    test3=landGrid_prob(test2);
    slots=cumsum(test3,2);
    moveNumber=zeros(height(slots),1);
    for moverCount=1:size(moveNumber,1)
        moveNumber(moverCount,1)=numel(slots(moverCount,(find(slots(moverCount,:) <= mover(moverCount)))))+1;
    end
    flies(fullTempIDVec,2)=flies(fullTempIDVec,2)+mod(moveNumber(fullTempIDVec)-1,3)-1;
    flies(fullTempIDVec,1)=flies(fullTempIDVec,1)-2+ceil(moveNumber(fullTempIDVec)/3);

    %movement counter increase
    flies(:,5)=flies(:,5)+1;
    [boundAgsBySideIDs,outOfBoundsIDs,inBoundsAgs]=findBoundaryAgs(flies,landGrid,fullTempIDVec);

    [flies,maxPositions]=checkMaxMovements(flies,maxPositions,inBoundsAgs);

    %boundary replaced with new agent
    %     else %right now if one goes out of bound it's killed
    %% It sure looks like this coordinate is being written into the 6-7 spots as well. Might be boundary problem
    if ~isempty(outOfBoundsIDs)
        a=(sqrt((flies(outOfBoundsIDs,1)-flies(outOfBoundsIDs,6)).^2+(flies(outOfBoundsIDs,2)-flies(outOfBoundsIDs,7)).^2));
        b=maxPositions(flies(outOfBoundsIDs,9),9);
        maxPositions(flies(outOfBoundsIDs,9),14:15)=[flies(outOfBoundsIDs,1:2)];%a(i)
        maxPositions(flies(outOfBoundsIDs,9),26)=t;maxPositions(flies(outOfBoundsIDs,9),27)=t;
        for outCount=1:size(outOfBoundsIDs,1)
            if le(b(outCount),a(outCount))
                maxPositions(flies(outOfBoundsIDs(outCount),9),9:11)=[a(outCount) flies(outOfBoundsIDs(outCount),1) flies(outOfBoundsIDs(outCount),2)];
                maxPositions(flies(outOfBoundsIDs(outCount),9),25)=t;
            end
        end
        flies(outOfBoundsIDs,1)=Inf;
        flies(outOfBoundsIDs,2)=Inf;
        flies(outOfBoundsIDs,3)=0;
        flies(outOfBoundsIDs,4)=0;
        flies(outOfBoundsIDs,5)=0;
    end
    %check orientation

end