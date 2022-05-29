function [filenameholder,filename,River,Elevation,maxPositions]=...
        PreCoweetaMainScript(pb,pd,nmoves,altprobcoeff,type,upcoeff,probtype,bias,filename,fileHolder,...
        landscapename,coordsFileName,coordsFlip,coordsInput,name,runType,maxTimeSteps,iniPopSize,NormedName,wholesaveToggle)
time=maxTimeSteps;
popSize=iniPopSize;
load(landscapename,'landscape','riverscape','preWeights');
River=riverscape;
Elevation=landscape;

if coordsFlip==0
load(coordsFileName,'agCoords','riverBranchNumber');
Coordinates=agCoords;
else
Coordinates=coordsInput;
riverBranchNumber=10;
end

    [filenameholder,maxPositions]= ...
        IdealizedCoweetaMainScript(River,Elevation,pb,pd,nmoves,...
            altprobcoeff,type,upcoeff,probtype,bias,Coordinates,filename,...
            fileHolder,time,popSize,preWeights,name,runType,NormedName,wholesaveToggle,riverBranchNumber);
end
% end
% end load(DataName,'deltaGrid','landscape','riverscape','landGrid_prob','riverGrid_prob','preWeights','riverCoordsFinal','preWeightsRestrictRiver','preWeightsRestrictLand');
        