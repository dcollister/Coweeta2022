function    [Coords, All2DPopDistMats] = Generate2DPopDistMats(agentsInfoTable,landGrid)

AllSetCoords=agentsInfoTable;
EnviroSetCoords=agentsInfoTable(agentsInfoTable.DeathType == 'Death From Environment',:);
BirthsSetCoords=agentsInfoTable(agentsInfoTable.DeathType == 'Reproducing Agent',:);
BoundarySetCoords=agentsInfoTable(agentsInfoTable.DeathType == 'Boundary Escape',:);

Coords = {AllSetCoords BirthsSetCoords EnviroSetCoords BoundarySetCoords};

AllBirthCountMat=zeros(size(landGrid));All2DPopDistMats{1,1}=AllBirthCountMat;
AllMaxCountMat=zeros(size(landGrid));All2DPopDistMats{1,2}=AllMaxCountMat;
AllDeathCountMat=zeros(size(landGrid));All2DPopDistMats{1,3}=AllDeathCountMat;
ReproBirthCountMat=zeros(size(landGrid));All2DPopDistMats{2,1}=ReproBirthCountMat;
ReproMaxCountMat=zeros(size(landGrid));All2DPopDistMats{2,2}=ReproMaxCountMat;
ReproDeathCountMat=zeros(size(landGrid));All2DPopDistMats{2,3}=ReproDeathCountMat;
NonBirthCountMat=zeros(size(landGrid));All2DPopDistMats{3,1}=NonBirthCountMat;
NonMaxCountMat=zeros(size(landGrid));All2DPopDistMats{3,2}=NonMaxCountMat;
NonDeathCountMat=zeros(size(landGrid));All2DPopDistMats{3,3}=NonDeathCountMat;
BoundBirthCountMat=zeros(size(landGrid));All2DPopDistMats{4,1}=BoundBirthCountMat;
BoundMaxCountMat=zeros(size(landGrid));All2DPopDistMats{4,2}=BoundMaxCountMat;
BoundDeathCountMat=zeros(size(landGrid));All2DPopDistMats{4,3}=BoundDeathCountMat;

for rowCount=1:4

agentMat=Coords{rowCount};

a1=sub2ind(size(landGrid),agentMat{:,'BirthCoords_2'},agentMat{:,'BirthCoords_1'});
a2=sub2ind(size(landGrid),agentMat{:,'RMaxCoords_2'},agentMat{:,'RMaxCoords_1'});
a3=sub2ind(size(landGrid),agentMat{:,'DeathCoords_2'},agentMat{:,'DeathCoords_1'});

BirthCountMat=All2DPopDistMats{rowCount,1};
MaxCountMat=All2DPopDistMats{rowCount,2};
DeathCountMat=All2DPopDistMats{rowCount,3};

for i=1:height(a1)
    BirthCountMat(a1(i))=BirthCountMat(a1(i))+1;
    MaxCountMat(a2(i))=MaxCountMat(a2(i))+1;
    DeathCountMat(a3(i))=DeathCountMat(a3(i))+1;
end

All2DPopDistMats{rowCount,1}=BirthCountMat;
All2DPopDistMats{rowCount,2}=MaxCountMat;
All2DPopDistMats{rowCount,3}=DeathCountMat;

end

end


% save([testFileFolder saveFileName 'PopDistMatsAndCoordsSets.mat'],'BoundaryDeathSetCoords','NonBoundarySetCoords','BirthsSetCoords','NonBirthBoundarySetCoords',...
%     'AllBirthCountMat','AllMaxCountMat','AllDeathCountMat','ReproBirthCountMat','ReproMaxCountMat','ReproDeathCountMat','NonBirthCountMat','NonMaxCountMat','NonDeathCountMat');