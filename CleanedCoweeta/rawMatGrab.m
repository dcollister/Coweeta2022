function [FileRecallStruct]=rawMatGrab(outmostFolder)
    list=dir([outmostFolder '**\*2021*.mat']);
   
uncleanedAllNamesStructure=struct2table(list);%,'Name',{list.name},'folder',{list.folder});

A=groupcounts(uncleanedAllNamesStructure,'folder');

% FileRecallStruct=struct('LandChoice',[],'AgentPlacementChoiceNames',[],...
%     'FixedParamsNames',[],'PBofatValuesNames',[]);

GroupCount = A{:,2};
groupArray=zeros(size(GroupCount,1),max(GroupCount));
groupvec=zeros(length(GroupCount),1);
groupvecBegin(1)=1;
groupvecEnd(1)=GroupCount(1);

for i=2:length(GroupCount)
    groupvecBegin(i)=groupvecEnd(i-1)+1;
    groupvecEnd(i)=groupvecEnd(i-1)+GroupCount(i);
end

FileRecallStruct=struct();
folder1 = table2cell(uncleanedAllNamesStructure(:,2));

for groupCount=1:length(GroupCount)
placeholdername=A.folder{groupCount};
ind=strcmp(placeholdername,folder1);
FileRecallStruct(groupCount).PBofatValuesNames=extractAfter(placeholdername,'IsingModel\');
testing = (uncleanedAllNamesStructure(ind,[1 3]));
FileRecallStruct(groupCount).ofatUArunnameTable=testing;
end

end