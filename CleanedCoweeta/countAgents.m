function [] = countAgents(A,sourceAgsIDs,supportAgsIDs,clusters,landGrid,centerX,centerY,catchHandles)
%supportAgsIDs={supportAllAgIDs supportAgsFromSourceID supportAgsOutOfSourceButWithinInnerRingID 
%                               supportAgsFromCatchmentZoneID supportAgsFromBeyondTheOuterRingID};
% sourceAgsIDs={sourceAllAgIDs sourceAgsStayHomeID sourceAgsOutOfSourceBeforeInnerRingID 
%                                   sourceAgsInCatchmentZoneID sourceAgsAfterOuterRingID};
    for sourceRegionCount=3
        sourceAgsOfNote=A(sourceAgsIDs{sourceRegionCount},:);
        sourceAgsOfNote.deathVec1=((sourceAgsOfNote.DeathCoords_1)-centerX*ones(height(sourceAgsOfNote)));
        sourceAgsOfNote.deathVec2=((sourceAgsOfNote.DeathCoords_2)-centerY*ones(height(sourceAgsOfNote)));
        meanPerformanceByRegionVec=[sum(sourceAgsOfNote.deathVec1/height(sourceAgsOfNote.deathVec1)) sum(sourceAgsOfNote.deathVec2/height(sourceAgsOfNote.deathVec2))];
%         sourceAgsOfNote.distanceFromCenter=
        supportAgsOfNote=A(supportAgsIDs{sourceRegionCount},:);
        
    
    
    end

% ComparisonFigure=tiledlayout(1,1);
AgentComparisonByCatchmentandRegionFigure=figure;
nexttile
hold on
contour(landGrid);



end
