% LandType=1:= Coweeta, LandType=2:=Ideal
%%  Choose the subtype of landscape with %%
%%              SubTypeChoice %%
%% (This includes all branches within that region for both Elevation and River    %%
%     SubTypeChoice=1=Whole Coweeta Landscape\Wedge [1:17]
%     SubTypeChoice=2=Western Neighborhood\Trough   [4:6 11:14]
%     SubTypeChoice=3=Southern Neighborhood\Tilted  [3:6 14:17]
%     SubTypeChoice=4=NorthEastern Neighborhood     [1:4 7:10 15]
%     SubTypeChoice=5=InnerWestern Neighborhood     [4:6 11 13]
%%  Choose the subtype of landscape with %%
%%              AgentSubTypeChoice %%
%% (This includes all branches within that region for both Elevation and River    %%
%     AgentSubTypeChoice=1=Whole Coweeta Landscape\Wedge [1:17]
%     AgentSubTypeChoice=2=Western Neighborhood\Trough   [4:6 11:14]
%     AgentSubTypeChoice=3=Southern Neighborhood\Tilted  [3:6 14:17]
%     AgentSubTypeChoice=4=NorthEastern Neighborhood     [1:4 7:10 15]
%     AgentSubTypeChoice=5=InnerWestern Neighborhood     [4:6 11 13]
%%  Choose the Order of landscape to consider for the agents with %%
%%              OrderedStreamsCounter %%
%     OrderedStreamsCounter=1 :=First Order (Feeder streams.  Usually
%     smallest and on periphery)
%           Whole=[6 8 10 12:14 16 17], West=[6 12:14], South=[6 14 16 17],
%           NE=[8 10], WIn=[4:6 11 13], WIn=[6 13]
%     OrderedStreamsCounter=2 :=Second Order (1+1=2, 2+1=2, 1+2=2)
%           Whole=[5 11 15], West=[5 11], South=[5 15], NE=15, WIn=[5 11]
%     OrderedStreamsCounter=3 :=Third Order (x+3=3 for x<3, 3+3=4)
%           Whole=[1:4], West=4, South=[3 4], NE=[1:4], WIn=4
%     OrderedStreamsCounter=4 :=Whole Neighborhood
%           Whole=[1:17], West=[4:6 11:14], South=[3:6 14:17], NE=[1:4 7:10
%           15], WIn=[4:6 11 13]
%%  Choose the Branches within region to consider for the agents with %%
%%          `   BranchChoices     %%
%     BranchChoices=1 :=Single BranchChoices=2 :=All
%%  Choose the Placement of the agents on the Branch with %%
%%              AgentPlacement  %%
%     AgentPlacement=1 := Homogeneous (All choices from Branches are
%     covered homogeneously with agents AgentPlacement=2 := SPtHead
%     AgentPlacement=3 :=SPtMouth AgentPlacement=4 :=SPtMiddle
%%  Toggle Whole Run Save  with %%
%%              wholesaveToggle %%
%     wholesaveToggle=0 Only saveMaxpositions wholesaveToggle=1
%     saveEVERYTHING!!!

function IsingModelCompletePipeline()
clc
clear
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Settings  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LandChoice=1;placeChoice=1;TChoice=1;BioChoice=1;BranchChoice=10;
if LandChoice>1
[LandSetupChoices, InsideOrderCounterSet, SingleBranchValue]=setChoices(LandChoice,BranchChoice,placeChoice);
else 
    LandSetupChoices{1}=[1 1 1 4 2 1 1];InsideOrderCounterSet{1}=100;
end
% AgentPlacementNames={'Homo','Head','Mouth','Mid','UpperFourth','LowerFourth','Staggered'};
%% How many runs per parameter value set? %
maxRuns=1;
%% Physical Data Settings %%
width=0;
TLandFull=10;%[0.001 0.01 0.1 0.9999];% [1.01 10 100 1000 10000];%logspace(1,5,6);%1E5;%[1E-2 1 1E2];%[1E-3 1E1 1E5];%logspace(-3,5,9);%TChoices{TChoice}(1);%
TRiverFull=1;%[0.001 0.01 0.1 0.9999];%logspace(-3,5,9);%1E5;%[1E-1 1E1 1E3];%TChoices{TChoice}(2);%1E5;%1E5;%1E-0;%
%% Biology of the agents  %%
pdHolder=[1E-3 1E-4 1E-5];%[1E-2 1E-3];%linspace(1E-4,1E-2,100);%[1E-1 1E-3];%BioChoices{BioChoice}(1);0.00001;%
pbHolder=[1E-2 1E-3];%linspace(1E-3,1E-1,100);%1e-2;%1E-30;%0.01;%[1E-1 1E-2 1E-3 0];%1E-2;%logspace(-4,-1,10);%BioChoices{BioChoice}(2);[1E-1 1E-30];%
maxTimeSteps=86400;%5*86400;%One Day=
iniPopSize=1E4;

%%  Coords Clip 0 = homo/single6
%%  CoordsFlip=1 ==> (292 799) Headwaters Branch 10 coarse map, CoordsFlip=0 ==>
coordsFlip=0;reproSwitch=1;
coordsInput=[292 799];
%     SimSetupChoice=2;TUserChoice1=1:2;TUserChoice2=1:2;BioUserChoice1=1:2;BioUserChoice2=1:2;


LandType=LandSetupChoices{LandChoice}(1);
SubTypeChoice=LandSetupChoices{LandChoice}(2);%1:4
AgentSubTypeChoiceSet=LandSetupChoices{LandChoice}(3);%[2 5];
OrderedStreamsCounterSet=LandSetupChoices{LandChoice}(4);%[1 4];
BranchChoice=LandSetupChoices{LandChoice}(5);
AgentPlacement=LandSetupChoices{LandChoice}(6);%2:3;%2;%
wholesaveToggle=0;LandSetupChoices{LandChoice}(7);
InsideOrderCounter=InsideOrderCounterSet{LandChoice};
testToggle=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

runType="Homogeneous Spread";
resultsTableLocString='SimResults\CollectedResults.csv';
structureString='SimResults\ResultsStructure.mat';
%Names for different pieces
LandTypeNames={'Coweeta','IdealizedStructures'};
CoweetaSubTypes={'Whole','West','South','NEast'};
IdealNames={'Wedge','Trough','Tilted_Trough'};
OrderedStreamNames={'FirstOrder','SecondOrder','Third Order','Complete'};
BranchChoicesNames={'Single','All'};
AgentPlacementNames={'Homo','Head','Mouth','Mid','UpperFourth','LowerFourth','Staggered'};
%Directory for where things are stored
dataFolder='DataStructures\';
% landData='CoweetaLandscapeNumericMatrices.mat';
landscapeName='CoweetaLandscapeWithRiver';
% ShapefileHolyCowLarge='FebruaryCoweeta\coweeta_streams.shp';shapeFile=ShapefileHolyCowLarge;
% tifFileNameCowLarge='FebruaryCoweeta\Coweeta_One_Ninth_Arc.tif';tifFileName=tifFileNameCowLarge;
shapeFile='Coweeta\coweetaProject.shp';
tifFileName='Coweeta\coweeta1.tif';

singleX=392;
singleY=405;
sourceRadius=5;
innerCatchRadius=240;
outerCatchRadius=260;
% runType="SinglePlacement";
% singleGraphFilename="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\InfoHolderForImagingTests\HomoSpreadSource\";
% singleOFATFilename="SimResults\CoweetaCollection\InfoHolderForImagingTests\HomoSpreadSource\E1e5R1e5Pd1e-5";
% singlePBFilename="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\InfoHolderForImagingTests\HomoSpreadSource\E1e5R1e5Pd1e-5\ProbBirth_0.01";
% ofatParamString="E1e5R1e5Pd1e-5\";
% imageStorLoc='Images\FebruaryRunProcessingImages\';

resultsStructure=retrieveCoweetaDataStructure(structureString);
resultsCount=size(resultsStructure(:),1)+1;
nMoves=1;
%     maxTimeHolder=log(0.05)\log(1-pdHolder);
%     maxTimeSteps=roundn(maxTimeHolder,numel(num2str(fix(abs(maxTimeHolder))))-1);


% plotType=1;

%% Look here to change outermost storage folder %%
if testToggle==0
    resultsFolderName='SimResults\';
elseif testToggle==1
    resultsFolderName='SimResults\MarchRuns\';
end


%Whole,Westerns,Southern,NorthEastern,WesternInner
FirstOrder={[6 8 10 12:14 16 17],[6 12:14],[6 14 16 17],[8 10],[6 13]};
SecondOrder={[5 11 15],[5 11],[5 15],15,[5 11]};
ThirdOrder={[1:4],4,[3 4],[1:4],4};
TotalStructure={[1:17],[4:6 11:14],[3:6 14:17],[1:4 7:10 15],[4:6 11 13]};
OrderedStreams={FirstOrder,SecondOrder,ThirdOrder,TotalStructure};

for deathCount=1:size(pdHolder,2)
    for birthCount=1:size(pbHolder,2)
        for TLCount=1:size(TLandFull,2)
            for TRCount=1:size(TRiverFull,2)
                % Update Param Values for Run
                TLand=TLandFull(TLCount);TRiver=TRiverFull(TRCount);
                pd=pdHolder(deathCount);pb=pbHolder(birthCount);parameterValues=[TLand TRiver pd pb];
                for AgentSubTypeChoice=AgentSubTypeChoiceSet
                    SubType=SubTypeChoice;
                    for AgentPlacementChoice=AgentPlacement
                        for OrderedStreamsCounter=OrderedStreamsCounterSet
                            if BranchChoice==1
                                if LandChoice==2
                                    %%	Coweeta Structures %%
                                    [runType,Runname,CoweetaFolder,normedVecNameFolder,AgentCoordsNameFolder,DataStructureRunFolder,RunSaveFolder] ...
                                        = CreateDirectories(resultsFolderName,dataFolder,LandTypeNames{LandType},CoweetaSubTypes{SubType},...
                                        OrderedStreamNames{OrderedStreamsCounter},BranchChoicesNames{BranchChoice},...
                                        InsideOrderCounter,num2str(OrderedStreams{OrderedStreamsCounter}{AgentSubTypeChoice}(InsideOrderCounter)),...
                                        AgentPlacementNames{AgentPlacementChoice},width,TLand,TRiver,pd,pb);

                                    [PhysicalDataFileName,NormedName,coordsFileName] ...
                                        = CreateNames(DataStructureRunFolder,CoweetaFolder,normedVecNameFolder,AgentCoordsNameFolder,pd,pb);

                                    [agCoords]=isingModelIdealLandscapeProcessing(TRiver,TLand,width,LandType,SubType,AgentPlacementChoice,CoweetaFolder,shapeFile,tifFileName,...
                                        runType,PhysicalDataFileName,coordsFileName,OrderedStreams,OrderedStreamsCounter,InsideOrderCounter,...
                                        BranchChoice,AgentSubTypeChoice)
                                elseif LandChoice==3
                                    %%	Coweeta Structures %%
                                    [runType,Runname,CoweetaFolder,normedVecNameFolder,AgentCoordsNameFolder,DataStructureRunFolder,RunSaveFolder] ...
                                        = CreateDirectories(resultsFolderName,dataFolder,LandTypeNames{LandType},CoweetaSubTypes{SubType},...
                                        OrderedStreamNames{OrderedStreamsCounter},BranchChoicesNames{BranchChoice},...
                                        InsideOrderCounter,num2str(OrderedStreams{OrderedStreamsCounter}{AgentSubTypeChoice}(InsideOrderCounter)),...
                                        AgentPlacementNames{AgentPlacementChoice},width,TLand,TRiver,pd,pb);

                                    [PhysicalDataFileName,NormedName,coordsFileName] ...
                                        = CreateNames(DataStructureRunFolder,CoweetaFolder,normedVecNameFolder,AgentCoordsNameFolder,pd,pb);

                                    [agCoords]=isingModelIdealLandscapeProcessing(TRiver,TLand,width,LandType,SubType,AgentPlacementChoice,CoweetaFolder,shapeFile,tifFileName,...
                                        runType,PhysicalDataFileName,coordsFileName,OrderedStreams,OrderedStreamsCounter,InsideOrderCounter,...
                                        BranchChoice,AgentSubTypeChoice)
                                    %                                     isingModelIdealLandscapeProcessingAll(TRiver,TLand,width,LandType,SubType,AgentPlacementChoice,CoweetaFolder,...
                                    %                                         runType,PhysicalDataFileName,coordsFileName,OrderedStreams,OrderedStreamsCounter,BranchChoice,AgentSubTypeChoice,InsideOrderCounter)

                                end

                            elseif BranchChoice==2
                                %%	Coweeta Structures %%
                                [runType,Runname,CoweetaFolder,normedVecNameFolder,AgentCoordsNameFolder,DataStructureRunFolder,RunSaveFolder] ...
                                    = CreateDirectories(resultsFolderName,dataFolder,LandTypeNames{LandType},CoweetaSubTypes{SubType},...
                                    OrderedStreamNames{OrderedStreamsCounter},BranchChoicesNames{BranchChoice},...
                                    InsideOrderCounter,num2str(InsideOrderCounter),...
                                    AgentPlacementNames{AgentPlacementChoice},width,TLand,TRiver,pd,pb);


                                [PhysicalDataFileName,NormedName,coordsFileName] ...
                                    = CreateNames(DataStructureRunFolder,CoweetaFolder,normedVecNameFolder,AgentCoordsNameFolder,pd,pb);


                                isingModelIdealLandscapeProcessing(TRiver,TLand,width,LandType,SubType,AgentPlacementChoice,CoweetaFolder,shapeFile,tifFileName,...
                                    runType,PhysicalDataFileName,coordsFileName,OrderedStreams,OrderedStreamsCounter,InsideOrderCounter,...
                                    BranchChoice,AgentSubTypeChoice)
                                %                                     isingModelIdealLandscapeProcessingAll(TRiver,TLand,width,LandType,SubType,AgentPlacementChoice,CoweetaFolder,...
                                %                                         runType,PhysicalDataFileName,coordsFileName,OrderedStreams,OrderedStreamsCounter,BranchChoice,AgentSubTypeChoice,InsideOrderCounter)
                            end

                        end
                    end
                end

                for run=1:maxRuns
                    rng 'shuffle'
                    s=rng;
                    vec = datevec( now );
                    timeStamp=datestr( vec, 'yyyy_mm_dd_HH_MM_SS' );

                    if maxRuns>1
                        totalFilename=strcat(RunSaveFolder,'PD_',num2str(pd),'PB_',num2str(pb),'_Run_',num2str(run),'Time_',timeStamp,'.mat');
                    else
                        totalFilename=strcat(RunSaveFolder,'PD_',num2str(pd),'PB_',num2str(pb),'_Run_',num2str(run),'Time_',timeStamp,'.mat');
                    end

                    runname=strcat('W_',num2str(width),'_ET_',num2str(TLand),'_RT_',num2str(TRiver),'ProbDeath_',...
                        num2str(pd),'ProbBirth_',num2str(pb),'Timestamp_',timeStamp,'.mat');
                    %                         if ~isfolder (strcat('W_',num2str(width),'_ET_',num2str(TLand),'_RT_',num2str(TRiver),'ProbDeath_',...
                    %                             num2str(pd),'ProbBirth_',num2str(pb),'\'))
                    %                             mkdir(['W_',num2str(width),'_ET_',num2str(TLand),'_RT_',num2str(TRiver),'ProbDeath_',...
                    %                             num2str(pd),'ProbBirth_',num2str(pb),'\']);
                    %                         end
                    %
                    CSVsavename=strcat('W_',num2str(width),'_ET_',num2str(TLand),'_RT_',num2str(TRiver),'ProbDeath_',...
                        num2str(pd),'ProbBirth_',num2str(pb),'\Timestamp_',timeStamp,'.csv');
                    %
                    ImageLocation=strcat('W_',num2str(width),'_ET_',num2str(TLand),'_RT_',num2str(TRiver),'ProbDeath_',...
                        num2str(pd),'ProbBirth_',num2str(pb),'\Timestamp_',timeStamp,'.csv');


                    if ~exist([RunSaveFolder 'Images\'],'dir')
                        mkdir([RunSaveFolder 'Images\'])
                    end

                    imageStorLoc=strcat(RunSaveFolder,'Images\');

                    if ~exist([RunSaveFolder 'Video\'],'dir')
                        mkdir([RunSaveFolder 'Video\'])
                    end

                    if coordsFlip==0
                        videoStorLoc=strcat(RunSaveFolder,'Video\SingleGeneration\');

                    elseif coordsFlip==1
                        videoStorLoc=strcat(RunSaveFolder,'Video\MultiGenerational\');
                    end

                    if ~exist(videoStorLoc,'dir')
                        mkdir(videoStorLoc)
                    end

                    heatmapStorLoc=strcat(RunSaveFolder,'Heatmap\');

                    reportStorLoc=strcat(RunSaveFolder,'Report_');

                    if ~exist([RunSaveFolder 'Images\'],'dir')
                        mkdir([RunSaveFolder 'Images\'])
                    end

                    %%  Generate Ideal Sim runs %%

                    if coordsFlip==0
                        GenerationNumber=1;
                        resultsStructure(resultsCount).GenerationNumber=GenerationNumber;
                        resultsStructure(resultsCount).PopulationSize=iniPopSize;
                        resultsStructure(resultsCount).SimulationTimestamp=timeStamp;
                        if ~isfile([resultsFolderName,runType,runname])

                            tic

                            [~,filename,River,Elevation,maxPositions]= ...
                                PreCoweetaMainScript(pb,pd,nMoves,1,8,1,1,0,totalFilename,resultsFolderName,...
                                PhysicalDataFileName,coordsFileName,coordsFlip,coordsInput,runname,runType,maxTimeSteps,iniPopSize,...
                                NormedName,wholesaveToggle);
                            
                            toc

                            [AllCollectedInformation]=convertMaxToTable(maxPositions);

                            AllCollectedInformation=addElevations(AllCollectedInformation,Elevation);

                            resultsStructure=MovieSlides(AllCollectedInformation,parameterValues,videoStorLoc,landscapeName,timeStamp,GenerationNumber,Elevation,River,resultsStructure,resultsCount);


                            %                             [~,filename,River,Elevation,maxPositions]= ...
                            %                                 PreCoweetaMainScript(pb,pd,nMoves,1,8,1,1,0,totalFilename,resultsFolderName,...
                            %                                 PhysicalDataFileName,coordsFileName,coordsFlip,coordsInput,runname,runType,maxTimeSteps,iniPopSize,...
                            %                                 NormedName,wholesaveToggle);

                            %                             create1d2dSheetReport(AllCollectedInformation,parameterValues,imageStorLoc,landscapeName,timeStamp)
                            %
                            %                             Daniel2DImaging(AllCollectedInformation,Elevation,River)

                            %                             singleLocationAnalysisFromPipeline(landscapeName,imageStorLoc,AllCollectedInformation,plotType,singleX,singleY,sourceRadius,innerCatchRadius,outerCatchRadius,parameterValues)

                            resultsStructure(resultsCount).ResultsTableLocation=[RunSaveFolder 'AllCollectedInformation_' timeStamp '.csv'];
                            resultsStructure(resultsCount).SimulationName=filename;
                            resultsStructure(resultsCount).SimulationName=runname;
                            resultsStructure(resultsCount).ImageLocation=imageStorLoc;
                            resultsStructure(resultsCount).VideoLocation=videoStorLoc;
                            resultsStructure(resultsCount).SourceRadius=sourceRadius;
                            resultsStructure(resultsCount).InnerCatchRadius=innerCatchRadius;
                            resultsStructure(resultsCount).OuterCatchRadius=outerCatchRadius;
                            resultsStructure(resultsCount).LandscapeFilename=PhysicalDataFileName;
                            resultsStructure(resultsCount).CoordinateLocationName=coordsFileName;
                            resultsStructure(resultsCount).ParameterValueArray=[TLand TRiver pd pb];
                            resultsStructure(resultsCount).Seed=s;
                            writetable(AllCollectedInformation,[RunSaveFolder 'AllCollectedInformation_' timeStamp '.csv'])
                            save([RunSaveFolder 'Seed_' runname],'s','-v7.3');%
                            resultsCount=resultsCount+1;


                        else
                            %         load(name)
                        end
                    elseif coordsFlip==1
                        GenerationNumber=1;

                        if ~isfile([resultsFolderName,runType,runname])
                            resultsStructure(resultsCount).GenerationNumber=GenerationNumber;
                            resultsStructure(resultsCount).PopulationSize=iniPopSize;
                            resultsStructure(resultsCount).SimulationTimestamp=timeStamp;

                            %                             while reproSwitch

                            %                                 videoStorLoc=strcat(videoStorLoc,'Gen_',num2str(GenerationNumber));
                            tic

                            [~,filename,River,Elevation,maxPositions]= ...
                                PreCoweetaMainScript(pb,pd,nMoves,1,8,1,1,0,totalFilename,resultsFolderName,...
                                PhysicalDataFileName,coordsFileName,coordsFlip,coordsInput,runname,runType,maxTimeSteps,iniPopSize,...
                                NormedName,wholesaveToggle);

                            toc
                            [AllCollectedInformation]=convertMaxToTable(maxPositions);

                            AllCollectedInformation=addElevations(AllCollectedInformation,Elevation);

                            resultsStructure=MovieSlides(AllCollectedInformation,parameterValues,videoStorLoc,landscapeName,timeStamp,GenerationNumber,Elevation,River,resultsStructure,resultsCount);

                            %                                 Daniel2DImaging(AllCollectedInformation,Elevation,River,videoStorLoc)
                            resultsStructure(resultsCount).ResultsTableLocation=[RunSaveFolder 'AllCollectedInformation_' timeStamp '.csv'];
                            resultsStructure(resultsCount).SimulationName=filename;
                            resultsStructure(resultsCount).SimulationName=runname;
                            resultsStructure(resultsCount).ImageLocation=imageStorLoc;
                            resultsStructure(resultsCount).VideoLocation=videoStorLoc;
                            resultsStructure(resultsCount).SourceRadius=sourceRadius;
                            resultsStructure(resultsCount).InnerCatchRadius=innerCatchRadius;
                            resultsStructure(resultsCount).OuterCatchRadius=outerCatchRadius;
                            resultsStructure(resultsCount).LandscapeFilename=PhysicalDataFileName;
                            resultsStructure(resultsCount).CoordinateLocationName=coordsFileName;
                            resultsStructure(resultsCount).ParameterValueArray=[TLand TRiver pd pb];
                            resultsStructure(resultsCount).Seed=s;

                            %                                 if isempty(AllCollectedInformation{AllCollectedInformation.DeathType=='Reproducing Agent','ReproCounter'})
                            %                                     reproSwitch=0;
                            writetable(AllCollectedInformation,[RunSaveFolder 'AllCollectedInformation_' timeStamp '.csv']);
                            save([RunSaveFolder 'Seed_' timeStamp],'s','-v7.3');
                            save(structureString, 'resultsStructure','-v7.3');
                            %                                 else
                            %                                     coordsInput=unique(AllCollectedInformation{AllCollectedInformation.DeathType=='Reproducing Agent',{'DeathCoords_1' 'DeathCoords_2'}},"rows");
                            %                                 end

                            %                                 GenerationNumber=GenerationNumber+1;
                            resultsCount=resultsCount+1;
                            %                             end
                        end
                    end
                end
            end
        end
        %         a=([1:2,6:7]);
        %                             FrancescoCoweetaGifGenerator(name,TRiver,TLand)
        %         scatPlotComp(simdata,a,landGrid);
        %         FrancescoIdealGifGenerator(River,Elevation,name);
    end
end
save(structureString, 'resultsStructure','-v7.3');
end