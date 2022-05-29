function [boundAgsBySideIDs,outAgsIDs,inIDs]=findBoundaryAgs(flies,landGrid,fullTempIDVec)
downId=le(flies(fullTempIDVec,1),2);
leftId=le(flies(fullTempIDVec,2),2);
outlogicIDs=or(downId,leftId);
upId=le(size(landGrid,2)-1,flies(fullTempIDVec,1));
outlogicIDs=or(outlogicIDs,upId);
rightId=le(size(landGrid,1)-1,flies(fullTempIDVec,2));
outlogicIDs=or(outlogicIDs,rightId);
boundAgsBySideIDs=[downId leftId upId rightId];
outAgsIDs=fullTempIDVec(outlogicIDs)';
inIDs=fullTempIDVec(~outlogicIDs)';
if ~isempty(outAgsIDs)
    outAgsIDs;
end
end