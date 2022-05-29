function [] = dataCollectionCaller()
    LandSetupChoices{1}=[1 1 1 4 2 1 1];
    LandSetupChoices{2}=[1 1 2 1 1 3 1];
    TChoices{1}=[1E-3,1E5];
    TChoices{2}=[1E5,1E-3];
    BioChoices{1}=[1E-3,1E-2];
    BioChoices{2}=[1E-3,1E-1];
    
    testToggle=1;
    TChoices{1}=[1E-3,1E5];
    TChoices{2}=[1E5,1E-3];
    %     TestChoiceOptions{1,1}={[1E-3,1E5]};
    load('LandandAltGrids.mat');
    
    %% Physical Data Settings %%
    width=0;
    TLandFull=TChoices{1}(1);%[1E-3,1E5];%
    TRiverFull=TChoices{1}(2);%[1E-3,1E5];%
    
    %%  Biology of the agents   %%
    pdHolder=0.001;%[0.1,0.001];%
    pbHolder=0.01;%[0.1,0.01,0];%
    
    PhysFactorNames={'Low Noise','High Noise'};
    BioFactorNames={'High','Low','Negligible'};
    nMoves=1;
    maxTimeSteps=200000;
    iniPopSize=5000;
    
    
    if testToggle==1
        %% test load\
        testFileInfoFolderHolder{1}='CollectedValues\Test1stLevel\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\';
        testFileInfoFolderHolder{2}='CollectedValues\Test1stLevel\Coweeta\Whole\Complete\Riv_All\Homo\';
        testFileSaveFolderHolder{1}='ProcessedValues\Test1stLevel\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\';
        testFileSaveFolderHolder{2}='ProcessedValues\Test1stLevel\Coweeta\Whole\Complete\Riv_All\Homo\';
        testFigSaveFolderHolder{1}='Figures\Test1stLevel\Riv_Single_Branch_6Mouth\';
        testFigSaveFolderHolder{2}='Figures\Test1stLevel\Homo\';
        testImagesFolderHolder{1}='Images\Test1stLevel\Riv_Single_Branch_6Mouth\';
        testImagesFolderHolder{2}='Images\Test1stLevel\Homo\';
        
        %         'W_0_ET_100000_RT_0.001ProbDeath_0.001ProbBirth_0DanielTestCollectedGroupInfo.mat';
        %         testFileCombinedName='W_0_ET_100000_RT_0.001ProbDeath_0.001ProbBirth_0DanielTestCombinedGroupInfo.mat';
        %         saveFileName='W_0_ET_1E6_RT_1E-3_PD_1E-3_PB_1E-2';
        
        for singleHomoSwitch=1:size(testFileInfoFolderHolder,2)
            testFileFolder=testFileInfoFolderHolder{singleHomoSwitch};
            if ~exist(testFileFolder,'dir')
                mkdir(testFileFolder)
            end
            testSaveFolder=testFileSaveFolderHolder{singleHomoSwitch};
            if ~exist(testSaveFolder,'dir')
                mkdir(testSaveFolder)
            end
            
            testFigSaveFolder=testFigSaveFolderHolder{singleHomoSwitch};
            if ~exist(testFigSaveFolder,'dir')
                mkdir(testFigSaveFolder)
            end
            
            testImagesSaveFolder=testImagesFolderHolder{singleHomoSwitch};
            if ~exist(testImagesSaveFolder,'dir')
                mkdir(testImagesSaveFolder)
            end
            
            for TLCount=1:size(TLandFull,2)
                for TRCount=1:size(TRiverFull,2)
                    for deathCount=1:size(pdHolder,2)
                        for birthCount=1:size(pbHolder,2)
                            % Update Param Values for Run
                            TLand=TLandFull(TLCount);TRiver=TRiverFull(TRCount);
                            pdMain=pdHolder(deathCount);pbMain=pbHolder(birthCount);
                            
                            runName=strcat('W_0_ET_1E',num2str(log10(TLand(1))),'_RT_1E',num2str(log10(TRiver(1))),'_PD_1E',num2str(log10(pdMain)),'_PB_1E',num2str(pbMain),'CollectedGroupInfo.mat');
                            
                            testFileCombinedName=strcat('W_0_ET_1E',num2str(log10(TLand(1))),'_RT_1E',num2str(log10(TRiver(1))),...
                                '_PD_1E',num2str(log10(pdMain)),'_PB_1E',num2str(pbMain),'CombinedGroupInfo.mat');
                            
                            saveFileName=strcat('W_0_ET_1E',num2str(log10(TLand(1))),'_RT_1E',num2str(log10(TRiver(1))),'_PD_1E',...
                                num2str(log10(pdMain)),'_PB_1E',num2str(pbMain));
                            
                            saveName=[testSaveFolder,runName(1:end-5),'DanielTest.mat'];
                            
                            if ~isfile([testFileFolder saveFileName 'PopDistMatsAndCoordsSets.mat'])
                                
                                load([testFileFolder testFileCombinedName],'groupAll','groupNon','groupRepro');
                                
                                [BoundaryDeathSetCoords,NonBoundarySetCoords,BirthsSetCoords,NonBirthBoundarySetCoords,...
                                    AllBirthCountMat,AllMaxCountMat,AllDeathCountMat,ReproBirthCountMat,...
                                    ReproMaxCountMat,ReproDeathCountMat,NonBirthCountMat,NonMaxCountMat,...
                                    NonDeathCountMat] = ...
                                    GeneratePopDistMats(testFileFolder,saveFileName,groupAll,groupRepro,groupNon,landGrid)
                            else
                                
                                load([testFileFolder saveFileName 'PopDistMatsAndCoordsSets.mat'],'AllBirthCountMat','AllMaxCountMat','AllDeathCountMat',...
                                    'ReproBirthCountMat','ReproMaxCountMat','ReproDeathCountMat','NonBirthCountMat','NonMaxCountMat','NonDeathCountMat',...
                                    'BoundaryDeathSetCoords','NonBoundarySetCoords','BirthsSetCoords','NonBirthBoundarySetCoords',...
                                    'AllBirthCountMat','AllMaxCountMat','AllDeathCountMat','ReproBirthCountMat',...
                                    'ReproMaxCountMat','ReproDeathCountMat','NonBirthCountMat','NonMaxCountMat',...
                                    'NonDeathCountMat');
                            end
                            
                            
                            %% Generates Boundary Counters and placements
                            if ~isfile([testFileFolder saveFileName 'BoundDeathCoords.mat'])
                                [BoundaryCoords,boundaryRowY,boundaryColX,Group,maxes,TopRowY1,TopColX1,BottomRowY2,BottomColX2,LeftRowY3,LeftColX3,RightRowY4,RightColX4]=...
                                    CollectingBoundaryDeaths(testFileFolder,saveFileName,AllDeathCountMat);
                            else
                                load([testFileFolder saveFileName 'BoundDeathCoords.mat'],'BoundaryCoords','boundaryRowY','boundaryColX','Group','maxes',...
                                    'TopRowY1','TopColX1','BottomRowY2','BottomColX2','LeftRowY3','LeftColX3','RightRowY4','RightColX4');
                            end
                        end
                    end
                end
            end
        end
    else
    end
    
    
end