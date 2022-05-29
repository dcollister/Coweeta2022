function [SourceAgsIDs]=getSourceAgentsInCatchmentZones(centerX,centerY,A,sourceR,catchInR,catchOutR)

centerNBHDXmat=repmat(centerX,height(A),1);
centerNBHDYmat=repmat(centerY,height(A),1);
birthDistFromSourceCenter=sqrt((A.BirthCoords_1-centerNBHDXmat).^2+(A.BirthCoords_2-centerNBHDYmat).^2);

%% Source Agents separated by regions. (1) Stay in source, (2) before first ring, (3) in zone, (4) after outer ring
sourceAgsFromCenter=A(birthDistFromSourceCenter<=sourceR,:);
centerXmat=repmat(centerX,height(sourceAgsFromCenter),1);
centerYmat=repmat(centerY,height(sourceAgsFromCenter),1);
sourceAgsDeathDistFromSourceNodeCenter=sqrt((sourceAgsFromCenter.DeathCoords_1-centerXmat).^2+(sourceAgsFromCenter.DeathCoords_2-centerYmat).^2);
sourceAgIDs=1:height(sourceAgsDeathDistFromSourceNodeCenter);

% Remain in source
sourceAgsStayHomeID=find(sourceAgsDeathDistFromSourceNodeCenter<=sourceR);
sourceAgIDs=setdiff(sourceAgIDs,sourceAgsStayHomeID);

% Beyond Source and before inner ring
sourceAgsBeforeInnerRingID=find(sourceAgsDeathDistFromSourceNodeCenter<catchInR);
sourceAgsOutOfSourceBeforeInnerRingID=setdiff(sourceAgsBeforeInnerRingID,sourceAgsStayHomeID);
sourceAgIDs=setdiff(sourceAgIDs,sourceAgsOutOfSourceBeforeInnerRingID);

% Catchment annulus agents
sourceAgsBeforeOuterRingID=find(sourceAgsDeathDistFromSourceNodeCenter<=catchOutR);
sourceAgsInCatchmentZoneID=setdiff(sourceAgsBeforeOuterRingID,sourceAgsBeforeInnerRingID);
sourceAgIDs=setdiff(sourceAgIDs,sourceAgsInCatchmentZoneID);

% Beyond Catchment
sourceAgsAfterOuterRingID=find(sourceAgsDeathDistFromSourceNodeCenter>catchOutR);
sourceAgIDs=setdiff(sourceAgIDs,sourceAgsAfterOuterRingID);

SourceAgsIDs={sourceAgsStayHomeID sourceAgsOutOfSourceBeforeInnerRingID sourceAgsInCatchmentZoneID sourceAgsAfterOuterRingID};
end