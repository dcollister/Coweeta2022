 function [PreResultsStructure]=creatingTablesFromUnprocessedDataSingleFile(NamesandParamsTable,singleFilename)
    singleFilename;
    %% Create Structure
    % ResultsStructure.AgentPlacement=strcat(Folders2Consider)
    %                 for
    % Folders2Consider1 = Folders2Consider(33:494,4:7);
    % Folders2Consider1.Properties.RowNames=Folders2Consider(33:494,:).ParamName
    %             TableStruct(tableCount).AgentPlacement=strcat(CoweetaCollectedNeedProcessing{ia(tableCount),1},CoweetaCollectedNeedProcessing{ia(tableCount),2});
    %                     TableStruct(tableCount).filename=UAFileNames;
    %     LandFilesArray = table2cell(NamesandParamsTable(:,2));
    %     ParamNamesArray = table2cell(NamesandParamsTable(:,3));
    %     UnCollectionArray=repmat({'Combined'},height(PreUniqueOFATTable1),1);
    %                 end
    AllPBNamesArray=NamesandParamsTable.PBName;
    UnCollectionArray=repmat({'Combined'},height(NamesandParamsTable),1);
    OFATNamesProcessedIndices = ~cellfun(@contains,AllPBNamesArray,UnCollectionArray);
    ProcessedNamesAndParamTable=NamesandParamsTable(OFATNamesProcessedIndices,:);

    OFATNamesUnprocessedIndices = ~cellfun(@contains,AllPBNamesArray,UnCollectionArray);
    UnprocessedNamesAndParamTable=NamesandParamsTable(OFATNamesUnprocessedIndices,:);
    [holderFile,holderIa,holderIc] = unique(UnprocessedNamesAndParamTable.FileHolder);
    [LandFile,LandFileIa,LandFileIc] = unique(UnprocessedNamesAndParamTable.LandFiles);
    HolderArray=repmat(strcat(holderFile,'\'),height(LandFile),1);
    AgentPlacementArray=strcat(HolderArray,LandFile);
    resultsRowCount=1;

%     for placementCount=1:height(LandFile)
%         TempPlacementTable=UnprocessedNamesAndParamTable(LandFileIc==placementCount,:);
%         [OFATNames,OFATia,OFATic] = unique(TempPlacementTable.OFATName);
%         for OFATcount=1:height(OFATNames)
%             PreResultsStructure(resultsRowCount).AgentPlacement=AgentPlacementArray{placementCount};
%             PreResultsStructure(resultsRowCount).OFATNames=OFATNames{OFATcount};
%             OFATindex=(OFATic==OFATcount);
%             PreResultsStructure(resultsRowCount).PBNameArray = table2array(TempPlacementTable(OFATindex,5));
%             TempOFATtable=TempPlacementTable(OFATindex,6:9);
%             PBValArray=table2array(TempPlacementTable(OFATindex,9));
%             PreResultsStructure(resultsRowCount).ET = TempPlacementTable.ET(OFATia(OFATcount));
%             PreResultsStructure(resultsRowCount).RT = TempPlacementTable.RT(OFATia(OFATcount));
%             PreResultsStructure(resultsRowCount).ProbDeath = TempPlacementTable.ProbDeath(OFATia(OFATcount));
%             PreResultsStructure(resultsRowCount).PBValArray = PBValArray;
% 
%             TempOFATtable.Properties.RowNames=TempPlacementTable{OFATindex,5};
%             PreResultsStructure(resultsRowCount).OFATTable=TempOFATtable;
%             resultsRowCount=resultsRowCount+1;
%         end
%     end


    ProcessedArray = table2array(NamesandParamsTable(:,10));
    processedIndex1  =  cellfun(@isempty,ProcessedArray);
    Folders2Consider=NamesandParamsTable(processedIndex1,:);

    [C,ia,ic] = unique(Folders2Consider.PBName);

    fileShell='SimResults\CoweetaCollection\';
    landType=C;
    TableTypeNames={'Single','Combined'};
    UAVarNames={'Filename','AllAgents','ReproAgents','BoundAgents','NonRNonBAgents'};
    UAVarTypes={'string','table','table','table','table'};
    AgentNames={'AllAgents','ReproAgents','BoundAgents','NonRNonBAgents'};
    EventNames={'Birth','Max','Death'};
    MeasurementNames={'Values','Locations','Times'};
    ParamNames={'Width','T_Elevation','T_River','Pd','Pb'};
    variableNames={'XminCoords','XMaxCoords','YMinCoords','YMaxCoords','RadialMaxCoords','RMaxCoords',...
        'BirthCoords','DeathCoords','ReproCounter','AgentID','BeginningBranch','Gender','GenePool',...
        'XminTime','XMaxTime','YMinTime','YMaxTime','RadialMaxTime','DeathTime','BoundaryDeathTime','ReproDeathTime'};
    variableIndicies={[1:2],[3:4],[5:6],[7:8],9,[10:11],[12:13],[14:15],16,17,18,19,20,21,22,23,24,25,26,27,28};
    AgentVarIndices={12:13 9 10:11 25 14:15 26};

    SingleRunVariableNames=cell(1,1);CombinedRunVariableNames=cell(1,1);
    %% Make Var Names for all agent subgroups
    for namesCount2=1:size(AgentNames,2)
        k=1;
        for namesCount3=1:size(EventNames,2)
            if namesCount3==1
                for namesCount4=2
                    SingleRunVariableNames{namesCount2,k}=strcat(AgentNames{namesCount2},EventNames{namesCount3},MeasurementNames{namesCount4});
                    CombinedRunVariableNames{namesCount2,k}=strcat('Combined',AgentNames{namesCount2},EventNames{namesCount3},MeasurementNames{namesCount4});
                    SingleRunVariableTypes(namesCount2,k)="double";
                    CombinedRunVariableTypes(namesCount2,k)="double";
                    namesInd(namesCount2,k)=namesCount2;
                    k=k+1;
                end
            elseif namesCount3==2
                for namesCount4=1:size(MeasurementNames,2)
                    SingleRunVariableNames{namesCount2,k}=strcat(AgentNames{namesCount2},EventNames{namesCount3},MeasurementNames{namesCount4});
                    CombinedRunVariableNames{namesCount2,k}=strcat('Combined',AgentNames{namesCount2},EventNames{namesCount3},MeasurementNames{namesCount4});
                    SingleRunVariableTypes(namesCount2,k)="double";
                    CombinedRunVariableTypes(namesCount2,k)="double";
                    namesInd(namesCount2,k)=namesCount2;
                    k=k+1;
                end
            elseif namesCount3==3
                for namesCount4=2:size(MeasurementNames,2)
                    SingleRunVariableNames{namesCount2,k}=strcat(AgentNames{namesCount2},EventNames{namesCount3},MeasurementNames{namesCount4});
                    CombinedRunVariableNames{namesCount2,k}=strcat('Combined',AgentNames{namesCount2},EventNames{namesCount3},MeasurementNames{namesCount4});
                    SingleRunVariableTypes(namesCount2,k)="double";
                    CombinedRunVariableTypes(namesCount2,k)="double";
                    namesInd(namesCount2,k)=namesCount2;
                    k=k+1;
                end
            end
        end
    end

    OFATtableVariableNames={'OFATFolderName','UAFolderName','Placement','Width','T_Elevation','T_River','Pd','Pb'};
    tableVariableNames={'OFATFolderName','UAFolderName','Placement','Width','T_Elevation','T_River','Pd','Pb'};
    tableVariableTypes={'cell','cell','cell','double','double','double','double','double','cell'};

    for popCount=1:4
        for paramNameCount=1:size(ParamNames,2)-1
            SingleRunVariableNames{popCount,k+paramNameCount-1}=ParamNames{paramNameCount+1};
            CombinedRunVariableNames{popCount,k+paramNameCount-1}=ParamNames{paramNameCount+1};
            SingleRunVariableTypes(popCount,k+paramNameCount-1)="double";
            CombinedRunVariableTypes(popCount,k+paramNameCount-1)="double";
        end
    end

    AllVars=cell(1,6);ReproVars=cell(1,6);BoundVars=cell(1,6);NonRNonBVars=cell(1,6);

    %     for popCount2=1:4
    for colCount=1:6
        AllVars(1,colCount)=SingleRunVariableNames(1,colCount);
        AllTypes(1,colCount)="double";
        ReproVars(1,colCount)=SingleRunVariableNames(2,colCount);
        ReproTypes(1,colCount)="double";
        BoundVars(1,colCount)=SingleRunVariableNames(3,colCount);
        BoundTypes(1,colCount)="double";
        NonRNonBVars(1,colCount)=SingleRunVariableNames(4,colCount);
        NonRNonBTypes(1,colCount)="double";
    end

    %% Creates or loads Shell Table for Parameters
    %     if ~(isfile([fileShell 'CollectedFileNamesAndParamValuePieces.mat']))

    %% We're trying to get the single location files to work. Give yourself 1 hour to get this done with some focus. Once done, grab the results from the agents. 
    %% This is the LAST time you are going to force this thing without another simulation done first. 
    %% I want a sim suite run next with the neighborhood set up like we found with the commented out homo case that worked. 
    %%  Make sure you can recover that imagery before you go too far down the rabbit hole and remember to get through github. 
    %% That'll save your life if you buckle down and get it done, you dink. Stop faffing about with your life already. 
    %% Find a good video introduction on the thing and go to the gym while getting that input and get ready. No more weed once this batch is gone. %%
    for tableCount=1:height(C)
        tableFileIndex=(ic==tableCount);
        tableFiles=Folders2Consider(tableFileIndex,:);


        for fileGrabCount=1:sum(ic==tableCount)
            fileGrabName=tableFiles{fileGrabCount,5};
%             if strcmp(fileGrabName,singleFilename)
                fileGrabName=strcat(fileGrabName,'\*.mat');
                mainDirContents = dir(fileGrabName);
                mask = ismember( {mainDirContents.name}, {'.', '..'});
                mainDirContents(mask) = [];
                num_subfolder = length(mainDirContents);
                for runCount=1:num_subfolder
                    this_folder = fullfile( mainDirContents(runCount).name );
                    %                     UAFileNames(runCount)=this_folder;
                    if ~isfile([mainDirContents(runCount).folder '\AllCollectedInformation_' this_folder(1:end-4) '.csv'])
                        ComparisonObject = matfile([mainDirContents(runCount).folder,'\',this_folder],'Writable',true);
                        if width(ComparisonObject.maxPositions)>=28
                            parseDataFromMatFilesWithTimeToTable(mainDirContents,this_folder,ComparisonObject,runCount);
                        elseif (21<=width(ComparisonObject.maxPositions) && width(ComparisonObject.maxPositions)<28)
                            parseDataFromMatFilesWithTime27RowsToTable(mainDirContents,this_folder,ComparisonObject,runCount);
                        elseif width(ComparisonObject.maxPositions)<21
                            parseDataFromMatFilesWithoutTimeToTable(mainDirContents,this_folder,ComparisonObject,runCount);
                        end
                    end
                end
%             end
        end
    end
    %     end
    %         save('SimResults\CoweetaCollectedNeedProcessing.mat','PreResultsStructure','-v7.3')
end
