function [A,sourceAgsMat,sourceAgsAllIDs, SourceAgsBoundIDs, SourceAgsEnviDeathIDs, SourceAgsReproIDs,sourceIDs]=SourceAgents(centerX,centerY,A,sourceR,catchInR,catchOutR)
A.DeathType = categorical(A.DeathType);


centerNBHDXmat=repmat(centerX,height(A),1);
centerNBHDYmat=repmat(centerY,height(A),1);
birthDistFromSourceCenter=sqrt((A.BirthCoords_1-centerNBHDXmat).^2+(A.BirthCoords_2-centerNBHDYmat).^2);
deathDistFromSourceCenter=sqrt((A.DeathCoords_1-centerNBHDXmat).^2+(A.DeathCoords_2-centerNBHDYmat).^2);
A.birthDistFromSourceCenter=birthDistFromSourceCenter;
A.deathDistFromSourceCenter=deathDistFromSourceCenter;
A.XBirthToCenterDiff=A.BirthCoords_1-centerNBHDXmat;
A.YBirthToCenterDiff=A.BirthCoords_2-centerNBHDYmat;
A.XDeathToCenterDiff=A.DeathCoords_1-centerNBHDXmat;
A.YDeathToCenterDiff=A.DeathCoords_2-centerNBHDYmat;

%% Source Agents separated by regions. (1) Stay in source, (2) before first ring, (3) in zone, (4) after outer ring

sourceIDs=find(A.birthDistFromSourceCenter<=sourceR);
sourceAgsMat=A(birthDistFromSourceCenter<=sourceR,:);
BoundDeaths=find(sourceAgsMat.DeathType=="Boundary Escape");
EnvironmentDeaths=find(sourceAgsMat.DeathType=="Death From Environment");
ReproducingDeaths=find(sourceAgsMat.DeathType=="Reproducing Agent");
sourceAgsDeathDistFromSourceCenter=sourceAgsMat.deathDistFromSourceCenter;
sourceAgIDs=1:height(sourceAgsDeathDistFromSourceCenter);
sourceAllAgIDs=sourceAgIDs';

% Remain in source
sourceAgsStayHomeIDs=intersect(sourceAllAgIDs,find(sourceAgsDeathDistFromSourceCenter<=sourceR));
sourceAgIDs=setdiff(sourceAgIDs,sourceAgsStayHomeIDs);

% Beyond Source and before inner ring
sourceAgsBeforeInnerRingIDs=find(sourceAgsDeathDistFromSourceCenter<catchInR);
sourceAgsOutOfSourceBeforeInnerRingIDs=setdiff(sourceAgsBeforeInnerRingIDs,sourceAgsStayHomeIDs);
sourceAgIDs=setdiff(sourceAgIDs,sourceAgsOutOfSourceBeforeInnerRingIDs);

% Catchment annulus agents
sourceAgsBeforeOuterRingIDs=find(sourceAgsDeathDistFromSourceCenter<=catchOutR);
sourceAgsInCatchmentZoneIDs=setdiff(sourceAgsBeforeOuterRingIDs,sourceAgsBeforeInnerRingIDs);
sourceAgIDs=setdiff(sourceAgIDs,sourceAgsInCatchmentZoneIDs);

% Beyond Catchment
sourceAgsAfterOuterRingIDs=find(sourceAgsDeathDistFromSourceCenter>catchOutR);
sourceAgIDs=setdiff(sourceAgIDs,sourceAgsAfterOuterRingIDs);
if ~isempty(sourceAgIDs)
    WeirdGuys=A(sourceAgsAllIDs);
end

sourceAgsAllIDs={sourceAllAgIDs sourceAgsStayHomeIDs sourceAgsOutOfSourceBeforeInnerRingIDs sourceAgsInCatchmentZoneIDs sourceAgsAfterOuterRingIDs};

SourceAgsBoundIDs=intersect(sourceAgsAllIDs{5},BoundDeaths);

SourceAgsEnviDeathIDs={intersect(sourceAgsAllIDs{1},EnvironmentDeaths) intersect(sourceAgsAllIDs{2},EnvironmentDeaths) intersect(sourceAgsAllIDs{3},EnvironmentDeaths) intersect(sourceAgsAllIDs{4},EnvironmentDeaths) intersect(sourceAgsAllIDs{5},EnvironmentDeaths) };

SourceAgsReproIDs={intersect(sourceAgsAllIDs{1},ReproducingDeaths) intersect(sourceAgsAllIDs{2},ReproducingDeaths) intersect(sourceAgsAllIDs{3},ReproducingDeaths) intersect(sourceAgsAllIDs{4},ReproducingDeaths) intersect(sourceAgsAllIDs{5},ReproducingDeaths) };

end