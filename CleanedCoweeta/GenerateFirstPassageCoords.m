function    [Coords] = GenerateFirstPassageCoords(agentsInfoTable,resultsCats,varCoords,timeInput)
numberValsDesired=1;timeVar=timeInput{1};
    function sq=getminkgrp(x,v)
% returns the group variable sequence associated with the n maxk values of x
  n=numberValsDesired;
  [mx,ix]=mink(x,n);
  sq=v(ix);
    end
Coords=cell(size(resultsCats));Shapes=cell(size(resultsCats));

for i=1:length(resultsCats)

    if strcmp(resultsCats{i},'Reproducing Agent')
dataPreBirth=agentsInfoTable{agentsInfoTable.DeathType == 'Reproducing Agent',{varCoords{1} varCoords{2} }};
birthPreTime=agentsInfoTable(agentsInfoTable.DeathType == 'Reproducing Agent',{varCoords{1} varCoords{2} timeVar});
[~,~,birthSetCoordsid2]=unique(dataPreBirth,'rows');
birthPreTime.IDs=birthSetCoordsid2;
[birthg,ig]=findgroups(birthPreTime.IDs);
b=splitapply(@(x) {mink(x,10)},birthPreTime.IDs,birthg);
birthPreTime.seq=[1:height(birthPreTime)].';        % add the sequence number in table of each row
ix=splitapply(@(x1,x2) {getminkgrp(x1,x2)},birthPreTime.IDs,birthPreTime.seq,birthg);  % and return that seq number for the top n
birthmink=(cellfun(@(ix) birthPreTime(ix,1:end-2),ix,'uni',0));  % retrieve those records from full table
birthmink=vertcat(birthmink{:});                             % and combine into a table
Coords{i}=birthmink;

    elseif strcmp(resultsCats{i},'Death From Environment')
dataPreEnviro=agentsInfoTable{agentsInfoTable.DeathType == 'Death From Environment',{varCoords{1} varCoords{2}}};
enviroPreTime=agentsInfoTable(agentsInfoTable.DeathType=='Death From Environment',{varCoords{1} varCoords{2} timeVar});
[~,~,enviroSetCoordsid2]=unique(dataPreEnviro,'rows');
enviroPreTime.IDs=enviroSetCoordsid2;
[envirog,ig]=findgroups(enviroPreTime.IDs);
b=splitapply(@(x) {mink(x,10)},enviroPreTime.IDs,envirog);
enviroPreTime.seq=[1:height(enviroPreTime)].';        % add the sequence number in table of each row
ix=splitapply(@(x1,x2) {getminkgrp(x1,x2)},enviroPreTime.IDs,enviroPreTime.seq,envirog);  % and return that seq number for the top n
enviromink=(cellfun(@(ix) enviroPreTime(ix,1:end-2),ix,'uni',0));  % retrieve those records from full table
enviromink=vertcat(enviromink{:});                             % and combine into a table
Coords{i}=enviromink;

    elseif strcmp(resultsCats{i},'Boundary Escape')
dataPreBoundary=agentsInfoTable{agentsInfoTable.DeathType == 'Boundary Escape',{varCoords{1} varCoords{2} }};
boundPreTime=agentsInfoTable(agentsInfoTable.DeathType=='Boundary Escape',{varCoords{1} varCoords{2} timeVar});
[~,~,boundSetCoordsid2]=unique(dataPreBoundary,'rows');
boundPreTime.IDs=boundSetCoordsid2;
[boundg,~]=findgroups(boundPreTime.IDs);
boundb=splitapply(@(x) {mink(x,10)},boundPreTime.IDs,boundg);
boundPreTime.seq=[1:height(boundPreTime)].';        % add the sequence number in table of each row
ix=splitapply(@(x1,x2) {getminkgrp(x1,x2)},boundPreTime.IDs,boundPreTime.seq,boundg);  % and return that seq number for the top n
boundmink=(cellfun(@(ix) boundPreTime(ix,1:end-2),ix,'uni',0));  % retrieve those records from full table
boundmink=vertcat(boundmink{:});                             % and combine into a table
Coords{i}=boundmink;
    end

end
% 
% 
% 
% AllBirthCountMat=zeros(size(landGrid));All2DPopDistMats{1,1}=AllBirthCountMat;
% AllMaxCountMat=zeros(size(landGrid));All2DPopDistMats{1,2}=AllMaxCountMat;
% AllDeathCountMat=zeros(size(landGrid));All2DPopDistMats{1,3}=AllDeathCountMat;
% ReproBirthCountMat=zeros(size(landGrid));All2DPopDistMats{2,1}=ReproBirthCountMat;
% ReproMaxCountMat=zeros(size(landGrid));All2DPopDistMats{2,2}=ReproMaxCountMat;
% ReproDeathCountMat=zeros(size(landGrid));All2DPopDistMats{2,3}=ReproDeathCountMat;
% NonBirthCountMat=zeros(size(landGrid));All2DPopDistMats{3,1}=NonBirthCountMat;
% NonMaxCountMat=zeros(size(landGrid));All2DPopDistMats{3,2}=NonMaxCountMat;
% NonDeathCountMat=zeros(size(landGrid));All2DPopDistMats{3,3}=NonDeathCountMat;
% BoundBirthCountMat=zeros(size(landGrid));All2DPopDistMats{4,1}=BoundBirthCountMat;
% BoundMaxCountMat=zeros(size(landGrid));All2DPopDistMats{4,2}=BoundMaxCountMat;
% BoundDeathCountMat=zeros(size(landGrid));All2DPopDistMats{4,3}=BoundDeathCountMat;
% 
% for rowCount=1:4
% 
% agentMat=Coords{rowCount};
% 
% a1=sub2ind(size(landGrid),agentMat{:,'BirthCoords_2'},agentMat{:,'BirthCoords_1'});
% a2=sub2ind(size(landGrid),agentMat{:,'RMaxCoords_2'},agentMat{:,'RMaxCoords_1'});
% a3=sub2ind(size(landGrid),agentMat{:,'DeathCoords_2'},agentMat{:,'DeathCoords_1'});
% 
% BirthCountMat=All2DPopDistMats{rowCount,1};
% MaxCountMat=All2DPopDistMats{rowCount,2};
% DeathCountMat=All2DPopDistMats{rowCount,3};
% 
% for i=1:height(a1)
%     BirthCountMat(a1(i))=BirthCountMat(a1(i))+1;
%     MaxCountMat(a2(i))=MaxCountMat(a2(i))+1;
%     DeathCountMat(a3(i))=DeathCountMat(a3(i))+1;
% end
% 
% All2DPopDistMats{rowCount,1}=BirthCountMat;
% All2DPopDistMats{rowCount,2}=MaxCountMat;
% All2DPopDistMats{rowCount,3}=DeathCountMat;
% 
% end

end


% save([testFileFolder saveFileName 'PopDistMatsAndCoordsSets.mat'],'boundDeathSetCoords','NonBoundarySetCoords','BirthSetCoords','NonBirthBoundarySetCoords',...
%     'AllBirthCountMat','AllMaxCountMat','AllDeathCountMat','ReproBirthCountMat','ReproMaxCountMat','ReproDeathCountMat','NonBirthCountMat','NonMaxCountMat','NonDeathCountMat');