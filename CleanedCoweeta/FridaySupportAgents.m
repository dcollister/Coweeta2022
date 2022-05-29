function [supportAgsIDs]=FridaySupportAgents(centerX,centerY,A,sourceR,catchInR,catchOutR)

centerNBHDXmat=repmat(centerX,height(A),1);
centerNBHDYmat=repmat(centerY,height(A),1);
deathDistFromSourceCenter=sqrt((A.DeathCoords_1-centerNBHDXmat).^2+(A.DeathCoords_2-centerNBHDYmat).^2);

%% Support Agents separated by regions. Stay in source, before first ring, in zone, after outer ring

supportAllAgIDs=find(deathDistFromSourceCenter<=sourceR);
supportAgsToCenter=A(deathDistFromSourceCenter<=sourceR,:);
centerXmat=repmat(centerX,height(supportAgsToCenter),1);
centerYmat=repmat(centerY,height(supportAgsToCenter),1);
supportAgsBirthDistFromSourceNodeCenter=sqrt((supportAgsToCenter.BirthCoords_1-centerXmat).^2+(supportAgsToCenter.BirthCoords_2-centerYmat).^2);
supportAgIDs=1:height(supportAgsToCenter);

% Ags from source support
supportAgsFromSourceID=find(supportAgsBirthDistFromSourceNodeCenter<=sourceR);
supportAgIDs=setdiff(supportAgIDs,supportAgsFromSourceID);

% Ags from beyond Source and before inner ring
supportAgsCloserThanInnerRingID=find(supportAgsBirthDistFromSourceNodeCenter<=catchInR);
supportAgsOutOfSourceButWithinInnerRingID=setdiff(supportAgsCloserThanInnerRingID,supportAgsFromSourceID);
supportAgIDs=setdiff(supportAgIDs,supportAgsOutOfSourceButWithinInnerRingID);

% Ags from Catchment annulus agents
supportAgsCloserThanOuterRingID=find(supportAgsBirthDistFromSourceNodeCenter<=catchOutR);
supportAgsFromCatchmentZoneID=setdiff(supportAgsCloserThanOuterRingID,supportAgsCloserThanInnerRingID);
supportAgIDs=setdiff(supportAgIDs,supportAgsFromCatchmentZoneID);

% Ags from Beyond Catchment
supportAgsFromBeyondTheOuterRingID=find(supportAgsBirthDistFromSourceNodeCenter>catchOutR);
supportAgIDs=setdiff(supportAgIDs,supportAgsFromBeyondTheOuterRingID);
if ~isempty(supportAgIDs)
    WeirdGuys=A(supportAgIDs);
end

supportAgsIDs={supportAllAgIDs supportAgsFromSourceID supportAgsOutOfSourceButWithinInnerRingID supportAgsFromCatchmentZoneID supportAgsFromBeyondTheOuterRingID};

% colonizeAgsDistFromSingCenter