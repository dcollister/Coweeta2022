function [combinedIDs]=combineLogicalIndices(idCollection)
combinedIDs=zeros(height(idCollection),1,'logical');
    for idVecCount=1:width(idCollection)
        combinedIDs=(combinedIDs,idCollection(:,idVecCount));
    end

end