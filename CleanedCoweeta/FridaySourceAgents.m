function [sourceAgsIDs]=FridaySourceAgents(centerX,centerY,A,sourceR,catchInR,catchOutR)
centerNBHDXmat=repmat(centerX,height(A),1);
centerNBHDYmat=repmat(centerY,height(A),1);
birthDistFromSourceCenter=sqrt((A(:,12)-centerNBHDXmat).^2+(A(:,13)-centerNBHDYmat).^2);
A.birthDistFromSourceCenter=birthDistFromSourceCenter;
A.XBirthDiff=A(:,12)-centerNBHDXmat;
A.YBirthDiff=A(:,13)-centerNBHDYmat;

%% Source Agents separated by regions. (1) Stay in source, (2) before first ring, (3) in zone, (4) after outer ring

sourceAllAgIDs=find(birthDistFromSourceCenter<=sourceR);
sourceAgsFromCenter=A(birthDistFromSourceCenter<=sourceR,:);
centerXmat=repmat(centerX,height(sourceAgsFromCenter),1);
centerYmat=repmat(centerY,height(sourceAgsFromCenter),1);
sourceAgsDeathDistFromSourceNodeCenter=sqrt((sourceAgsFromCenter(:,14)-centerXmat).^2+(sourceAgsFromCenter(:,15)-centerYmat).^2);
A.deathDistFromSourceCenter=birthDistFromSourceCenter;
A.XDeathDiff=A(:,14)-centerNBHDXmat;
A.YDeathDiff=A(:,15)-centerNBHDYmat;
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
if ~isempty(sourceAgIDs)
    WeirdGuys=A(sourceAgsIDs);
end
sourceAgsIDs={sourceAllAgIDs sourceAgsStayHomeID sourceAgsOutOfSourceBeforeInnerRingID sourceAgsInCatchmentZoneID sourceAgsAfterOuterRingID};
end