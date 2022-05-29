function[landscape,riverCoordsFinal] = GridCreation(TotalIntervals,type,landTypeName,width,...
        TRiver,TLand,CoweetaChoice,Shapefile,tifFileName,AgentPlacementChoice,PhysicalDataFileName,InsideOrderCounter)

if type==1
    
    PhysicalData=PhysicalDataFileName;
    if isfile(PhysicalData)==0
        
%%%  Converts shape and tif files into land, river and 3-d Coords. %%%
%%      NOTE:  You need the dbf and other identifying info for the shape
%%           file to use the branch numberings.
       [landGrid,altGrid,riverCoordsFinal]...
           =readshapealtordCRC(Shapefile,tifFileName,CoweetaChoice);
       riverscape=landGrid;
       landscape=altGrid;
       
       %Arrays for movement.
       A=repmat(zeros(1,9),size(landscape,1),size(landscape,2));
       B=ones(1,size(landscape,1));
       C=repmat(9,1,size(landscape,2));
       [landGrid_prob,riverGrid_prob,preWeights,preWeightsRestrictRiver,preWeightsRestrictLand]...
           =IsingLandRiverMoveArrays(A,B,C,landscape,riverscape,TRiver,TLand,riverCoordsFinal,PhysicalData);
       
       
       save(PhysicalData,'landscape','riverscape','landGrid_prob','riverGrid_prob','preWeights',...
           'riverCoordsFinal','preWeightsRestrictRiver','preWeightsRestrictLand');
       
    else
       load(PhysicalData,'landscape','riverscape','landGrid_prob','riverGrid_prob','preWeights',...
           'riverCoordsFinal','preWeightsRestrictRiver','preWeightsRestrictLand');
    end
elseif type==2
    % Basic Wedge Shape, Descending 1m/node west to east.  River set at
    % vertical median for symmetry, with size arbitrary.  Boundary conditions
    % set to zero.
    LTName=landTypeName{type};
    PhysicalData=strcat('DataStructures/',LTName,num2str(TotalIntervals),'x',num2str(TotalIntervals),...
        '_Width',num2str(width),'EleT=',num2str(TLand),'RivT=',num2str(TRiver),'.mat');
    if isfile(PhysicalData)==0
        
        %Initialize Wedge Land and River Coordinates
        landscape=zeros(TotalIntervals,TotalIntervals);
        %Give Elevation Grid values
        for preColCount=1:size(landscape,1)
            landscape(:,preColCount)=TotalIntervals+1-preColCount;
        end
        
        %River placement and width.  Extraction of Coords.
        riverscape=zeros(TotalIntervals,TotalIntervals);
        riverscape(ceil(TotalIntervals/2)-width:ceil(TotalIntervals/2)+width,:)=1;
        [riverX,riverY] = find(riverscape==1);
        riverCoordsFinal=[riverX;riverY];
            for altCount=1:size(riverX,1)
                riverCoordsFinal(altCount,3)=landscape(riverX(altCount,1),riverY(altCount,1));
            end
        
        A=repmat(zeros(1,9),TotalIntervals,TotalIntervals);
        B=ones(1,TotalIntervals);
        C=repmat(9,1,TotalIntervals);
        
        [deltaGrid,landGrid_prob,riverGrid_prob,preWeights] ...
            =IsingLandRiverMoveArrays(A,B,C,landscape,riverscape,TRiver,TLand);
        
        save(PhysicalData,'deltaGrid','landscape','riverscape','landGrid_prob',...
            'riverGrid_prob','preWeights','riverCoordsFinal');
    else
%         load(PhysicalData,'deltaGrid','landscape','riverscape','landGrid_prob','riverGrid_prob','preWeights','riverCoordsFinal');
    end
end

end