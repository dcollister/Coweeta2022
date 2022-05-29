function [outputMins] = firstTimeCompute(coordsTable, ids)
coordsTable.IDs=ids;
testCoordsAscendingTime=sort(testCoords,3,'ascend');
testCoordsPreProcess=sort(testCoordsAscendingTime,4,'ascend');
end