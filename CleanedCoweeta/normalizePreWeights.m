function [landGrid_prob] = normalizePreWeights(preWeights,normedVecName)  
    for yRows=1:size(preWeights,1)
        for xCols=1:size(preWeights,2)
            holder=preWeights{yRows,xCols};
            nodeTot=sum(sum(holder));
            landGrid_prob{yRows,xCols}=holder./nodeTot;
        end
    end
    Z = cellfun(@(x)reshape(x,1,1,[]),landGrid_prob,'un',0);
    landGrid_prob=cell2mat(Z);
    save(normedVecName,'landGrid_prob');
end