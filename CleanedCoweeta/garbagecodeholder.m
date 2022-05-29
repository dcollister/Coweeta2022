
    k=0;
for i = 1:length(GroupCount)-1
    groupArray(i,1:GroupCount(i)) = (linspace(1,GroupCount(i),GroupCount(i))+k);
    groupArray2(i,1:GroupCount(i)) = linspace(1,1,GroupCount(i))*i;
    k=GroupCount(i);
end

groupArray = reshape(groupArray', 1, []);
groupArray(groupArray==0)=[];
groupArray2 = reshape(groupArray2', 1, []);
groupArray2(groupArray2==0)=[];

for i=1:length(groupArray)
    
    str1=convertCharsToStrings(uncleanedAllNamesStructure{groupArray(i),2}{1});str2=convertCharsToStrings(uncleanedAllNamesStructure{groupArray2(i),2}{1});
    if ~strcmp(str1,str2)
        beep
    end
end

% testTable=uncleanedAllNamesStructure{1:2,(uncleanedAllNamesStructure.2{:}==A{1,1}{1})}
uncleanedAllNamesStructure=convertvars(uncleanedAllNamesStructure,'rowNames','categorical');
ofatFold='SimResults\CoweetaCollection\OFAT\';

if ~isfolder(ofatFold)

mkdir(ofatFold)

end

for i=1:size(folderName)

% index rows with the correct variables in column
idx = (uncleanedAllNamesStructure.folder == folderName{i});

% create table based on index
UATable = tbl(idx,:);  

writetable(UATable)

end

% folderName=unique(uncleanedAllNamesStructure.folder);
% uncleanedAllNamesStructure.folder=categorical(uncleanedAllNamesStructure.folder);
% folder_index=ismember({uncleanedAllNamesStructure.folder},folderName)
% folder_data=uncleanedAllNamesStructure(folder_index)
% [uncleanedAllNamesStructure.CatData] = uncleanedAllNamesStructure.folder; 
% S2 = orderfields(uncleanedAllNamesStructure,'CatData','folder');
% S2 = rmfield(S2,'CatData');
% 
% B=array2table(A,'RowNames',{'row1','row2','row3'})
% temp = struct2cell(uncleanedAllNamesStructure.').'; S3 = table(temp(:, 1), temp(:, 2), 'VariableNames', {'Name', 'folder'});clear temp
% 
% S3.folder = categorical(S3.folder);
% 
% 
% result = rowfun(@filtercols, t, 'GroupingVariable', 'Week', 'NumOutputs', 4, 'OutputVariableNames', {'Open', 'High', 'Low', 'Close'})
% 
% [group, id] = findgroups({list.folder}.');
% temp = struct2cell(list).'; folder = temp(:, 2); clear temp;
% temp = struct2cell(list).'; name = temp(:, 1); clear temp;
% [isInOneOfTheListedSectors,indexToWhichSector] = ismember([list.folder],{'folder';'name'});
% 
% %% Function to find info from Table
% func = @(p, q, r, s) [p(1), max(q), min(r), s(end)];
% 
% result = splitapply(func, [name,folder], group)
% listout = array2table([id, result],...
%   'VariableNames', list.Properties.VariableNames);
% 
% foldersVectorholder=struct2table(list);
% folders=unique({list.folder}.');
% 
% load('C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\');
%  
% 
% [G, yrs] = findgroups(folderName(uncleanedAllNamesStructure.Name));