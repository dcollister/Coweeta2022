function [FilesRequiringMoving,AllCollectedFolds,ProcessedFolds,CoweetaCollectedNeedProcessing]=filterStruc()

    if isfile('SimResults\AllFileLocations.mat')
        load('SimResults\AllFileLocations.mat','structFin');
    else
        structFin=struct();
    end

    a12=genpath('SimResults\');
    B=strread(a12,'%s','delimiter',';');
    B(1)=[];
    CSplit=repmat({''},length(B),1);

    for i=1:length(B)
        C=B{i};
        CSplit{i}=strsplit(C,'\');
        clear(C);
    end
    if (length(CSplit)) == (length(structFin))
    else
        Paramcutoffstrings={'W_0_ET_' '_RT_' 'ProbDeath_' '\C' 'ProbBirth_'};
        for i=1:length(CSplit)

            workingfile=CSplit{i};
            landname = string([]);filename=string([]);ParamName=string([]);ProcessedName=string([]);
            widthSize=width(workingfile);
            CoweetaStop=0;landcount=0;paramcount=0;k=0;
            if widthSize<3
                structFin(i).FileHolder=join(workingfile,'\');
            else
                for j=1:widthSize
                    filehold=workingfile{j};
                    if CoweetaStop==0

                        if strcmp(filehold,'Coweeta')
                            CoweetaStop=1;
                        end

                        if j==1
                            filename=filehold;
                        else
                            filename=strcat(filename,'\',filehold);
                        end

                    else

                        if strcmp(filehold(1:3),'W_0')
                            landcount=1;
                        end

                        if landcount==0

                            if isempty(landname)
                                landname=filehold;
                            else
                                landname=strcat(landname,'\',filehold);
                            end

                        else

                            if paramcount==0

                                if isempty(ParamName)
                                    ParamName=filehold;
                                else
                                    ParamName=strcat(ParamName,'\',filehold);
                                end

                                if strcmp(filehold(1),'C')
                                    paramcount=1;
                                end

                            else

                                N=split(ParamName,["_","\","Prob"]);
                                N = N(strlength(N) > 0);
                                N = str2double(N);
                                N = N(~isnan(N));
                                k=1;
                                if isempty(ProcessedName)
                                    ProcessedName=filehold;
                                else
                                    ProcessedName=strcat(ProcessedName,'\',filehold);
                                end

                            end

                        end

                    end

                end
                structFin(i).FileHolder=filename;
                structFin(i).LandFiles=landname;
                structFin(i).ParamName=ParamName;

                if k>0
                    structFin(i).ET=N(2);
                    structFin(i).RT=N(3);

                    if length(N)>3
                        structFin(i).ProbDeath=N(4);
                    end

                    if length(N)>4
                        structFin(i).ProbReproduction=N(5);
                    end
                end

                structFin(i).ProcessedName=ProcessedName;
            end
        end

        save('SimResults\AllFileLocations.mat','structFin');
        disp('Contents of newstruct.mat:')
        whos('-file', 'SimResults\AllFileLocations.mat')
    end
    structFin1 = table({structFin.FileHolder}.', {structFin.LandFiles}.', {structFin.ParamName}.', {structFin.ProcessedName}.', {structFin.ET}.', {structFin.RT}.', {structFin.ProbDeath}.', {structFin.ProbReproduction}.', 'VariableNames', {'FileHolder', 'LandFiles', 'ParamName', 'ProcessedName', 'ET', 'RT', 'ProbDeath', 'ProbReproduction'});
    clear('structFin')
    logicCheck=@(x,y) x && y;
    FileHolder = table2cell(structFin1(:,1));
    ProcessNameArray = table2cell(structFin1(:,3));
    processedIndex1  =  ~cellfun(@isempty,ProcessNameArray);
    CollectionArray=repmat({'CoweetaCollection'},length(FileHolder),1);
    CoweetaCollectionFilesIndices = cellfun(@contains,FileHolder,CollectionArray);
    FilesRequiringMovingIndicesPRE=~cellfun(@contains,FileHolder,CollectionArray);
    FilesRequiringMovingIndices=FilesRequiringMovingIndicesPRE&processedIndex1;

    structFin2 = structFin1(CoweetaCollectionFilesIndices,:);
    ProcessNameArray1 = table2cell(structFin2(:,3));
    ProcessNameArray2 = table2cell(structFin2(:,4));
    FileHolder2 = table2cell(structFin2(:,1));
    CollectionArray2=repmat({'CoweetaCollection'},length(FileHolder2),1);

    CoweetaCollectionFilesIndices2 = cellfun(@contains,FileHolder2,CollectionArray2);
    processedIndex2  =  ~cellfun(@isempty,ProcessNameArray2);
    pc=~cellfun(@isempty,ProcessNameArray1);
    unprocessedIndex= (CoweetaCollectionFilesIndices2&~processedIndex2&pc);

    FilesRequiringMoving=structFin1(FilesRequiringMovingIndicesPRE,:);
    AllCollectedFolds=structFin2;
    ProcessedFolds=structFin2(processedIndex2,:);
    CoweetaCollectedNeedProcessing=structFin2(unprocessedIndex,:);
    %     CollectionProcessedFolds=structFin1(FoldersWithParametersAndSummaryIndices,:);

    save('SimResults\FilesRequiringMoving.mat','FilesRequiringMoving');
    save('SimResults\AllCollectedFolds.mat','AllCollectedFolds');
    save('SimResults\ProcessedFolds.mat','ProcessedFolds');
    save('SimResults\CoweetaCollectedRequiringProcessing.mat','CoweetaCollectedNeedProcessing');
end
%%
%%
%%

%     completeFolders={beginStruct.PBofatValuesNames}.';
%     tf=contains(completeFolders,'CoweetaCollection');
%     A=completeFolders(tf);a=completeFolders(~tf);
%     B=cell2table(A);
%     structFin.CoweetaCollection=B;
%     completeFolders.CoweetaCollection=completeFolders(tf);
%
%     for i=1:length(beginStruct)
%         beginStruct(i).PBofatValuesNames
%         folderHolders=extractAfter(beginStruct(1).PBofatValuesNames,'SimResults\');
%         TF = contains(str,pat)
%     end
% end