function CollectingVectors(testFileFolder,saveFileName)


for i=1:size(groupAll,1)
    AllBirthCountMat(groupAll(i,13),groupAll(i,12))=AllBirthCountMat(groupAll(i,13),groupAll(i,12))+1;
    AllMaxCountMat(groupAll(i,11),groupAll(i,10))=AllMaxCountMat(groupAll(i,11),groupAll(i,10))+1;
    AllDeathCountMat(groupAll(i,15),groupAll(i,14))=AllDeathCountMat(groupAll(i,15),groupAll(i,14))+1;
end

for i=1:size(groupRepro,1)
    ReproBirthCountMat(groupRepro(i,13),groupRepro(i,12))=ReproBirthCountMat(groupRepro(i,13),groupRepro(i,12))+1;
    ReproMaxCountMat(groupRepro(i,11),groupRepro(i,10))=ReproMaxCountMat(groupRepro(i,11),groupRepro(i,10))+1;
    ReproDeathCountMat(groupRepro(i,15),groupRepro(i,14))=ReproDeathCountMat(groupRepro(i,15),groupRepro(i,14))+1;
end

for i=1:size(groupNon,1)
    NonBirthCountMat(groupNon(i,13),groupNon(i,12))=NonBirthCountMat(groupNon(i,13),groupNon(i,12))+1;
    NonMaxCountMat(groupNon(i,11),groupNon(i,10))=NonMaxCountMat(groupNon(i,11),groupNon(i,10))+1;
    NonDeathCountMat(groupNon(i,15),groupNon(i,14))=NonDeathCountMat(groupNon(i,15),groupNon(i,14))+1;
end

boundarySetRows=groupAll(:,27)>0;
birthSetRows=groupAll(:,16)>0;
bothExcludedRows=birthSetRows | boundarySetRows;

a(boundarySetRows)=[];
b(bothExcludedRows)=[];

BoundaryDeathSetCoords=groupAll(boundarySetRows,[9:15,25,27]);
NonBoundarySetCoords=groupAll(a,[9:15,25:26]);
BirthsSetCoords=groupAll(birthSetRows,[9:15,25:26]);
NonBirthBoundarySetCoords=groupAll(b,[9:15,25:26]);


save([testFileFolder saveFileName 'PopDistMatsAndCoordsSets.mat'],'BoundaryDeathSetCoords','NonBoundarySetCoords','BirthsSetCoords','NonBirthBoundarySetCoords',...
    'AllBirthCountMat','AllMaxCountMat','AllDeathCountMat','ReproBirthCountMat','ReproMaxCountMat','ReproDeathCountMat','NonBirthCountMat','NonMaxCountMat','NonDeathCountMat');
end