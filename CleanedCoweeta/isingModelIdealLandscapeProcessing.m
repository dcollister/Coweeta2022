 function [agCoords]=isingModelIdealLandscapeProcessing(TRiver,TLand,width,LandType,SubType,AgentPlacementChoice,CoweetaFolder,Shapefile,tifFileName,...
        runType,PhysicalDataFileName,coordsFileName,OrderedStreams,OrderedStreamsCounter,...
        InsideOrderCounter,BranchChoice,AgentSubTypeChoice)
k = physconst('Boltzmann');
k = 1;
%%%%Grid Creation%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%Creating Land Options%%%%%%%%%%%%%%%%%
%%%%%%%Type%%%%%%%
%Coweeta=1,Wedge=2,...%%%%%%%
type=LandType;
% type=LandType;Shapefile='Coweeta/coweetaProject';
CoweetaCuts={'WholeRiver','WesternCoweeta','SouthernCoweeta','NorthEasternCoweeta'};
TotalIntervals=11;
landTypeName=CoweetaCuts;

if ~isfile(PhysicalDataFileName)%1==1%
[landscape,riverCoordsFinal]=...
    GridCreation(TotalIntervals,type,landTypeName,width,TRiver,TLand,SubType,Shapefile,tifFileName,...
    AgentPlacementChoice,PhysicalDataFileName);
else
    load(PhysicalDataFileName,'landscape','riverCoordsFinal')
end

if ~isfile(coordsFileName)%1==1%
[agCoords]=agentCoordSettings(Shapefile,'coweeta1.tif',AgentSubTypeChoice,OrderedStreamsCounter,BranchChoice,AgentPlacementChoice,...
    coordsFileName,OrderedStreams,InsideOrderCounter);
else 
    load(coordsFileName,'agCoords');
end

% graphingWhatever(CoweetaFolder,runType,riverCoordsFinal,coords,landscape)    
end