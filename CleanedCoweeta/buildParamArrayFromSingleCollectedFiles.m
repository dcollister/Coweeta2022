 function [NamesandParamsTable] = buildParamArrayFromSingleCollectedFiles(singleFilename,ofatParamString)
    singlefileParamName=strcat(singleFilename, '\NamesandParamsTable.mat');
    if ~isfile(singlefileParamName)

    mainDirContents = dir(singleFilename);
    mask = ismember( {mainDirContents.name}, {'.', '..'});
    mainDirContents(mask) = [];
    num_subfolder = length(mainDirContents);

    vnames = {'FileHolder', 'LandFiles', 'ParamName', 'OFATName','PBName','ET', 'RT', 'ProbDeath', 'ProbReproduction', 'ProcessedName'};
    nv = length(vnames);
    vt(1:5) = "string";
    vt(6:9) = "double";
    vt(10) = "string";
    NamesandParamsTable = table('Size', [0 nv], 'VariableNames', vnames, 'VariableTypes', vt);

    for fileCounter=1:num_subfolder
        singlePBFilename=strcat(singleFilename,'\',mainDirContents(fileCounter).name);
        stupidstring=strcat(ofatParamString,mainDirContents(fileCounter).name);
        N=split(stupidstring,["E","R","Pd","\CombinedFilesProbBirth_","\ProbBirth_"]);
        N = N(strlength(N) > 0);
        N = str2double(N);
        N = N(~isnan(N));

        NamesandParamsTable.FileHolder(fileCounter)=extractBefore(singleFilename,'\E');
        NamesandParamsTable.LandFiles(fileCounter)=extractAfter(singleFilename,'Source\');
        NamesandParamsTable.ParamName(fileCounter)=singleFilename;
        NamesandParamsTable.OFATName(fileCounter)=singleFilename;
        NamesandParamsTable.PBName(fileCounter)=singlePBFilename;
        NamesandParamsTable.ProcessedName(fileCounter)='';
        NamesandParamsTable.ET(fileCounter)=N(1);
        NamesandParamsTable.RT(fileCounter)=N(2);
        NamesandParamsTable.ProbDeath(fileCounter)=N(3);
        NamesandParamsTable.ProbReproduction(fileCounter)=N(4);
    end
    save(singlefileParamName,'NamesandParamsTable');
    disp('Contents of newstruct.mat:')
    whos('-file', singlefileParamName)
    else
    load(singlefileParamName,'NamesandParamsTable');
    end
end
%         if parameterSwitch==2 && ~isempty(ParamName)
%             NamesandParamsTable.FileHolder(fileCounter)=filename;
%             NamesandParamsTable.LandFiles(fileCounter)=landname;
%             NamesandParamsTable.ParamName(fileCounter)=ParamName;
%             NamesandParamsTable.OFATName(fileCounter)=OFATString;
%             if k>0
%                 NamesandParamsTable.ET(fileCounter)=N(2);
%                 NamesandParamsTable.RT(fileCounter)=N(3);
%
%                 if length(N)>3
%                     NamesandParamsTable.ProbDeath(fileCounter)=N(4);
%                 else
%                     NamesandParamsTable.ProbDeath(fileCounter)=NaN;
%                 end
%
%                 if length(N)>4
%                     NamesandParamsTable.ProbReproduction(fileCounter)=N(5);
%                     NamesandParamsTable.PBName(fileCounter)=PBString;
%                 else
%                     NamesandParamsTable.ProbReproduction(fileCounter)=NaN;
%                     NamesandParamsTable.PBName(fileCounter)=PBString;
%                 end
%             end
%
%             if ~isempty(ProcessedName)
%                 NamesandParamsTable.ProcessedName(fileCounter)=ProcessedName;
%             else
%                 NamesandParamsTable.ProcessedName(fileCounter)='';
%
%
%
% save(singlefileParamName,'NamesandParamsTable','CSplitFinal');
%     disp('Contents of newstruct.mat:')
%     whos('-file', singlefileParamName)
% end
% end
