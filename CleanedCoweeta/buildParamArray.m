function [NamesandParamsTable] = buildParamArray()

    if isfile('SimResults\CoweetaCollection\NamesandParamsTable.mat')
        load('SimResults\CoweetaCollection\NamesandParamsTable.mat','CSplitFinal');
    else
        CSplitFinal{1,1}='';
    end
    a12=genpath('SimResults\CoweetaCollection\Coweeta\');
    B=strread(a12,'%s','delimiter',';');
    B(1)=[];
    CSplit=repmat({''},length(B),1);

    for i=1:length(B)
        C=B{i};
        CSplit{i}=strsplit(C,'\');
        clear(C);
    end

    vnames = {'FileHolder', 'LandFiles', 'ParamName', 'ET', 'RT', 'ProbDeath', 'ProbReproduction', 'ProcessedName'};
    nv = length(vnames);
    vt(1:3) = "string";
    vt(4:7) = "double";
    vt(8) = "string";
    NamesandParamsTable = table('Size', [0 nv], 'VariableNames', vnames, 'VariableTypes', vt);

    if (length(CSplit)) == (length(CSplitFinal))
        load('SimResults\CoweetaCollection\NamesandParamsTable.mat','NamesandParamsTable');
    else

        fileCounter=1;

        for i=1:length(CSplit)

            workingfile=CSplit{i};
            landname = string([]);filename=string([]);ParamName=string([]);ProcessedName=string([]);ParamString=string([]);
            widthSize=width(workingfile);
            CoweetaStop=0;landcount=0;k=0;parameterSwitch=0;processSwitch=0;
            if widthSize<3
                fileholder=join(workingfile,'\');
                NamesandParamsTable.FileHolder(i)=fileholder{1};
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
                    end
                    if CoweetaStop==1 && landcount==0

                        if contains(filehold,'ProbBirth') || contains(filehold,'_Width') || contains(filehold,'W_')
                            landcount=1;
                        elseif contains(filehold,'Coweeta')

                        elseif landcount==0

                            if isempty(landname)
                                landname=filehold;
                            else
                                landname=strcat(landname,'\',filehold);
                            end

                        end

                        if j==length(workingfile)
                            landcount=1;
                        end
                    end

                    if (CoweetaStop==1 && landcount==1 && ~isempty(landname))

                        if contains(filehold,'_Width') || contains(filehold,'W_')
                            ParamName=filehold;
                        elseif ~isempty(ParamName)
                            ParamName=strcat(ParamName,'\',filehold);
                        else
                        end

                        if parameterSwitch==0
                            if contains(filehold,'W_')
                                if isempty(ParamString)
                                    ParamString=filehold;
                                else
                                    ParamString=strcat(ParamString,'\',filehold);
                                end
                            elseif contains(filehold,'_Width')
                                if isempty(ParamString)
                                    ParamString=filehold;
                                else
                                    ParamString=strcat(ParamString,'\',filehold);
                                end
                            end
                            parameterSwitch=1;
                        elseif contains(filehold,'_Width') && parameterSwitch==1
                            ParamString=filehold;
                        elseif contains(filehold,'ProbBirth') && parameterSwitch==1
                            if isempty(ParamString)
                                ParamString=filehold;
                            else
                                ParamString=strcat(ParamString,'\',filehold);
                            end
                            parameterSwitch=2;
                        elseif j==widthSize && parameterSwitch<2
                            if isempty(ParamString)&&~isempty(ParamName)
                                ParamString=filehold;
                            else
                                ParamString=strcat(ParamString,'\',filehold);
                            end
                        end
                    end

                    if contains(filehold,'Comb')
                        processSwitch=1;
                    end

                    if processSwitch==1
                        if isempty(ProcessedName)
                            ProcessedName=filehold;
                        else
                            ProcessedName=strcat(ProcessedName,'\',filehold);
                        end
                    end
                end
            end

            if CoweetaStop==1 && landcount==1 && parameterSwitch==2

                N=split(ParamString,["_","\","Prob","Width","EleT","RivT","ET","RT","Birth"]);
                N = N(strlength(N) > 0);
                N = str2double(N);
                N = N(~isnan(N));
                k=1;

            end
            if parameterSwitch==2 && ~isempty(ParamName)
                NamesandParamsTable.FileHolder(fileCounter)=filename;
                NamesandParamsTable.LandFiles(fileCounter)=landname;
                NamesandParamsTable.ParamName(fileCounter)=ParamName;
                if k>0
                    NamesandParamsTable.ET(fileCounter)=N(2);
                    NamesandParamsTable.RT(fileCounter)=N(3);

                    if length(N)>3
                        NamesandParamsTable.ProbDeath(fileCounter)=N(4);
                    else
                        NamesandParamsTable.ProbDeath(fileCounter)=NaN;
                    end

                    if length(N)>4
                        NamesandParamsTable.ProbReproduction(fileCounter)=N(5);
                    else
                        NamesandParamsTable.ProbReproduction(fileCounter)=NaN;
                    end
                end

                if ~isempty(ProcessedName)
                    NamesandParamsTable.ProcessedName(fileCounter)=ProcessedName;
                else
                    NamesandParamsTable.ProcessedName(fileCounter)='';
                end
                fileCounter=fileCounter+1;
            end
        end
        CSplitFinal=CSplit;
        save('SimResults\CoweetaCollection\NamesandParamsTable.mat','NamesandParamsTable','CSplitFinal');
        disp('Contents of newstruct.mat:')
        whos('-file', 'SimResults\AllFileLocations.mat')
    end
end
