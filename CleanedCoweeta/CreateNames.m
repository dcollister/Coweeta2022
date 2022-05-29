function [PhysicalDataFileName,NormedName,coordsFileName] = CreateNames(DataStructureRunFolder,CoweetaFolder,normedVecNameFolder,AgentCoordsNameFolder,pd,pb)
    % %
    %Satellite Imagery Processing
    PhysicalDataFileName=strcat(DataStructureRunFolder,'PhysData.mat');
    
    NormedName=strcat(normedVecNameFolder,'Normed.mat');
                
   coordsFileName=strcat(AgentCoordsNameFolder,'Coords.mat');
end

% 
%                 
%                 
%                 
%                 if ~exist([normedVecNameFolder],'dir')
%                     mkdir(normedVecNameFolder)
%                 end
%     
%     Runname=strcat(runType,'_Width',num2str(width),'EleT_',...
%         num2str(TLand),'RivT_',num2str(TRiver),'ProbDeath_',num2str(pd),'ProbBirth_',num2str(pb),'\');