%% Uses Matlab Function "groupcounts" to find coordinates of agent deaths and returns amount of deaths.
%% Separated by recatangular sides of the current map
%Labelings not obvs.  GCX=group count X, GRX=value of X
%Maxes grabs highest counts across each boundary, last place holds highest
%count over all positions.

%% Notes
%1)  Currently we are considering each node to be independent.  Should revisit
%   to make intervals of collection.  Width of collection intervals based on
%   some benchmark x>value could show windows of moves out of the boundaries.
%   Need more math on this one.
%2)  Thinking about adding a filter to capture the width.  Consider
%Window=10m idk why atm.  Count # in window, or other way of showing wtf is
%going on.

function [BoundaryCoords,boundaryRowY,boundaryColX,Group,maxes,TopRowY1,TopColX1,BottomRowY2,BottomColX2,LeftRowY3,LeftColX3,RightRowY4,RightColX4]=...
        CollectingBoundaryDeaths(testFileFolder,saveFileName,inputMatrix)
right=size(inputMatrix,2);
bottom=size(inputMatrix,1);
%% Individuals
%%TOP
[TopRowY1,TopColX1]=find(inputMatrix(1,:)>0);
TopRowY1=1*ones(size(TopRowY1',1),1);
%%Bottom
[BottomRowY2,BottomColX2]=find(inputMatrix(bottom,:)>0);
BottomRowY2=bottom*ones(size(BottomRowY2',1),1);
%%Left
[LeftRowY3,LeftColX3]=find(inputMatrix(:,1)>0);
LeftColX3=1*ones(size(LeftColX3,1),1);
%%Right
[RightRowY4,RightColX4]=find(inputMatrix(:,right)>0);
RightColX4=right*ones(size(RightColX4,1),1);
%%All
boundaryRowY=[TopRowY1;BottomRowY2;LeftRowY3;RightRowY4];
boundaryColX=[TopColX1';BottomColX2';LeftColX3;RightColX4];
BoundaryCoords=[boundaryColX boundaryRowY];
%% Collect in one cell array for analysis as whole.
%%TOP
[GCX1,GRX1]=groupcounts(TopColX1');
Group{1,1}=GCX1;Group{2,1}=GRX1;Group{3,1}=[];
if ~isempty(GCX1)
maxes(1)=max(GCX1);
else
    maxes(1)=0;
end
%%Bottom
[GCX2,GRX2]=groupcounts(BottomColX2');
Group{1,2}=GCX2;Group{2,2}=GRX2;
if ~isempty(GCX2)
maxes(2)=max(GCX2);
else
    maxes(2)=0;
end
%%Left
[GCY3,GRY3]=groupcounts(LeftRowY3);
Group{1,3}=GCY3;Group{2,3}=GRY3;
if ~isempty(GCY3)
maxes(3)=max(GCY3);
else
    maxes(3)=0;
end
%%Right
[GCY4,GRY4]=groupcounts(RightRowY4);
Group{1,4}=GCY4;Group{2,4}=GRY4;
if ~isempty(GCY4)
maxes(4)=max(GCY4);
else
    maxes(4)=0;
end

maxes(5)=max(maxes);

save([testFileFolder saveFileName 'BoundDeathCoords.mat'],'BoundaryCoords','boundaryRowY','boundaryColX','Group','maxes',...
        'TopRowY1','TopColX1','BottomRowY2','BottomColX2','LeftRowY3','LeftColX3','RightRowY4','RightColX4');

end