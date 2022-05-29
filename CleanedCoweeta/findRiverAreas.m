function [rivCoords,rivNodesInReg,clusters]=FindRiverAreas(altGrid,landGrid,centerX,centerY,sourceR,catchInR,catchOutR,ReproMat)
[riverCoordsYRow,riverCoordsXCol]=find(landGrid>0);
rivCoords=[riverCoordsXCol riverCoordsYRow];
for i=1:size(rivCoords,1)
riverCoordsZ(i,1)=altGrid(riverCoordsYRow(i,1),riverCoordsXCol(i,1));
end
rivCoords=[rivCoords riverCoordsZ];

distFromSing=sqrt((rivCoords(:,1)-centerX*ones(size(rivCoords,1),1)).^2+((rivCoords(:,2)-centerY*ones(size(rivCoords,1),1)).^2));
[rivNodeInRegIDs]=find(distFromSing>catchInR & distFromSing<catchOutR);
rivNodesInReg=rivCoords(rivNodeInRegIDs,:);

%function to grab local coordinates of traps within defined outer region by
%nbhd for later evaluation
[clusters]=findLocNbhds(rivNodesInReg,sourceR,ReproMat);
end