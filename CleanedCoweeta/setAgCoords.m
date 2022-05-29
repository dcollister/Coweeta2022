function [agCoords]=setAgCoords(riverCoordsBirth,riverBranchNumber,branchCoords,AgentPlacementChoice)

if AgentPlacementChoice==1 %Homogeneous
    agCoords=riverCoordsBirth;
else
    if width(riverBranchNumber)>1
    nodeTracker=1;
    for branchCount=1:width(riverBranchNumber)
        if AgentPlacementChoice==2 %Head
            agCoords(1,1:3)=branchCoords{riverBranchNumber(branchCount)}(1,1:3);
        elseif AgentPlacementChoice==3 %Mouth
            agCoords(1,1:3)=branchCoords{riverBranchNumber(branchCount)}(length(branchCoords{branchCount}),1:3);
        elseif AgentPlacementChoice==4 %Midpoint
            agCoords(1,1:3)=branchCoords{riverBranchNumber(branchCount)}(floor(length(branchCoords{branchCount}/2)),1:3);
        elseif AgentPlacementChoice==5 %Staggered <-- heads of each segment comprising branch
            for nodeCount=1:length(branchCoords{riverBranchNumber(branchCount)})
                agCoords(nodeTracker,1:3)=branchCoords{riverBranchNumber(branchCount)}(nodeCount,1:3);
                nodeTracker=nodeTracker+1;
            end
        end
    end
    else
        if AgentPlacementChoice==2 %Head
            agCoords(1,1:3)=branchCoords{riverBranchNumber}(1,1:3);
        elseif AgentPlacementChoice==3 %Mouth
            agCoords(1,1:3)=branchCoords{riverBranchNumber}(length(branchCoords{riverBranchNumber}),1:3);
        elseif AgentPlacementChoice==4 %Midpoint
            agCoords(1,1:3)=branchCoords{riverBranchNumber}(floor(length(branchCoords{riverBranchNumber})/2),1:3);
        elseif AgentPlacementChoice==5 %1/4 down the branch
            agCoords(1,1:3)=branchCoords{riverBranchNumber}(floor(length(branchCoords{riverBranchNumber})/4),1:3);
        elseif AgentPlacementChoice==6 %3/4 down the branch
            agCoords(1,1:3)=branchCoords{riverBranchNumber}(floor(length(branchCoords{riverBranchNumber})/4*3),1:3);
        elseif AgentPlacementChoice==7 %Staggered <-- heads of each segment comprising branch
                agCoords(:,1:3)=branchCoords{riverBranchNumber}(:,1:3);
        end        
end
end