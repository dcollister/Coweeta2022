function moveCSVfiles()
    close all
    fileShell='SimResults\CoweetaCollection\';
    load([fileShell 'CollectedFileNamesAndParamValuePieces.mat'],'HomoTable','Sing6MTable','HomoParamArray','Sing6MParamArray')
    variableNames={'XminCoords','XMaxCoords','YMinCoords','YMaxCoords','RadialMaxCoords','RMaxCoords',...
        'BirthCoords','DeathCoords','ReproCounter','AgentID','BeginningBranch','Gender','GenePool',...
        'XminTime','XMaxTime','YMinTime','YMaxTime','RadialMaxTime','DeathTime','BoundaryDeathTime','ReproDeathTime'};
    variableIndicies={[1:2],[3:4],[5:6],[7:8],9,[10:11],[12:13],[14:15],16,17,18,19,20,21,22,23,24,25,26,27,28};
    TableVars={'RunID','XminCoords_1','XminCoords_2','XMaxCoords_1','XMaxCoords_2','YMinCoords_1','YMinCoords_2','YMaxCoords_1','YMaxCoords_2',...
        'RadialMaxCoords','RMaxCoords_1','RMaxCoords_2','BirthCoords_1','BirthCoords_2','DeathCoords_1','DeathCoords_2','ReproCounter',...
        'AgentID','BeginningBranch','Gender','GenePool','XMinTime','XMaxTime','YMinTime','YMaxTime','RadialMaxTime','DeathTime',...
        'BoundaryDeathTime','ReproDeathTime','deathdiffX'};
    tabSize=[size(HomoTable,1) size(Sing6MTable,1)];
    tables={HomoTable Sing6MTable};
    params={HomoParamArray Sing6MParamArray};
    WeirdCount=1;
    for tableCount=1:2
        for tableFileCount=1:tabSize(1)
            TablesNames={'AllCollectedInformation' 'ReproCollectedInformation' 'BoundCollectedInformation' 'NonRNonBCollectedInformation'};
            
            for tableNameCount=1:4
                project_dir = tables{tableCount}.UAFolderName{tableFileCount};%['SimResults\',RunSaveFolder,runName];%pwd();     %or give a particular directory name
                TableType=TablesNames{tableNameCount};
                
                mainDirContents = dir([project_dir TablesNames{tableNameCount} '*.csv']);
                mainDirContents([mainDirContents.isdir]) = [];   %remove non-folders
                mask = ismember( {mainDirContents.name}, {'.', '..'});
                mainDirContents(mask) = [];
                num_subfolder = length(mainDirContents);
                
                for runCount=1:num_subfolder
                    k=0;
                    this_folder = fullfile( mainDirContents(runCount).name );
                    data=readtable([project_dir this_folder]);
                    if width(data)<30
                        BirthCoords_1 = data.BirthCoords_1;
                        BirthCoords_2 = data.BirthCoords_2;
                        DeathCoords_1 = data.DeathCoords_1;
                        DeathCoords_2 = data.DeathCoords_2;
                        data.deathdiffX = sqrt((data.BirthCoords_1-data.DeathCoords_1).^2 + (data.BirthCoords_2 - data.DeathCoords_2).^2);
                        data.RunID = repmat(this_folder(1:end-4), length(BirthCoords_1), 1);
                        data.RunID = categorical(data.RunID);
                        writetable(data,[project_dir this_folder])
                    end
                    
                    if ~isempty(data)
                        k=k+1;
                        data.RunID = categorical(data.RunID);
                        if runCount==1
                            compTable= table(data.RunID,data.RadialMaxCoords,data.RadialMaxTime,data.RMaxCoords_1,data.RMaxCoords_2,...
                                data.BirthCoords_1,data.BirthCoords_2,data.DeathCoords_1,data.DeathCoords_2,...
                                data.deathdiffX,data.DeathTime,...
                                'VariableNames',{'RunID','RadialMax','RadialMaxTime','RMaxCoords_1','RMaxCoords_2'...
                                'BirthCoords_1','BirthCoords_2','DeathCoords_1','DeathCoords_2','deathdiffX','DeathTime'});
                        else
                            t=table(data.RunID,data.RadialMaxCoords,data.RadialMaxTime,data.RMaxCoords_1,data.RMaxCoords_2,...
                                data.BirthCoords_1,data.BirthCoords_2,data.DeathCoords_1,data.DeathCoords_2,...
                                data.deathdiffX,data.DeathTime,...
                                'VariableNames',{'RunID','RadialMax','RadialMaxTime','RMaxCoords_1','RMaxCoords_2'...
                                'BirthCoords_1','BirthCoords_2','DeathCoords_1','DeathCoords_2','deathdiffX','DeathTime'});
                            compTable=vertcat(compTable,t);
                        end
                    else
                    end
                    
                end
                
                if ~isempty(compTable)
                    AgentType=extractBefore(TableType,'Collected');
                    PlacementSaveHold=extractBefore(project_dir,'ProbBirth');
                    UAhold=extractAfter(project_dir,PlacementSaveHold);
                    UASaveFolder=[PlacementSaveHold 'CombinedFiles' UAhold(1:end-1) ];
                    UAFigFile=[UASaveFolder '\Figures\'];
                    OFATfolder=[PlacementSaveHold 'CollectedRunsMeans\' AgentType '\'];
                    
                    if ~exist(UASaveFolder,'dir')
                        mkdir(UASaveFolder)
                    end
                    
                    if ~exist(UAFigFile,'dir')
                        mkdir(UAFigFile)
                    end
                    
                    [p,t,stats] = anova1(compTable.RadialMax,compTable.RunID);
                    hTable = figure(1);
                    hBoxPlot = figure(2);
                    MeansComp=figure(3);
                    [p2,t2,stats2] = anova1(compTable.RadialMax,compTable.RunID,'off');
                    if stats2.df>0
                    [c,m,h,nms] = multcompare(stats2);
                    [nms num2cell(m)];
                    end
                    saveas(hTable,[UAFigFile AgentType 'Table.fig']) 
                    saveas(hBoxPlot,[UAFigFile AgentType 'BoxPlots.fig']) 
                    saveas(MeansComp,[UAFigFile AgentType 'MeanComp.fig']) 
                    close(hTable);
                    close(hBoxPlot);
                    close(MeansComp);
                    
                    if p>0.95
                        VariationFiles{WeirdCount}=[UASaveFolder '\' TableType '.csv'];
                        WeirdCount=WeirdCount+1;
                    end  

%                         OFATtable.AgentType=AgentType;
%                         OFATtable.TEl=params{tableCount}(tableFileCount,1);
%                         OFATtable.TRiv=params{tableCount}(tableFileCount,2);
%                         OFATtable.Pd=params{tableCount}(tableFileCount,3);
%                         OFATtable.Pb=params{tableCount}(tableFileCount,4);
%                     for c=(width(OFATtable)+1):(width(OFATtable)+width(compTable)-1)
%                         OFATtable.(T.Properties.VariableNames{c})=compTable.(compTable.Properties.VariableNames{c-3});
%                         OFATtable.(c)(4*(tableFileCount-1)+tableNameCount)=mean(compTable.(c-3));
%                     end
%                     =mean(compTable{:,2:end});
                    writetable(compTable,[UASaveFolder '\' TableType '.csv']);
                    
                    if ~isfile([UASaveFolder '\' TableType '.mat'])
                        save([UASaveFolder '\' TableType '.mat'],'compTable')
                    end
                    
                    
                end
            end
        end
    end
end