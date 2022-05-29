 %landGrid2 is 3-d values at river nodes
%landGrid is 0/1 values of river nodes
%checkChoice=1 big population distribution, checkChoice=2 comparing runs
function visualCheck()
    hold off
    close all

    testToggle=1;
    graphingToggle=1;

    SimSetupChoice=2;TUserChoice1=1:2;TUserChoice2=1:2;BioUserChoice1=1:2;BioUserChoice2=1:2;
    for T1=1:size(TUserChoice1,2)
        TChoice1=TUserChoice1(T1);
        for T2=1:size(TUserChoice2,2)
            TChoice2=TUserChoice2(T2);
            for b1=1:size(BioUserChoice1,2)
                BioChoice1=BioUserChoice1(b1);
                for b2=1:size(BioUserChoice2,2)
                    BioChoice2=BioUserChoice2(b2);
                    PhysFactorNames={'High Response','High Noise'};
                    BioFactorNames={'High','Low','Negligible'};
                    nMoves=1;
                    maxTimeSteps=200000;
                    iniPopSize=5000;


                    for singleHomoSwitch=1:size(SimSetupChoice,2)
                        [width,TLandFull,TRiverFull,pdHolder,pbHolder,...
                            LandType,SubTypeChoice,AgentSubTypeChoiceSet,OrderedStreamsCounterSet,BranchChoice,AgentPlacement,wholesaveToggle,titleTopLineFrontPiece]...
                            =ParameterChoiceSetsValues(singleHomoSwitch,TChoice1,TChoice2,BioChoice1,BioChoice2);
                        if testToggle==1
                            %% test load\

                            load('LandandAltGrids.mat');

                            [testFileFolder,testSaveFolder,testFigSaveFolder,testImagesSaveFolder] = namesAndFilesCreatorAndSaverForTestCases(singleHomoSwitch);

                            for TLCount=1:size(TLandFull,2)
                                for TRCount=1:size(TRiverFull,2)
                                    for deathCount=1:size(pdHolder,2)
                                        for birthCount=1:size(pbHolder,2)
                                            % Update Param Values for Run
                                            TLand=TLandFull(TLCount);TRiver=TRiverFull(TRCount);
                                            pdMain=pdHolder(deathCount);pbMain=pbHolder(birthCount);

                                            [runName,testFileCombinedName,testFileCollectedName,saveFileName,saveName] = ...
                                                dataCollectionCallerandSaver(testFileFolder,landGrid,testSaveFolder,TLand,TRiver,pdMain,pbMain);

                                            load([testFileFolder saveFileName 'PopDistMatsAndCoordsSets.mat'],...
                                                'BoundaryDeathSetCoords','NonBoundarySetCoords','BirthsSetCoords','NonBirthBoundarySetCoords',...
                                                'ReproMaxCountMat','ReproDeathCountMat','AllDeathCountMat','NonDeathCountMat')

                                            %% Figure/JPG generation for 3-d histogram evaluation
                                            MultiDimensionalFigureGenerator(testFigSaveFolder,testImagesSaveFolder,saveName,PhysFactorNames,BioFactorNames,...
                                                titleTopLineFrontPiece,BirthsSetCoords,ReproDeathCountMat,AllDeathCountMat,BioChoice1,BioChoice2,TChoice1,TChoice2,singleHomoSwitch);

%                                             FourFigPlot(testFileFolder,testFileCombinedName,testFileCollectedName,testFigSaveFolder,testImagesSaveFolder,saveName,...
%                                                 PhysFactorNames,BioFactorNames,titleTopLineFrontPiece,...
%                                                 BirthsSetCoords,ReproDeathCountMat,AllDeathCountMat,...
%                                                 BioChoice1,BioChoice2,TChoice1,TChoice2,singleHomoSwitch)
                                            %                                             FourFigPlot(testFileFolder,testFileCombinedName,testFileCollectedName,testFigSaveFolder,testImagesSaveFolder,saveName,...
                                            %                                                 PhysFactorNames,BioFactorNames,titleTopLineFrontPiece,...
                                            %                                                 BirthsSetCoords,ReproDeathCountMat,AllDeathCountMat,...
                                            %                                                 BioChoice1,BioChoice2,TChoice1,TChoice2,singleHomoSwitch,TLand,TRiver,pdMain,pbMain)
                                        end
                                    end
                                end
                            end
                        else
                        end
                    end
                end
            end
        end
    end
    %% Ok
    % ({'Elevation Contour Isolines (meters above sea level).','The Coweeta river network.','Spawn Location.'})
    %% Agent Coordinate search for matrices with non-zero values.
    %[agRowYHolder,agColXHolder]=find(ReproDeathCountMat>0);
    %agZHolder=zeros(size(agRowYHolder,1));
    %for agCount=1:size(agRowYHolder,1)
    %    agZHolder(agCount,1)=ReproDeathCountMat(agRowYHolder(agCount,1),agColXHolder(agCount,1));
    %    agZHolder(agCount,2)=agCount;
    %end
    %agZHolder=sortrows(agZHolder,1,'descend');
    %agZ=agZHolder(:,1);
    %agRowY=agRowYHolder(agZHolder(:,2));
    %agColX=agColXHolder(agZHolder(:,2));

    %% Creating a Mesh Grid for Contour if needed
    % x = altLandGrid(1,:);
    % y = altLandGrid(:,1);
    % [X,Y]=meshgrid(x,y);
    % Z=altLandGrid;