function IsingCRC_Cow6_14_5Sing_PdHighPbHigh_TElHighTRivLow(numID)
    numMachines=20;
    %%  Choose your landscape and initial settings with LandType    %%
    % LandType=1:= Coweeta, LandType=2:=Ideal
    %%  Choose the subtype of landscape with %%
    %%              SubTypeChoice %%
    %% (This includes all branches within that region for both Elevation and River    %%
    %     SubTypeChoice=1=Whole Coweeta Landscape/Wedge [1:17]
    %     SubTypeChoice=2=Western Neighborhood/Trough   [4:6 11:14]
    %     SubTypeChoice=3=Southern Neighborhood/Tilted  [3:6 14:17]
    %     SubTypeChoice=4=NorthEastern Neighborhood     [1:4 7:10 15]
    %     SubTypeChoice=5=InnerWestern Neighborhood     [4:6 11 13]
    %%  Choose the subtype of landscape with %%
    %%              AgentSubTypeChoice %%
    %% (This includes all branches within that region for both Elevation and River    %%
    %     AgentSubTypeChoice=1=Whole Coweeta Landscape/Wedge [1:17]
    %     AgentSubTypeChoice=2=Western Neighborhood/Trough   [4:6 11:14]
    %     AgentSubTypeChoice=3=Southern Neighborhood/Tilted  [3:6 14:17]
    %     AgentSubTypeChoice=4=NorthEastern Neighborhood     [1:4 7:10 15]
    %     AgentSubTypeChoice=5=InnerWestern Neighborhood     [4:6 11 13]
    %%  Choose the Order of landscape to consider for the agents with %%
    %%              OrderedStreamsCounter %%
    %     OrderedStreamsCounter=1 :=First Order (Feeder streams.  Usually smallest and on periphery)
    %           Whole=[6 8 10 12:14 16 17], West=[6 12:14], South=[6 14 16 17], NE=[8 10], WIn=[4:6 11 13], WIn=[6 13]
    %     OrderedStreamsCounter=2 :=Second Order (1+1=2, 2+1=2, 1+2=2)
    %           Whole=[5 11 15], West=[5 11], South=[5 15], NE=15, WIn=[5 11]
    %     OrderedStreamsCounter=3 :=Third Order (x+3=3 for x<3, 3+3=4)
    %           Whole=[1:4], West=4, South=[3 4], NE=[1:4], WIn=4
    %     OrderedStreamsCounter=4 :=Whole Neighborhood
    %           Whole=[1:17], West=[4:6 11:14], South=[3:6 14:17], NE=[1:4 7:10 15], WIn=[4:6 11 13]
    %%  Choose the Branches within region to consider for the agents with %%
    %%          `   BranchChoices     %%
    %     BranchChoices=1 :=Single
    %     BranchChoices=2 :=All
    %%  Choose the Placement of the agents on the Branch with %%
    %%              AgentPlacement  %%
    %     AgentPlacement=1 := Homogeneous (All choices from Branches are
    %     covered homogeneously with agents
    %     AgentPlacement=2 := SPtHead
    %     AgentPlacement=3 :=SPtMouth
    %     AgentPlacement=4 :=SPtMiddle
    %%  Toggle Whole Run Save  with %%
    %%              wholesaveToggle %%
    %     wholesaveToggle=0 Only saveMaxpositions
    %     wholesaveToggle=1 saveEVERYTHING!!!
    LandType=1;
    SubTypeChoice=1;%1:4
    AgentSubTypeChoiceSet=2;%[2 5];
    OrderedStreamsCounterSet=1;%[1 4];
    BranchChoice=1;
    AgentPlacement=3;%2:3;%2;%
    wholesaveToggle=0;
    
    %how many runs per? %
    maxRuns=numMachines*50;
    
    
    %% Physical Data Settings %%
    width=0;
    TLand=1E5;%0.001;
    TRiver=1E-3;
    %%  Biology of the agents   %%
    pb=0.1;pd=0.1;
    nMoves=1;
    maxTimeSteps=200000;
    iniPopSize=5000;
    
    %Names for different pieces
    LandTypeNames={'Coweeta','IdealizedStructures'};
    CoweetaSubTypes={'Whole','West','South','NEast'};
    IdealNames={'Wedge','Trough','Tilted_Trough'};
    OrderedStreamNames={'FirstOrder','SecondOrder','Third Order','Complete'};
    BranchChoicesNames={'Single','All'};
    AgentPlacementNames={'Homo','Head','Mouth','Mid'};
    
    %Directory for where things are stored
    dataFolder='DataStructures/';
    resultsFolderName='SimResults/';
    
    %Whole,Westerns,Southern,NorthEastern,WesternInner
    FirstOrder={[6 8 10 12:14 16 17],[6 12:14],[6 14 16 17],[8 10],[6 13]};
    SecondOrder={[5 11 15],[5 11],[5 15],15,[5 11]};
    ThirdOrder={[1:4],4,[3 4],[1:4],4};
    TotalStructure={[1:17],[4:6 11:14],[3:6 14:17],[1:4 7:10 15],[4:6 11 13]};
    OrderedStreams={FirstOrder,SecondOrder,ThirdOrder,TotalStructure};
    
    if LandType==1
        for AgentSubTypeChoice=AgentSubTypeChoiceSet
            SubType=SubTypeChoice;
            for AgentPlacementChoice=AgentPlacement
                for OrderedStreamsCounter=OrderedStreamsCounterSet
                    if BranchChoice==1
                        for InsideOrderCounter=1%1:size(OrderedStreams{OrderedStreamsCounter}{SubType},2)
                            
                            %       for AgentPlacementChoice=2:4
                            %           for InsideOrderCounter=1:size(OrderedStreams{OrderedStreamsCounter}{SubType},2)
                            
                            %%	Coweeta Structures %%
                            %FileHolderForAllSettings
                            [runType,Runname,CoweetaFolder,normedVecNameFolder,AgentCoordsNameFolder,DataStructureRunFolder,RunSaveFolder] ...
                                = CreateDirectories(resultsFolderName,dataFolder,LandTypeNames{LandType},CoweetaSubTypes{SubType},...
                                    OrderedStreamNames{OrderedStreamsCounter},BranchChoicesNames{BranchChoice},...
                                    InsideOrderCounter,num2str(OrderedStreams{OrderedStreamsCounter}{SubType}(InsideOrderCounter)),...
                                    AgentPlacementNames{AgentPlacementChoice},width,TLand,TRiver);
                            
                            [PhysicalDataFileName,NormedName,coordsFileName] ...
                                = CreateNames(DataStructureRunFolder,CoweetaFolder,normedVecNameFolder,AgentCoordsNameFolder,pd,pb);
                            
                            isingModelIdealLandscapeProcessing(TRiver,TLand,width,LandType,SubType,AgentPlacementChoice,CoweetaFolder,...
                                runType,PhysicalDataFileName,coordsFileName,OrderedStreams,OrderedStreamsCounter,InsideOrderCounter,...
                                BranchChoice,AgentSubTypeChoice)
                            
                        end
                    elseif BranchChoice==2
                        InsideOrderCounter=100;
                        %%	Coweeta Structures %%
                        [runType,Runname,CoweetaFolder,normedVecNameFolder,AgentCoordsNameFolder,DataStructureRunFolder,RunSaveFolder] ...
                            = CreateDirectories(resultsFolderName,dataFolder,LandTypeNames{LandType},CoweetaSubTypes{SubType},...
                                OrderedStreamNames{OrderedStreamsCounter},BranchChoicesNames{BranchChoice},...
                                InsideOrderCounter,num2str(InsideOrderCounter),...
                                AgentPlacementNames{AgentPlacementChoice},width,TLand,TRiver);
                        
                        [PhysicalDataFileName,NormedName,coordsFileName] ...
                        = CreateNames(DataStructureRunFolder,CoweetaFolder,normedVecNameFolder,AgentCoordsNameFolder,pd,pb);
                        
                        isingModelIdealLandscapeProcessingAll(TRiver,TLand,width,LandType,SubType,AgentPlacementChoice,CoweetaFolder,...
                            runType,PhysicalDataFileName,coordsFileName,OrderedStreams,OrderedStreamsCounter,BranchChoice,AgentSubTypeChoice,InsideOrderCounter)
                    
                    end
                    
                end
            end
        end
        
        for run=1:(maxRuns/numMachines)
            rng 'shuffle'
            s=rng;
            vec = datevec( now );
            timeStamp=datestr( vec, 'yyyy_mm_dd_HH_MM_SS' );
            
            if maxRuns>1
                totalFilename=strcat(RunSaveFolder,'PD_',num2str(pd),'PB_',num2str(pb),'_Run_',num2str(numMachines*(run-1)+numID),'_NumID_',num2str(numID),'Time_',timeStamp,'.mat');
            else
                totalFilename=strcat(RunSaveFolder,'PD_',num2str(pd),'PB_',num2str(pb),'_Run_',num2str(numMachines*(run-1)+numID),'_NumID_',num2str(numID),'Time_',timeStamp,'.mat');
            end
            
            runname=strcat('W_',num2str(width),'_ET_',num2str(TLand),'_RT_',num2str(TRiver),'ProbDeath_',...
                num2str(pd),'ProbBirth_',num2str(pb),'_Run_',num2str(numMachines*(run-1)+numID),'_NumID_',num2str(numID),'Timestamp_',timeStamp,'.mat');
            
            %%  Generate Ideal Sim runs %%
            if ~isfile(['SimResults/',runType,runname])
                [~,~,River,Elevation,maxPositions]= ...
                    PreCoweetaMainScript(pb,pd,nMoves,1,8,1,1,0,totalFilename,resultsFolderName,...
                    PhysicalDataFileName,coordsFileName,runname,runType,maxTimeSteps,iniPopSize,...
                    NormedName,wholesaveToggle);
                %         Positions{1,1}=maxPositions;
                %         PositionsFilenames{1,1}=filename;
                %         name='SimResults/WesternCoweeta_Width0EleT=1RivT=100ProbDeath=0ProbBirth=0.001.mat';
                save(['SimResults/',runType,runname],'River','Elevation','maxPositions','s');%
            else
                %         load(name)
            end
            %         a=([1:2,6:7]);
            %                             FrancescoCoweetaGifGenerator(name,TRiver,TLand)
            %         scatPlotComp(simdata,a,landGrid);
            %         FrancescoIdealGifGenerator(River,Elevation,name);
        end
        %%%%%%%%%%%%%Idealized landscapes%%%%%%%%%%%%%
    elseif LandType==2
        %river vals%
        Rb=[-10,-2,-0.1,0.1,2,10];
        %ele vals%
        Eb=[1,3.98,10];%[3.98];
        lattitude=1001;
        longitude=1001;
        count=1;
        width=0;
        angleIncrement=pi/12;
        for SubType=1%1:3
            for EbCount=1:size(Eb,2)
                for RbCount=1:size(Rb,2)%1%
                    omegaCount=1;
                    for parallelTiltAngle=3%1:2:5%0:10:50
                        omega=angleIncrement*parallelTiltAngle;
                        alphaCount=1;
                        for orthogTiltAngle=3%1:2:5%3%
                            alpha=angleIncrement*orthogTiltAngle;
                            idealLandGridName=strcat(IdealNames{SubType}, '_size_', num2str(lattitude), 'x', num2str(longitude), '_width_', num2str(width),  '_buffer_', num2str(50),'_omega_',num2str(parallelTiltAngle*15),'_alpha_',num2str(orthogTiltAngle*15));
                            Idealized_Geometry_Generator(lattitude,longitude,width,SubType,idealLandGridName,omega,alpha)
                            names{EbCount,RbCount,omegaCount,alphaCount}=idealLandGridName;
                            for i=2%1:6
                                for j=1%:2
                                    totalFilename=strcat(IdealNames{SubType},'_Width_',num2str(width),'_omega_',num2str(parallelTiltAngle*15),'_alpha_',num2str(orthogTiltAngle*15),'_Pb_',num2str(pb),',Pd_',num2str(pd),',Ele_',num2str(Eb(EbCount)),',Riv_',num2str(Rb(RbCount)),'.mat');
                                    [filenameholder,totalFilename,River,Elevation,maxPositions]=PreIdealTiltedMainScript(pb,pd,1,1,2,Rb(RbCount),1,Eb(EbCount),totalFilename,fileHolder,width,gridTypeNames{SubType},idealLandGridName);
                                    Positions{EbCount,RbCount}=maxPositions;
                                    PositionsFilenames{EbCount,RbCount}=totalFilename;
                                    % load('IdealRunsTest2/Wedge_Width_0_Angle_30_Pb_0.09,Pd_0.004,Ele_3.98,Riv_-5DeltaGrid.mat');
                                    % landscapename=strcat('IdealizedGeometries/',idealLandGridName);
                                    % load(landscapename);
                                    % filenameholder=strcat(fileHolder,filename);
                                    % %         fileName=strcat('West_SouthWest_Connections_size_1x250_width_1_buffer_0_Riv_', num2str(a(i)), '_Ele_', num2str(b(j)), '.mat');
                                    %         fileName=strcat('West_SouthWest_Connections_size_1x250_width_1_buffer_0_Riv_', num2str(riv), '_Ele_', num2str(ele),',Run_',num2str(run), '.mat');
                                    % %         IdealizedMainScript(River,Elevation,pb,pd,1,1,2,a(i),1,b(j),Coordinates,fileName,fileHolder)
                                    %         IdealizedMainScript(River,Elevation,pb,pd,1,1,2,riv,1,ele,Coordinates,fileName,fileHolder,time,popSize)
                                    %
                                    %         % %%%%% Code to load instead of generating new run
                                    %         % simulationFileName='IdealizedGeometries/East_SouthEast_Connections_size_1x250_width_1_buffer_0_upcoeff_-100000_bias_-100000.mat';
                                    %         load([fileHolder filename])
                                    %
                                    % %         fileHolder='IdealizedGeometries/West_SouthWest_Connections/';
                                    %         landname='West_SouthWest_Connections_size_1x250_width_1_buffer_0';
                                    %         % %%%%%Use to generate a gif
                                    % %         fileList = dir([fileHolder landname '_upcoeff*100_bias*.mat']);
                                    % %         numfile=length(fileList);
                                    % %         for file=1:numfile
                                    % %             filename=fileList(file).name(1:end-4);
                                    % %             filename2=strcat(fileHolder, filename); load([filename2 '.mat']);
                                    % load([fileHolder landname '.mat'],'River','Elevation','Coordinates');
                                    % %             surf(Elevation)
                                    %         name2=strcat(fileHolder,fileName);
                                    % load('IdealRunsTest2/Wedge_Width_0_Wedge_Width_0_Angle_30ALLINFOFORVIDEOTESTING.mat')
                                    % [images] = FrancescoIdealGifGenerator(River,Elevation,filenameholder);
                                    %           save([fileHolder '/Images/' filename],'images','-v7.3');
                                    %           name=strcat(fileHolder, 'Images/', filename);
                                    %           VideoMakerTest(images,name)
                                    %         end
                                    
                                    % %%%%Use to Compute and display Gaussian
                                    %         gausspopdensIdeal(1,1,simulationFileName,filenameholder)
                                    
                                    %%%%%Compute the L2 norms
                                    %[MEDIANDeath,MEANIEDeath,STANDIVDeath,MEDIAN,MEANIE,STANDIV]=dispKcalclallIndividual(filename,fileHolder);
                                    %         [riverMedian,riverMean,riverSD]=riverdistanceallIndividual(fileHolder,filename,1,'Coweeta/coweetaProject.shp','Coweeta/coweeta1.tif',1);
                                    %TAll{1,count}(1:6)=[MEDIANDeath,MEANIEDeath,STANDIVDeath,MEDIAN,MEANIE,STANDIV];
                                    %count=count+1;
                                end
                            end
                            save('IdealRunsTest2021HolderFile/MaximumValues.mat','names','Positions','PositionsFilenames');
                            alphaCount=alphaCount+1;
                            
                            %save([fileHolder gridTypeNames{gridTypeStyle} '_Width_' num2str(width) '_omega_' num2str(angle1*15) '_alpha_' num2str(angle2*15) '_IdealLandscapesTAll.mat'],'TAll','-v7.3')
                        end
                        omegaCount=omegaCount+1;
                    end
                end
            end
        end
        %Placeholder for future maps%
        %                     else
        
    end
end