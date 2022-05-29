function[preWeightsRestrictRiver,preWeightsRestrictLand] = ...
        NeighborhoodConstruction(riverGrid_prob,preWeights,riverCoords)
    %Copy Preweights for river removal on land sections
    
    length=size(riverCoords,1);
    preWeightsRestrictRiverCoords = cell(1,length);
    preWeightsRestrictRiverCoordsPreVec = repmat(zeros(1,9),[1,length]);
    chunk_size = [1 9];
    sc = size(preWeightsRestrictRiverCoordsPreVec) ./ chunk_size;
    preWeightsRestrictRiverCoordsVec = ...
        mat2cell(preWeightsRestrictRiverCoordsPreVec, ...
        chunk_size(1) * ones(sc(1),1), chunk_size(2) *ones(sc(2),1));
    preWeightsRestrictRiver = [preWeightsRestrictRiverCoords;preWeightsRestrictRiverCoordsVec];
    neighboringCoords = zeros(9*size(riverCoords,1),2);
    
    
    %Create the two separated domains for use if failure to cross boundary
    %occurs
    for coordCount=1:length
        xCol=riverCoords(coordCount,1);yRow=riverCoords(coordCount,2);
        if yRow==481 && xCol==308
            statement=coordCount;
        end
        preWeightsRestrictRiver{1,coordCount}=[xCol yRow];
        for neighCount=1:9
            if yRow==482 && xCol==307
                statement=coordCount;
                XColCoord=xCol-1+mod(floor((neighCount-1)/3),3);
                YRowCoord=yRow+1-mod((neighCount-1),3);
                COORDScoords=[XColCoord,YRowCoord];
                [xCol-1+mod(floor((neighCount-1)/3),3) yRow+1-mod((neighCount-1),3)];
                neighCount;
            end
            if riverGrid_prob{yRow,xCol}(neighCount)==1
                preWeightsRestrictRiver{2,coordCount}(neighCount)=preWeights{yRow,xCol}(neighCount);
            else
                neighboringCoords(9*(coordCount-1)+neighCount,1:2)= ...
                    [xCol-1+mod(floor((neighCount-1)/3),3) yRow+1-mod((neighCount-1),3)];
                preWeightsRestrictRiver{2,coordCount}(neighCount)=0;
            end
        end
    end
    
    neighboringCoordsUnique=unique(neighboringCoords,'rows');
    neighCoords=neighboringCoordsUnique;
    for i=1:length
        neighCoords=setdiff(neighCoords,riverCoords(i,1:2),'rows');
    end
    neighCoordsFinal=setdiff(neighCoords,[0 0],'rows');
    length2=size(neighCoordsFinal,1);
    preWeightsRestrictLandCoords = cell(1,length2);
    preWeightsRestrictLandCoordsPreVec = repmat(zeros(1,9),[1,length2]);
    chunk_size = [1 9];
    sc = size(preWeightsRestrictLandCoordsPreVec) ./ chunk_size;
    preWeightsRestrictLandCoordsVec = ...
        mat2cell(preWeightsRestrictLandCoordsPreVec, ...
        chunk_size(1) * ones(sc(1),1), chunk_size(2) *ones(sc(2),1));
    preWeightsRestrictLand = [preWeightsRestrictLandCoords;preWeightsRestrictLandCoordsVec];
    
    for coordCount=1:length2
        yRow=neighCoordsFinal(coordCount,2);xCol=neighCoordsFinal(coordCount,1);
        preWeightsRestrictLand{1,coordCount}=[xCol yRow];
        for neighCount=1:9
            if riverGrid_prob{yRow,xCol}(neighCount)==1
                preWeightsRestrictLand{2,coordCount}(neighCount)=0;
            else
                preWeightsRestrictLand{2,coordCount}(neighCount)=preWeights{yRow,xCol}(neighCount);
            end
        end
    end
%     hold on
%     scatter(neighCoords(:,1),neighCoords(:,2))
%     scatter(riverCoords(:,1),riverCoords(:,2),'black','filled')
%     hold off
end