function [] = renameFilesWithoutTimestamps(FilesRequiringMoving)
    %% For each filename, collect name, search for matfiles, and move to collection location
    for storLengthCount=1:size(FilesRequiringMoving,1)
        CatenateFolderNames='';
        for cellarrayelementcounter=1:3
            if ~isempty(FilesRequiringMoving{storLengthCount,cellarrayelementcounter}{1})&&iscellstr(FilesRequiringMoving{storLengthCount,cellarrayelementcounter}{1})
                if isequal('',CatenateFolderNames)
                CatenateFolderNames=strcat(FilesRequiringMoving{storLengthCount,cellarrayelementcounter}{1}{1},'\');
                elseif isequal('\',CatenateFolderNames(end))
                CatenateFolderNames=strcat(CatenateFolderNames,FilesRequiringMoving{storLengthCount,cellarrayelementcounter}{1}{1});
                
                else
                CatenateFolderNames=strcat(CatenateFolderNames,'\',FilesRequiringMoving{storLengthCount,cellarrayelementcounter}{1}{1});
                end
            elseif ~isempty(FilesRequiringMoving{storLengthCount,cellarrayelementcounter}{1})&&ischar(FilesRequiringMoving{storLengthCount,cellarrayelementcounter}{1})
                if isequal('',CatenateFolderNames)
                CatenateFolderNames=strcat(FilesRequiringMoving{storLengthCount,cellarrayelementcounter}{1},'\');
                elseif isequal('\',CatenateFolderNames(end))
                CatenateFolderNames=strcat(CatenateFolderNames,FilesRequiringMoving{storLengthCount,cellarrayelementcounter}{1});
                else
                CatenateFolderNames=strcat(CatenateFolderNames,'\',FilesRequiringMoving{storLengthCount,cellarrayelementcounter}{1});
                end
            end
        end
 if isequal('\',CatenateFolderNames(end))
 else
    CatenateFolderNames=strcat(CatenateFolderNames,'\');
 end
    runName='*.mat';
    
    project_dir = strcat(CatenateFolderNames,runName);%['SimResults\',RunSaveFolder,runName];%pwd();     %or give a particular directory name
    mainDirContents = dir(project_dir);
    mainDirContents([mainDirContents.isdir]) = [];   %remove non-folders
    mask = ismember( {mainDirContents.name}, {'.', '..'} );
    mainDirContents(mask) = [];                       %remove . and .. folders
    num_subfolder = length(mainDirContents);
    if num_subfolder==0
        printout=storLengthCount
    else
str=extractBefore(CatenateFolderNames,'Coweeta');
str2=extractAfter(CatenateFolderNames,str);
strfin=erase(str2,'\');
strFin=extractAfter(strfin,'Coweeta');
%         PreRenameFolderHolder{1}=strcat(CatenateFolderNames);
%         PostRenameFolderHolder{1}='SimResults\CoweetaCollection\Coweeta\Whole\Complete\Riv_All\Homo\';
%         PreRenameParamHolder{1}=strcat('SimResults\CoweetaCollection\Coweeta\Whole\Complete\Riv_All\Homo\');
%         PostRenameParamHolder{1}='SimResults\CoweetaCollection\Coweeta\Whole\Complete\Riv_All\Homo\';
        
%         PreRenameFolderHolder{2}=strcat('SimResults\',FilesRequiringMoving,'\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\');
%         PostRenameFolderHolder{2}='SimResults\CoweetaCollection\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\';
%         PreRenameParamHolder{2}=strcat('SimResults\CoweetaCollection\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\');
%         PostRenameParamHolder{2}='SimResults\CoweetaCollection\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\';
        
        paramFrontFile='SimResults\CoweetaCollection\';
    
    CoweetaFolderSaveFolder=strcat(paramFrontFile,str2);
    if ~exist(CoweetaFolderSaveFolder,'dir')
        mkdir(CoweetaFolderSaveFolder)
    end

    testSimsFolder=CatenateFolderNames;
    PreParamSetName=strcat(paramFrontFile,strFin);
    PostParamSetName=strcat(paramFrontFile,strFin);
    
    if isfile([PreParamSetName,'paramValArray.mat'])
        load([PreParamSetName,'paramValArray.mat'],'paramValArray');
        PreviousIndex=size(paramValArray,1);
    else
        paramValArray=zeros(num_subfolder,4);
        PreviousIndex=0;
    end
    
    if isfile([paramFrontFile,strFin,'ParamNameArray.mat'])
        load([paramFrontFile,strFin,'ParamNameArray.mat'], 'C');
        PreviousIndex2=size(C,2);
    else
        C=cell(num_subfolder,1);
        PreviousIndex2=0;
    end
    
    
    for subfold_idx= 1 : num_subfolder
        this_file = fullfile( mainDirContents(subfold_idx).name );
        inputFullFileName = fullfile(testSimsFolder, this_file);
        pat= " "| lettersPattern;
        C{PreviousIndex2+subfold_idx,1}=split(inputFullFileName,pat);
%         A1=C{PreviousIndex2+subfold_idx,1};
        C{PreviousIndex2+subfold_idx,2}=extract(inputFullFileName,pat);
%         A2=C{PreviousIndex2+subfold_idx,2};
        
        newStr = extractBefore(this_file,'ProbBirth');
        newStr2 = this_file(length(newStr)+1:end);
        InsideFolderH=extractBetween(this_file,'ProbBirth','Timestamp','Boundaries','inclusive');
        InsideFolder=InsideFolderH{1}(1:end-9);
        
        subfolder=strcat(CoweetaFolderSaveFolder,newStr,'\');
        subfolderInner=strcat(subfolder,InsideFolder,'\');
        
        if ~exist(subfolder,'dir')
            mkdir(subfolder)
        end
        
        if ~exist(subfolderInner,'dir')
            mkdir(subfolderInner)
        end
        
        newFilename=extractAfter(this_file,'Timestamp_');
        saveFilename=strcat(subfolderInner,newFilename);
        
        n=1;
        for CCount=1:4
            if str2double(C{PreviousIndex2+subfold_idx,1}{CCount+n})==1 && CCount>2
                n=n+1;
                paramValArray(PreviousIndex+subfold_idx,CCount)=10^[-str2double(C{PreviousIndex2+subfold_idx,1}{CCount+n})];
            elseif str2double(C{PreviousIndex2+subfold_idx,1}{CCount+n})==2021
                hi=1;
            else
                paramValArray(PreviousIndex+subfold_idx,CCount)=str2double(C{PreviousIndex2+subfold_idx,1}{CCount+n});
            end
        end
        
        if ~isfile(saveFilename)
            copyfile(inputFullFileName, saveFilename);
        elseif isfile(inputFullFileName)
            delete (inputFullFileName)
        else
        end
        
    end
    
%     paramValArray=unique(paramValArray,'rows');
%     [~,order]=sortrows(paramValArray,[1:4],'ascend');
%     paramValArray=paramValArray(order,:);
%     
%     if ~isfile([PreParamSetName,'paramValArray.mat'])
%         save([PreParamSetName,'paramValArray.mat'], 'paramValArray');
%     end
%     
%     if ~isfile([PostParamSetName,'paramValArray.mat'])
%         save([PostParamSetName,'paramValArray.mat'], 'paramValArray');
%     end
%     
%     save([paramFrontFile,'ParamNameArray.mat'], 'C');
    
    
    end

    end
end