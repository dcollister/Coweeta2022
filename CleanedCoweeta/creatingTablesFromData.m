function creatingTablesFromData(CoweetaCollectedNeedProcessing)

    LandFilesArray = table2cell(CoweetaCollectedNeedProcessing(:,2));
    ParamNamesArray = table2cell(CoweetaCollectedNeedProcessing(:,3));
    ProcessedArray = table2array(CoweetaCollectedNeedProcessing(:,8));
    CollectionsArray=repmat({'ProbBirth_'},height(CoweetaCollectedNeedProcessing),1);
%     CoweetaCollectionAll1FilesIndices = cellfun(@contains,LandFilesArray,CollectionsArray);
    CoweetaCollectionAll2FilesIndices = cellfun(@contains,ParamNamesArray,CollectionsArray);
    processedIndex1  =  cellfun(@isempty,ProcessedArray);
    CoweetaCollectionAllFilesIndices=CoweetaCollectionAll2FilesIndices;%CoweetaCollectionAll1FilesIndices|CoweetaCollectionAll2FilesIndices;
    Folders2Consider=CoweetaCollectedNeedProcessing(processedIndex1,:);
    [C,ia,ic] = unique(Folders2Consider.LandFiles);
    
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
    if ~(isfile([fileShell 'CollectedFileNamesAndParamValuePieces.mat']))
        
        load([fileShell 'ParamNameArray.mat'],'C')
        AHold=C(1,:,:);
        a=cellfun(@isempty,AHold(1,:,1));
        A1=AHold(1,~a,1)';
        A2=AHold(1,~a,2)';
        fileName1=cell(size(A1,1),1);
        fileName11=cell(size(A1,1),2);
        OFATName1=cell(size(A1,1),2);
        sz1=[1 8];
        
        BHold=C(2,:,:);
        b=cellfun(@isempty,BHold(1,:,1));
        B1=BHold(1,~b,1)';
        B2=BHold(1,~b,2)';
        fileName2=cell(size(B1,1),1);
        fileName21=cell(size(B1,1),2);
        OFATName2=cell(size(B1,1),2);
        sz2=[1 8];
        
        for choice=1:2
            
            %% Home fileNames for identical runs
            if choice==1
                
                HomoInd1=[10:14];
                HomoInd21=[3 6 8 9 13];
                HomoInd22=[3 1 1 4 1];
                
                for nameCount=1:size(A1,1)
                    fileName1{nameCount}=fileShell;
                    
                    for indCount=1:size(HomoInd21,2)
                        %% Coweeta-->Homo
                        %%%%%%%%%% SimResults\CoweetaCollection\Coweeta\Whole\Complete\Riv_All\Homo
                        
                        for pieceCount=1:HomoInd22(indCount)
                            %% Param File from first run
                            if indCount==4 && pieceCount==1
                                paramValFoldName1=[fileName1{nameCount}];
                            else
                            end
                            
                            if indCount == 1
                                fileName1{nameCount}=strcat(fileName1{nameCount},A2{nameCount,1}{HomoInd21(indCount)+pieceCount-1},'\');
                            elseif indCount == (2)
                                fileName1{nameCount}=...
                                    strcat(fileName1{nameCount},...
                                    A2{nameCount,1}{HomoInd21(indCount)+pieceCount-1},...
                                    '_',A2{nameCount,1}{HomoInd21(indCount)+pieceCount});
                            elseif indCount == 3
                                fileName1{nameCount}=strcat(fileName1{nameCount},'\',A2{nameCount,1}{HomoInd21(indCount)+pieceCount-1},'\');
                            elseif indCount == 4
                                fileName1{nameCount}=strcat(fileName1{nameCount},A2{nameCount,1}{HomoInd21(indCount)+pieceCount-1},A1{nameCount,1}{HomoInd1(pieceCount)});
                            elseif indCount == 5
                                OFATName1{nameCount}=strcat(fileName1{nameCount},'\');
                                fileName1{nameCount}=strcat(fileName1{nameCount},'\',A2{nameCount,1}{HomoInd21(indCount)+pieceCount-1},A1{nameCount,1}{HomoInd1(indCount)});
                            end
                        end
                    end
                    
                    fileName1{nameCount}=strcat(fileName1{nameCount},'\');
                    
                    fileName11{nameCount,1}=OFATName1{nameCount};
                    
                    fileName11{nameCount,2}=fileName1{nameCount};
                    
                    fileName11{nameCount,3}=landType{choice};
                    
                    xCounter=1;
                    
                    for xCount=HomoInd1
                        doubHold=A1{nameCount,1}{xCount};
                        newStr = erase( doubHold , '_' );
                        fileName11{nameCount,3+xCounter}=str2double(newStr);
                        xCounter=xCounter+1;
                    end
                    
                end
                
                load([paramValFoldName1 'paramValArray.mat'],'paramValArray');
                HomoParamArray=paramValArray;
                
                t11=cell2table(fileName11,'VariableNames',OFATtableVariableNames);
                [a011,~]=unique(t11,'rows');
                HomoTable=a011;
                %% Sing6M fileNames for identical runs
            elseif choice==2
                
                Sing6MInd1=[11:15];
                Sing6MInd21=[3 6 9 10 14];
                Sing6MInd22=[3 3 1  4  1];
                
                for nameCount2=1:size(B1,1)
                    fileName2{nameCount2}=fileShell;
                    
                    for indCount2=1:size(Sing6MInd21,2)
                        %% Coweeta-->Homo
                        %%%%%%%%%% SimResults\CoweetaCollection\Coweeta\Whole\Complete\Riv_All\Homo
                        for pieceCount2=1:Sing6MInd22(indCount2)
                            %% Param File from first run
                            if (indCount2==4 && pieceCount2==1)
                                paramValFoldName2=[fileName2{nameCount2}];
                            end
                            
                            if indCount2 == 1
                                fileName2{nameCount2}=strcat(fileName2{nameCount2},B2{nameCount2,1}{Sing6MInd21(indCount2)+pieceCount2-1},'\');
                            elseif indCount2 == 2
                                fileName2{nameCount2}=strcat(fileName2{nameCount2},...
                                    B2{nameCount2,1}{Sing6MInd21(indCount2)+pieceCount2-1},B1{nameCount2,1}{Sing6MInd21(indCount2)+pieceCount2});
                                %%%%%%%%%%  After \Homo locations
                            elseif indCount2 == 3
                                fileName2{nameCount2}=strcat(fileName2{nameCount2},B2{nameCount2,1}{Sing6MInd21(indCount2)+pieceCount2-1},'\');
                            elseif indCount2 == 4
                                fileName2{nameCount2}=strcat(fileName2{nameCount2},B2{nameCount2,1}{Sing6MInd21(indCount2)+pieceCount2-1},B1{nameCount2,1}{Sing6MInd21(indCount2)+pieceCount2});
                            elseif indCount2 == 5
                                OFATName2{nameCount2}=strcat(fileName2{nameCount2},'\');
                                fileName2{nameCount2}=strcat(fileName2{nameCount2},'\',B2{nameCount2,1}{Sing6MInd21(indCount2)+pieceCount2-1},B1{nameCount2,1}{Sing6MInd21(indCount2)+pieceCount2});
                            end
                        end
                    end
                    
                    fileName2{nameCount2}=strcat(fileName2{nameCount2},'\');
                    
                    fileName21{nameCount2,1}=OFATName2{nameCount2};
                    
                    fileName21{nameCount2,2}=fileName2{nameCount2};
                    
                    fileName21{nameCount2,3}=landType{choice};
                    
                    xCounter2=1;
                    for xCount2=Sing6MInd1
                        doubHold=B1{nameCount2,1}{xCount2};
                        newStr = erase( doubHold , '_' );
                        fileName21{nameCount2,3+xCounter2}=str2double(newStr);
                        xCounter2=xCounter2+1;
                    end
                    
                end
                load([paramValFoldName2 'paramValArray.mat'],'paramValArray');
                Sing6MParamArray=paramValArray;
                
                t21=cell2table(fileName21,'VariableNames',OFATtableVariableNames);
                [a021,~]=unique(t21,'rows');
                Sing6MTable=a021;
            end
        end
        save([fileShell 'CollectedFileNamesAndParamValuePieces.mat'],'HomoTable','Sing6MTable','HomoParamArray','Sing6MParamArray')
    else
        load([fileShell 'CollectedFileNamesAndParamValuePieces.mat'],'HomoTable','Sing6MTable','HomoParamArray','Sing6MParamArray')
    end
    
    tabSize=[size(HomoTable,1) size(Sing6MTable,1)];
    tables={HomoTable Sing6MTable};
    
    for tableCount=1:2
        for tableFileCount=1:tabSize(1)
            TEl=tables{tableCount}.T_Elevation(tableFileCount);TRiv=tables{tableCount}.T_River(tableFileCount);pd=tables{tableCount}.Pd(tableFileCount);pb=tables{tableCount}.Pb(tableFileCount);
            project_dir = tables{tableCount}.UAFolderName{tableFileCount};%['SimResults\',RunSaveFolder,runName];%pwd();     %or give a particular directory name
            
            mainDirContents = dir([project_dir '*.mat']);
            mainDirContents([mainDirContents.isdir]) = [];   %remove non-folders
            mask = ismember( {mainDirContents.name}, {'.', '..'});
            mainDirContents(mask) = [];
            num_subfolder = length(mainDirContents);
            %                             runData(:,29:32,:)=HomoTable.(4:7).(tableFileCount);
            %                             AgentVarIndices
            %                             SingleRunVariableNames  CombinedRunVariableNames
            for runCount=1:num_subfolder
                this_folder = fullfile( mainDirContents(runCount).name );
                if ~isfile([mainDirContents(runCount).folder '\AllCollectedInformation_' this_folder(1:end-4) '.csv'])
                    ComparisonObject = matfile([project_dir,this_folder],'Writable',true);
                    variableIndicies={[1:2],[3:4],[5:6],[7:8],9,[10:11],[12:13],[14:15],16,17,18,19,20,21,22,23,24,25,26,27,28};
                    Filename=convertCharsToStrings(this_folder);
                    
                    if ~isfile([mainDirContents(runCount).folder '\Fileinfo_' this_folder(1:end-4) '.csv'])
                        Seed=ComparisonObject.s;
                        fileInfo=table(Filename,Seed);
                        writetable(fileInfo,[mainDirContents(runCount).folder '\Fileinfo_' this_folder(1:end-4) '.csv'])
                    end
                    
                    idAll = ComparisonObject.maxPositions(:,9)>=0;
                    idRepro = ComparisonObject.maxPositions(:,16)>0;
                    idBound = ComparisonObject.maxPositions(:,27)>0;
                    idNonRNonB = ( idRepro | idBound );
                    
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
                    
                    TablesNames={'AllCollectedInformation' 'ReproCollectedInformation' 'BoundCollectedInformation' 'NonRNonBCollectedInformation'};
                    MaxPositions=ComparisonObject.maxPositions;
                    
                    for TablesCount=1:4
                        if indCount2(TablesCount)==1
                            XminCoords=MaxPositions(indArray{TablesCount},variableIndicies{1});
                            XMaxCoords=MaxPositions(indArray{TablesCount},variableIndicies{2});
                            YMinCoords=MaxPositions(indArray{TablesCount},variableIndicies{3});
                            YMaxCoords=MaxPositions(indArray{TablesCount},variableIndicies{4});
                            RadialMaxCoords=MaxPositions(indArray{TablesCount},variableIndicies{5});
                            RMaxCoords=MaxPositions(indArray{TablesCount},variableIndicies{6});
                            BirthCoords=MaxPositions(indArray{TablesCount},variableIndicies{7});
                            DeathCoords=MaxPositions(indArray{TablesCount},variableIndicies{8});
                            ReproCounter=MaxPositions(indArray{TablesCount},variableIndicies{9});
                            AgentID=MaxPositions(indArray{TablesCount},variableIndicies{10});
                            BeginningBranch=MaxPositions(indArray{TablesCount},variableIndicies{11});
                            Gender=MaxPositions(indArray{TablesCount},variableIndicies{12});
                            GenePool=MaxPositions(indArray{TablesCount},variableIndicies{13});
                            XMinTime=MaxPositions(indArray{TablesCount},variableIndicies{14});
                            XMaxTime=MaxPositions(indArray{TablesCount},variableIndicies{15});
                            YMinTime=MaxPositions(indArray{TablesCount},variableIndicies{16});
                            YMaxTime=MaxPositions(indArray{TablesCount},variableIndicies{17});
                            RadialMaxTime=MaxPositions(indArray{TablesCount},variableIndicies{18});
                            DeathTime=MaxPositions(indArray{TablesCount},variableIndicies{19});
                            BoundaryDeathTime=MaxPositions(indArray{TablesCount},variableIndicies{20});
                            ReproDeathTime=MaxPositions(indArray{TablesCount},variableIndicies{21});
                            % Convert cell to a table and use first row as variable names
                            if TablesCount == 1 && indCount2(TablesCount)==1
                                
                                AllCollectedInformation=table(XminCoords,XMaxCoords,YMinCoords,YMaxCoords,RadialMaxCoords,RMaxCoords,...
                                    BirthCoords,DeathCoords,ReproCounter,AgentID,BeginningBranch,Gender,GenePool,...
                                    XMinTime,XMaxTime,YMinTime,YMaxTime,RadialMaxTime,DeathTime,BoundaryDeathTime,ReproDeathTime);
                                
                                writetable(AllCollectedInformation,[mainDirContents(runCount).folder '\AllCollectedInformation_' this_folder(1:end-4) '.csv'])
                            elseif TablesCount == 2 && indCount2(TablesCount)==1
                                
                                ReproCollectedInformation=table(XminCoords,XMaxCoords,YMinCoords,YMaxCoords,RadialMaxCoords,RMaxCoords,...
                                    BirthCoords,DeathCoords,ReproCounter,AgentID,BeginningBranch,Gender,GenePool,...
                                    XMinTime,XMaxTime,YMinTime,YMaxTime,RadialMaxTime,DeathTime,BoundaryDeathTime,ReproDeathTime);
                                
                                writetable(ReproCollectedInformation,[mainDirContents(runCount).folder '\ReproCollectedInformation_' this_folder(1:end-4) '.csv'])
                            elseif TablesCount == 3 && indCount2(TablesCount)==1
                                
                                BoundCollectedInformation=table(XminCoords,XMaxCoords,YMinCoords,YMaxCoords,RadialMaxCoords,RMaxCoords,...
                                    BirthCoords,DeathCoords,ReproCounter,AgentID,BeginningBranch,Gender,GenePool,...
                                    XMinTime,XMaxTime,YMinTime,YMaxTime,RadialMaxTime,DeathTime,BoundaryDeathTime,ReproDeathTime);
                                
                                writetable(BoundCollectedInformation,[mainDirContents(runCount).folder '\BoundCollectedInformation_' this_folder(1:end-4) '.csv'])
                            elseif TablesCount == 4 && indCount2(TablesCount)==1
                                
                                NonRNonBCollectedInformation=table(XminCoords,XMaxCoords,YMinCoords,YMaxCoords,RadialMaxCoords,RMaxCoords,...
                                    BirthCoords,DeathCoords,ReproCounter,AgentID,BeginningBranch,Gender,GenePool,...
                                    XMinTime,XMaxTime,YMinTime,YMaxTime,RadialMaxTime,DeathTime,BoundaryDeathTime,ReproDeathTime);
                                
                                % Write the table to a CSV file
                                writetable(NonRNonBCollectedInformation,[mainDirContents(runCount).folder '\NonRNonBCollectedInformation_' this_folder(1:end-4) '.csv'])
                            end
                        end
                    end
                end
                %             load([project_dir,this_folder],'maxPositions');%load(['SimResults\',RunSaveFolder,this_folder],'maxPositions');%
                %                                 ComparisonObject.maxPositions
                
                % % % % %                 %% Separate different populations, removing zeros
                % % % % %                 dataSet.AllAgentsFullData{runCount}=maxPositions;
                % % % % %                 dataSet.ReproAgentsFullDataOrderedStreamNames{runCount}=maxPositions([maxPositions(:,16)==1],:);
                % % % % %                 dataSet.NonReproAgentsFullDataOrderedStreamNames{runCount}=maxPositions(~[maxPositions(:,16)==1],:);
                % % % % %                 AllAgentsInfoHolder=maxPositions;
                % % % % %                 ReproAgentsInfoHolder=maxPositions((maxPositions(:,16)==1),:);
                % % % % %                 NonReproInfoHolder=maxPositions(~(maxPositions(:,16)==1),:);
                % % % % %
                % % % % %                 %% Generate Max Dists
                % % % % %                 dataSet.maxDisplaceAllHolderOrderedStreamNames{runCount}=AllAgentsInfoHolder(:,9);
                % % % % %                 dataSet.maxDisplaceReproHolderOrderedStreamNames{runCount}=ReproAgentsInfoHolder(:,9);
                % % % % %                 dataSet.maxDisplaceNonHolderOrderedStreamNames{runCount}=NonReproInfoHolder(:,9);
                % % % % %                 maxDisplaceAllHolder=AllAgentsInfoHolder(:,9);
                % % % % %                 maxDisplaceReproHolder=ReproAgentsInfoHolder(:,9);
                % % % % %                 maxDisplaceNonHolder=NonReproInfoHolder(:,9);
                
                
                
                
                % % % % %                 %% Populate Groups for plots by id # of file.  Note that there currently is
                % % % % %                 %% not correlation between x vals other than index num of file
                % % % % %
                % % % % %                 groupAll = [groupAll; AllAgentsInfoHolder];
                % % % % %                 groupRepro = [groupRepro; ReproAgentsInfoHolder];
                % % % % %                 groupNon = [groupNon; NonReproInfoHolder];
                % % % % %
                % % % % %                 %% Populate Max Dist for boxplots
                % % % % %
                % % % % %                 maxDisplaceAll{runCount}=maxDisplaceAllHolder;
                % % % % %                 maxDisplaceRepro{runCount}=maxDisplaceReproHolder;
                % % % % %                 maxDisplaceNon{runCount}=maxDisplaceNonHolder;
                
                %%%%move the file to a saver location once data processing is done.
                % movefile this_file strcat['SimResults\9_3_2021Runs\',
                % mainDirContentsOrderedStreamNames{runCount}.name]
                % % % % %                 if ~isempty(AllAgentsInfoHolder)
                % % % % %                     AllAgentsInfo(k1:k1+size(AllAgentsInfoHolder,1)-1,:,runCount)=AllAgentsInfoHolder;
                % % % % %                 end
                % % % % %                 if ~isempty(ReproAgentsInfoHolder)
                % % % % %                     ReproAgentsInfo(k2:k2+size(ReproAgentsInfoHolder,1)-1,:,runCount)=ReproAgentsInfoHolder;
                % % % % %                 end
                % % % % %                 if ~isempty(NonReproInfoHolder)
                % % % % %                     NonReproInfo(k3:k3+size(NonReproInfoHolder,1)-1,:,runCount)=NonReproInfoHolder;
                % % % % %                 end
            end
        end
    end
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     maxPositions=ComparisonObject.maxPositions;
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 idAll = ComparisonObject.maxPositions(:,9)>=0;
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 idRepro = ComparisonObject.maxPositions(:,16)>0;
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 idBound = ComparisonObject.maxPositions(:,27)>0;
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 idNonRNonB = ( idRepro | idBound );
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 IDAll=find(idAll);
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 IDRepro=find(idRepro);
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 IDBound=find(idBound);
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 IDNonRNonB=find(idNonRNonB);
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 Tables={AllTable ReproTable BoundTable NonRNonBTable};
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 AllTable=table('Size',[size(IDAll,1) size(AllVars,2)],'VariableNames',AllVars,'VariableTypes',AllTypes);
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 ReproTable=table('Size',[size(IDRepro,1),size(ReproVars,2)],'VariableNames',ReproVars,'VariableTypes',ReproTypes);
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 BoundTable=table('Size',[size(IDBound,1),size(BoundVars,2)],'VariableNames',BoundVars,'VariableTypes',BoundTypes);
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 NonRNonBTable=table('Size',[size(IDNonRNonB,1),size(NonRNonBVars,2)],'VariableNames',NonRNonBVars,'VariableTypes',NonRNonBTypes);
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 for tableCount=1:4
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 for count=1:6
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                     Tables{tableCount}.(count)=maxPositions(popsInd{tableCount},AgentVarIndices{count});
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 end
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 end
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 UATable=table();
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                 UATable.Filename(runCount)=this_folder;
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %             UATable.AllAgents(runCount)=AllTable;
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %             UATable.ReproAgents(runCount)=ReproTable;
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %             UATable.BoundAgents(runCount)=BoundTable;
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %             UATable.NonRNonBAgents(runCount)=this_folder;
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %             'Size',[num_subfolder 5],'VariableNames',UAVarNames,'VariableTypes',UAVarTypes
end
%     "string",...
%     "double",...
%     "double","double","double",...
%     "double","double","double",
%     "combinedArray];
%
%     "Agent Type",...
%     "Birth Position",...
%     "Max Distance","Max Position","Max Time",...
%     "Death Position","Death Time","Boundary Time"];