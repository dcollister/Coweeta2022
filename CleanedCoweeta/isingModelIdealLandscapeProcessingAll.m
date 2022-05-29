function isingModelIdealLandscapeProcessingAll(TRiver,TLand,width,LandType,SubType,AgentPlacementChoice,CoweetaFolder,...
        runType,PhysicalDataFileName,coordsFileName,OrderedStreams,OrderedStreamsCounter,BranchChoice,AgentSubTypeChoice,InsideOrderCounter)
k = physconst('Boltzmann');
k = 1;
%%%%Grid Creation%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%Creating Land Options%%%%%%%%%%%%%%%%%
%%%%%%%Type%%%%%%%
%Coweeta=1,Wedge=2,...%%%%%%%

type=LandType;Shapefile='Coweeta/coweetaProject';
CoweetaCuts={'WholeRiver','WesternCoweeta','SouthernCoweeta','NorthEasternCoweeta'};
TotalIntervals=11;
landTypeName=CoweetaCuts;

if ~isfile(PhysicalDataFileName)
[landscape,riverCoordsFinal]=...
    GridCreation(TotalIntervals,type,landTypeName,width,TRiver,TLand,SubType,Shapefile,...
    AgentPlacementChoice,PhysicalDataFileName,InsideOrderCounter);
else
    load(PhysicalDataFileName,'landscape','riverCoordsFinal')
end

if ~isfile(coordsFileName)
[coords]=agentCoordSettings(Shapefile,'coweeta1.tif',AgentSubTypeChoice,OrderedStreamsCounter,BranchChoice,AgentPlacementChoice,...
    coordsFileName,OrderedStreams,InsideOrderCounter);
else 
    load(coordsFileName,'coords');
end

graphingWhatever(CoweetaFolder,runType,riverCoordsFinal,coords,landscape)    
end