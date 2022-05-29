load('LandandAltGrids.mat','altLandGrid','landGrid');
[rivCoords,rivNodesInReg,clusters]=...
    FindRiverAreas(altLandGrid,landGrid,392,405,10,240,260); 
fileHolder="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\FebruaryRuns\Coweeta\Whole\FirstOrder\";
singlefileParamName='SimResults\FebruaryRuns\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\*';
mainDirContents = dir(singlefileParamName);
mask = ismember( {mainDirContents.name}, {'.', '..'});
mainDirContents(mask) = [];
num_subfolder = length(mainDirContents);

vnames = {'FileHolder', 'LandFiles', 'ParamName', 'OFATName','PBName','ET', 'RT', 'ProbDeath', 'ProbReproduction', 'ProcessedName'};
nv = length(vnames);
vt(1:5) = "string";
vt(6:9) = "double";
vt(10) = "string";
NamesandParamsTable = table('Size', [0 nv], 'VariableNames', vnames, 'VariableTypes', vt);

for fileCounter=1:num_subfolder
    fileType=mainDirContents(fileCounter).folder;
    filename=mainDirContents(fileCounter).name;
    Type="Riv_Single_Branch_6\Mouth";
    N=split(filename,["ET_","_RT_","ProbDeath_","ProbBirth_","Timestamp"]);
    if size(N,1)>=5
        for numCount=2:5
        NewNums(numCount-1) = str2double(N{numCount});
        end
        NamesandParamsTable.FileHolder(fileCounter)=fileHolder;
        NamesandParamsTable.LandFiles(fileCounter)=fileHolder;
        NamesandParamsTable.ParamName(fileCounter)="Riv_Single_Branch_6\Mouth";
        NamesandParamsTable.OFATName(fileCounter)="Riv_Single_Branch_6\Mouth";
        NamesandParamsTable.PBName(fileCounter)="Riv_Single_Branch_6\Mouth";
        NamesandParamsTable.ProcessedName(fileCounter)='';
        NamesandParamsTable.ET(fileCounter)=NewNums(1);
        NamesandParamsTable.RT(fileCounter)=NewNums(2);
        NamesandParamsTable.ProbDeath(fileCounter)=NewNums(3);
        NamesandParamsTable.ProbReproduction(fileCounter)=NewNums(4);
    load([fileType,'\',filename],'maxPositions');
% SourceAgents=...
%     FridaySourceAgents(392,405,maxPositions,10,240,260);
% supportAgsIDs=...
%     FridaySupportAgents(392,405,maxPositions,10,240,260);
    NamesandParamsTable.MeanAllDeathDistance(fileCounter)=mean(maxPositions(:,9));
    NamesandParamsTable.MeanAllDeathTime(fileCounter)=mean(maxPositions(:,26));
    NamesandParamsTable.MeanAllReproductionTime(fileCounter)=mean(maxPositions(maxPositions(:,16)==1,26));
    NamesandParamsTable.MeanReproductionX(fileCounter)=mean(maxPositions(maxPositions(:,16)==1,14));
    NamesandParamsTable.MeanReproductionY(fileCounter)=mean(maxPositions(maxPositions(:,16)==1,15));
    NamesandParamsTable.MeanAllReproductionTime(fileCounter)=mean(maxPositions(maxPositions(:,27)>0,26));
    NamesandParamsTable.MeanBoundaryX(fileCounter)=mean(maxPositions(maxPositions(:,27)>0,14));
    NamesandParamsTable.MeanBoundaryY(fileCounter)=mean(maxPositions(maxPositions(:,27)>0,15));
    else
    end
end

for fileCounter=1:num_subfolder
    
end
scatter3(NamesandParamsTable.ET,NamesandParamsTable.RT,NamesandParamsTable.ProbDeath);

