%[landGrid_prob,riverGrid_prob,preWeights,preWeightsRestrictRiver,preWeightsRestrictLand] =
function [landGrid_prob,riverGrid_prob,preWeights,preWeightsRestrictRiver,preWeightsRestrictLand] =...
        IsingLandRiverMoveArrays(A,B,C,landscape,riverscape,TRiver,TLand,riverCoords,PhysicalData)
    if ~isfile([PhysicalData(1:end-4),'PreNeighbors.mat'])
        landGrid_prob = mat2cell(A,B,C);
        riverGrid_prob = mat2cell(A,B,C);
        TValues = mat2cell(A,B,C);
        deltaGrid = mat2cell(A,B,C);
        preWeights = mat2cell(A,B,C);
        %Find the difference in elevation for neighborhoods.  Assign T values for each neighborhood node in 1x9.
        for rowCount=2:size(landscape,1)-1
            for colCount=2:size(landscape,2)-1
                n=1;
                for colNeigh=colCount-1:1:colCount+1
                    for rowNeigh=rowCount-1:1:rowCount+1
                        %step in at particular grid node to investigate 
                        if rowCount==405 && colCount==392
                            'hi';
                        end
                        if riverscape(rowNeigh,colNeigh)==1
                            %river
                            TValues{rowCount,colCount}(1,n)=TRiver;
                        else
                            %land
                            TValues{rowCount,colCount}(1,n)=TLand;
                        end
                        
                        landGrid_prob{rowCount,colCount}(1,n)=landscape(rowNeigh,colNeigh);
                        riverGrid_prob{rowCount,colCount}(1,n)=riverscape(rowNeigh,colNeigh);
                        n=n+1;
                    end
                end
                %difference between elevations within neighborhood oriented
                %with ( [i,j] node - center )
                deltaGrid{rowCount,colCount}=( landGrid_prob{rowCount,colCount} - landGrid_prob{rowCount,colCount}(1,5));
            end
        end
        
        for rowCount=2:size(landscape,1)-1
            for colCount=2:size(landscape,2)-1
                for weightCount=1:9
                    if deltaGrid{rowCount,colCount}(weightCount)>0
                        upper=deltaGrid{rowCount,colCount}(weightCount)/TValues{rowCount,colCount}(weightCount);
                        preWeights{rowCount,colCount}(weightCount)=exp(-upper);
                    else
                        preWeights{rowCount,colCount}(weightCount)=1;
                    end
                end
            end
        end
        %Create neighborhoods with restricted domains for failure to cross
        %boundary
        save([PhysicalData(1:end-4),'PreNeighbors.mat'],'riverGrid_prob','preWeights','riverCoords','deltaGrid','landGrid_prob')
    else
        load([PhysicalData(1:end-4),'PreNeighbors.mat'],'riverGrid_prob','preWeights','riverCoords','landGrid_prob')
    end
    [preWeightsRestrictRiver,preWeightsRestrictLand] = ...
        NeighborhoodConstruction(riverGrid_prob,preWeights,riverCoords);
end