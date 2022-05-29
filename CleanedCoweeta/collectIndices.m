function [combinedIDs]=collectIndices(idCollection)
combinedIDs=zeros(height(idCollection),1,'logical');
    for idVecCount=1:width(idCollection)
        combinedIDs=and(combinedIDs,idCollection(idVecCount,:));
    end

end