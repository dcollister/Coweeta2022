function [AllCollectedInformation]=convertMaxToTable(maxPositions,parameterValues,filename)
AgentTypes=["" "Reproducing Agent" "Boundary Escape" "Death From Environment"] ;
% Filename=convertCharsToStrings(this_folder);

% if ~isfile([mainDirContents(runCount).folder '\Fileinfo_' this_folder(1:end-4) '.csv'])
%     Seed=ComparisonObject.s;
%     fileInfo=table(Filename,Seed);
%     writetable(fileInfo,[mainDirContents(runCount).folder '\Fileinfo_' this_folder(1:end-4) '.csv'])
%% Clean up from commparison object to maxPositions
idAll = maxPositions(:,9)>=0;
idRepro = maxPositions(:,16)>0;
idBound = maxPositions(:,27)>0;
idNonRNonB = ( ~idRepro & ~idBound );

IDAll=find(idAll);
IDRepro=find(idRepro);
IDBound=find(idBound);
IDNonRNonB=find(idNonRNonB);
indCount2=zeros(4,1);

if ~isempty(IDAll)
    indArray{1}=IDAll;
    indCount2(1)=1;
end
if ~isempty(IDRepro)
    indArray{2}=IDRepro;
    indCount2(2)=1;
end
if ~isempty(IDBound)
    indArray{3}=IDBound;
    indCount2(3)=1;
end
if ~isempty(IDNonRNonB)
    indArray{4}=IDNonRNonB;
    indCount2(4)=1;
end

% TablesNames={'AllCollectedInformation' 'ReproCollectedInformation' 'BoundCollectedInformation' 'NonRNonBCollectedInformation'};
MaxPositions=maxPositions;

XminCoords_1=MaxPositions(:,1);
XminCoords_2=MaxPositions(:,2);
XMaxCoords_1=MaxPositions(:,3);
XMaxCoords_2=MaxPositions(:,4);
YMinCoords_1=MaxPositions(:,5);
YMinCoords_2=MaxPositions(:,6);
YMaxCoords_1=MaxPositions(:,7);
YMaxCoords_2=MaxPositions(:,8);
RadialMax=MaxPositions(:,9);
RMaxCoords_1=MaxPositions(:,10);
RMaxCoords_2=MaxPositions(:,11);
BirthCoords_1=MaxPositions(:,12);
BirthCoords_2=MaxPositions(:,13);
DeathCoords_1=MaxPositions(:,14);
DeathCoords_2=MaxPositions(:,15);
ReproCounter=MaxPositions(:,16);
AgentID=MaxPositions(:,17);
BeginningBranch=MaxPositions(:,18);
Gender=MaxPositions(:,19);
GenePool=MaxPositions(:,20);
XMinTime=MaxPositions(:,21);
XMaxTime=MaxPositions(:,22);
YMinTime=MaxPositions(:,23);
YMaxTime=MaxPositions(:,24);
RadialMaxTime=MaxPositions(:,25);
DeathTime=MaxPositions(:,26);
BoundaryDeathTime=MaxPositions(:,27);
ReproDeathTime=MaxPositions(:,28);
% Convert cell to a table and use first row as variable names

AllCollectedInformation=table(XminCoords_1,XminCoords_2,XMaxCoords_1,XMaxCoords_2,YMinCoords_1,YMinCoords_2,YMaxCoords_1,YMaxCoords_2,RadialMax,RMaxCoords_1,RMaxCoords_2,BirthCoords_1,BirthCoords_2,DeathCoords_1,DeathCoords_2,ReproCounter,AgentID,BeginningBranch,Gender,GenePool,XMinTime,XMaxTime,YMinTime,YMaxTime,RadialMaxTime,DeathTime,BoundaryDeathTime,ReproDeathTime);

for typeCount=1:width(indArray)
    AllCollectedInformation.DeathType(indArray{typeCount},1)=AgentTypes(typeCount);
end

AllCollectedInformation.DeathType = categorical(AllCollectedInformation.DeathType);
%         writetable(AllCollectedInformation,[mainDirContents(runCount).folder '\AllCollectedInformation_' this_folder(1:end-4) '.csv'])
%         clear XminCoords XMaxCoords YMinCoords YMaxCoords RadialMaxCoords RMaxCoords BirthCoords DeathCoords ReproCounter AgentID BeginningBranch Gender GenePool XMinTime XMaxTime YMinTime YMaxTime RadialMaxTime DeathTime BoundaryDeathTime ReproDeathTime
AllCollectedInformation.deathDist=sqrt((AllCollectedInformation.DeathCoords_1-AllCollectedInformation.BirthCoords_1).^2+(AllCollectedInformation.DeathCoords_2-AllCollectedInformation.BirthCoords_2).^2);


end