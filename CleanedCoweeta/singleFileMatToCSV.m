 function singleFileMatToCSV()
    fileGrabName='SimResults\FebruaryRuns2\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\';
    singlefileParamName=strcat(fileGrabName, '\NamesandParamsTable.mat');
    mainDirContents = dir(fileGrabName);
    mask = ismember( {mainDirContents.name}, {'.', '..'});
    mainDirContents(mask) = [];
    num_subfolder = length(mainDirContents);
    %% Convert Tables to CSV Files
%     for runCount=1:num_subfolder
%         this_folder = fullfile( mainDirContents(runCount).name );
%         Filename=convertCharsToStrings(this_folder);
%         fileLoc=extractAfter(mainDirContents(runCount).folder,'IsingModel\');
%         if ~isfile([fileLoc, '\AllCollectedInformation_' this_folder(1:end-4) '.csv'])
%             ComparisonObject = matfile([mainDirContents(runCount).folder,'\',this_folder],'Writable',true);
%             if width(ComparisonObject.maxPositions)>=28
%                 parseDataFromMatFilesWithTimeToTable(mainDirContents,this_folder,ComparisonObject,runCount);
%             elseif width(ComparisonObject.maxPositions)<=20
%                 parseDataFromMatFilesWithoutTimeToTable(mainDirContents,this_folder,ComparisonObject,runCount);
%             end
%         end
%     end
    %% Move all files to correct folders
    for runCount=1:num_subfolder
        this_folder = fullfile( mainDirContents(runCount).name );
        Filename=convertCharsToStrings(this_folder);
        fileLoc=extractAfter(mainDirContents(runCount).folder,'IsingModel\');
        N=split(Filename,["W_","_ET_","_RT_","ProbDeath_","ProbBirth_","Timestamp","\CombinedFilesProbBirth_","\ProbBirth_"]);
        N = N(strlength(N) > 0);
        N = str2double(N);
        N = N(~isnan(N));
        
        oldHome=strcat(mainDirContents(runCount).folder,'\*',this_folder,'*');
        oldHomefilename = convertCharsToStrings(oldHome);
        newHomeDir=strcat([fileLoc '\W_0_ET_' num2str(N(2)) ,'_RT_', num2str(N(3)), 'ProbDeath_', num2str(N(4)), '\']);
        if ~isfolder(newHomeDir)
            mkdir(newHomeDir);
        else
        end
        movefile(oldHomefilename,newHomeDir);
    end

    %% Create Parameter Table for collection creation
%     if ~isfile(singlefileParamName)
%     fileGrabName='SimResults\FebruaryRuns2\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\';
%     mainDirContents = dir(fileGrabName);
%     mask = ismember( {mainDirContents.name}, {'.', '..'});
%     mainDirContents(mask) = [];
%     num_subfolder = length(mainDirContents);
%     rowID=0;
%     for runCount=1:num_subfolder
%         this_folder = fullfile( mainDirContents(runCount).name );
%         fileLoc=extractAfter(mainDirContents(runCount).folder,'IsingModel\');
%         subFilename=strcat(fileLoc,'\',this_folder,'\W_*');
% 
%         mainSubDirContents = dir(subFilename);
%         mask = ismember( {mainSubDirContents.name}, {'.', '..'});
%         mainSubDirContents(mask) = [];
%         num_subfilesSubfolder = length(mainSubDirContents);
% 
%         
%         for fileCount=1:num_subfilesSubfolder
%         rowID=rowID+1;    
%         subFilenameIndi=extractAfter(mainSubDirContents(fileCount).name,'W_');
%         N=split(subFilenameIndi,["W_","_ET_","_RT_","ProbDeath_","ProbBirth_","Timestamp","\CombinedFilesProbBirth_","\ProbBirth_"]);
%         N = N(strlength(N) > 0);
%         N = str2double(N);
%         N = N(~isnan(N));
%         NamesandParamsTable(rowID).FileHolder=extractAfter(mainDirContents(runCount).folder,'IsingModel\');
%         NamesandParamsTable(rowID).LandFiles=extractAfter(mainDirContents(runCount).folder,'FirstOrder\');
%         NamesandParamsTable(rowID).ParamName=extractAfter(this_folder,'W_0_');
%         NamesandParamsTable(rowID).OFATName=extractAfter(this_folder,'W_0_');
%         NamesandParamsTable(rowID).PBName=extractBefore(subFilenameIndi,'Timestamp');
%         NamesandParamsTable(rowID).ProcessedName='';
%         NamesandParamsTable(rowID).ET=N(2);
%         NamesandParamsTable(rowID).RT=N(3);
%         NamesandParamsTable(rowID).ProbDeath=N(4);
%         NamesandParamsTable(rowID).ProbReproduction=N(5);
%         end
%     end
%     save(singlefileParamName ,'NamesandParamsTable');
end