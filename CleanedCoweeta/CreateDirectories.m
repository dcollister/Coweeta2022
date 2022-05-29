 function [runType,Runname,CoweetaFolder,normedVecNameFolder,AgentCoordsNameFolder,DataStructureRunFolder,RunSaveFolder] = ...
        CreateDirectories(resultsFolderName,dataFolder,landtype,subtype,order,branchesChoice,InsideOrderCounter,singleBranchString,placement,width,TLand,TRiver,pd,pb)
    if InsideOrderCounter==100
    runType=strcat(landtype,'\',subtype,'\',order,'\','Riv_',branchesChoice,'\',placement,'\');
    elseif InsideOrderCounter~=100
    runType=strcat(landtype,'\',subtype,'\',order,'\','Riv_',branchesChoice,'_Branch_',singleBranchString,'\',placement,'\');    
    end
    Runname=strcat(runType,'W_',num2str(width),'_ET_',...
        num2str(TLand),'_RT_',num2str(TRiver),'PD_',num2str(pd),'PB_',num2str(pb),'\');
    
    CoweetaFolder=[dataFolder,runType];
    
    normedVecNameFolder=strcat(dataFolder,runType,'NormVecs\','W_',num2str(width),'_ET_',...
        num2str(TLand),'_RT_',num2str(TRiver),'\');
    
    AgentCoordsNameFolder=strcat(dataFolder,runType,'AgCoords\');
    
    DataStructureRunFolder=[dataFolder,Runname];
    
    RunSaveFolder=[resultsFolderName,Runname];
    
    if ~exist(CoweetaFolder,'dir')
        mkdir(CoweetaFolder)
    end
                
    if ~exist(AgentCoordsNameFolder,'dir')
        mkdir(AgentCoordsNameFolder)
    end
                
    if ~exist(normedVecNameFolder,'dir')
        mkdir(normedVecNameFolder)
    end
                    
    if ~exist(DataStructureRunFolder,'dir')
        mkdir(DataStructureRunFolder)
    end
                    
    if ~exist(RunSaveFolder,'dir')
        mkdir(RunSaveFolder)
    end
    
 end