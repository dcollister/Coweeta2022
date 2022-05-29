function [SourceAgsIDs]=getSourceAgentsInCatchmentZones(centerX,centerY,A,sourceR,catchInR,catchOutR)

centerNBHDXmat=repmat(centerX,height(A),1);
centerNBHDYmat=repmat(centerY,height(A),1);

%Distances from chosen COM for source nbhd
birthDistFromCenter=sqrt((A.BirthCoords_1-centerNBHDXmat).^2+(A.BirthCoords_2-centerNBHDYmat).^2);

%% Source Agents separated by regions. Stay in source, before first ring, in zone, after outer ring
sourceAgsFromCenter=A(birthDistFromCenter<=sourceR,:);
centerXmat=repmat(centerX,height(sourceAgsFromCenter),1);
centerYmat=repmat(centerY,height(sourceAgsFromCenter),1);
sourceAgsDeathDistFromSourceNodeCenter=sqrt((sourceAgsFromCenter.DeathCoords_1-centerXmat).^2+(sourceAgsFromCenter.DeathCoords_2-centerYmat).^2);

% Remain in source
sourceAgsStayHomeID=find(sourceAgsDeathDistFromSourceNodeCenter<catchInR);

% Beyond Source and before inner ring
sourceAgsBeforeInnerRingID=find(sourceAgsDeathDistFromSourceNodeCenter<catchInR);
sourceAgsOutOfSourceBeforeInnerRingID=intersect(sourceAgsStayHomeID,sourceAgsBeforeInnerRingID);

% Catchment annulus agents
sourceAgsBeyondInnerRingID=find(sourceAgsDeathDistFromSourceNodeCenter>=catchInR);
sourceAgsBeforeOuterRingID=find(sourceAgsDeathDistFromSourceNodeCenter<=catchOutR);
sourceAgsInCatchmentZoneID=intersect(sourceAgsBeyondInnerRingID,sourceAgsBeforeOuterRingID);

% Beyond Catchment
sourceAgsAfterOuterRingID=find(sourceAgsDeathDistFromSourceNodeCenter>catchOutR);

SourceAgsIDs=[sourceAgsStayHomeID sourceAgsOutOfSourceBeforeInnerRingID sourceAgsInCatchmentZoneID sourceAgsAfterOuterRingID];

end