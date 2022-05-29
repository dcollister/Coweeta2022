function [runName,testFileCombinedName,testFileCollectedName,saveFileName,saveName] = dataCollectionCallerandSaver(testFileFolder,landGrid,testSaveFolder,TLand,TRiver,pdMain,pbMain)
    
    runName=strcat('W_0_ET_1E',num2str(log10(TLand(1))),'_RT_1E',num2str(log10(TRiver(1))),'_PD_1E',num2str(log10(pdMain)),'_PB_1E',num2str(pbMain),'CollectedGroupInfo.mat');
    
    testFileCombinedName=strcat('W_0_ET_1E',num2str(log10(TLand(1))),'_RT_1E',num2str(log10(TRiver(1))),...
        '_PD_1E',num2str(log10(pdMain)),'_PB_1E',num2str(pbMain),'CombinedGroupInfo.mat');
    
    testFileCollectedName=strcat('W_0_ET_1E',num2str(log10(TLand(1))),'_RT_1E',num2str(log10(TRiver(1))),...
        '_PD_1E',num2str(log10(pdMain)),'_PB_1E',num2str(pbMain),'CollectedGroupInfo.mat');
    
    saveFileName=strcat('W_0_ET_1E',num2str(log10(TLand(1))),'_RT_1E',num2str(log10(TRiver(1))),'_PD_1E',...
        num2str(log10(pdMain)),'_PB_1E',num2str(pbMain));
    
    saveName=strcat('W_0_ET_1E',num2str(log10(TLand(1))),'_RT_1E',num2str(log10(TRiver(1))),'_PD_1E',...
        num2str(log10(pdMain)),'_PB_',num2str(pbMain));
    
    if ~isfile([testFileFolder saveFileName 'PopDistMatsAndCoordsSets.mat'])
        
        load([testFileFolder testFileCombinedName],'groupAll','groupNon','groupRepro');
        
        [~,~,~,~,~,~,AllDeathCountMat,~,~,~,~,~,~] = ...
            GeneratePopDistMats(testFileFolder,saveFileName,groupAll,groupRepro,groupNon,landGrid);
    else
        
%         load([testFileFolder saveFileName 'PopDistMatsAndCoordsSets.mat'],'AllBirthCountMat','AllMaxCountMat','AllDeathCountMat',...
%             'ReproBirthCountMat','ReproMaxCountMat','ReproDeathCountMat',...
%             'NonBirthCountMat','NonMaxCountMat','NonDeathCountMat',...
%             'BoundaryDeathSetCoords','NonBoundarySetCoords','BirthsSetCoords','NonBirthBoundarySetCoords',...
%             'AllBirthCountMat','AllMaxCountMat','AllDeathCountMat',...
%             'ReproBirthCountMat','ReproMaxCountMat','ReproDeathCountMat',...
%             'NonBirthCountMat','NonMaxCountMat','NonDeathCountMat');
    end
    
    
    %% Generates Boundary Counters and placements
    if ~isfile([testFileFolder saveFileName 'BoundDeathCoords.mat'])
        [~,~,~,~,~,~,~,~,~,~,~,~,~]=...
            CollectingBoundaryDeaths(testFileFolder,saveFileName,AllDeathCountMat);
    else
%         load([testFileFolder saveFileName 'BoundDeathCoords.mat'],'BoundaryCoords','boundaryRowY','boundaryColX','Group','maxes',...
%             'TopRowY1','TopColX1','BottomRowY2','BottomColX2','LeftRowY3','LeftColX3','RightRowY4','RightColX4');
    end
    
%     %% Generates Boundary Counters and placements
%     if ~isfile([testFileFolder saveFileName 'VectorsForComparison.mat'])
%         
%         if isfile([testFileFolder testFileCollectedName])
%             copyfile 
%         load([testFileFolder testFileCollectedName],'groupAll','groupNon','groupRepro');
%         load([testFileFolder testFileCombinedName],'groupAll','groupNon','groupRepro');
%         
%         CollectingVectors(testFileFolder,saveFileName,AllDeathCountMat);
%     else
%         load([testFileFolder saveFileName 'BoundDeathCoords.mat'],'BoundaryCoords','boundaryRowY','boundaryColX','Group','maxes',...
%             'TopRowY1','TopColX1','BottomRowY2','BottomColX2','LeftRowY3','LeftColX3','RightRowY4','RightColX4');
%     end
    
end