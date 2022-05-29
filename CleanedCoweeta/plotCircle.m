function [handle,centerswitch]=plotCircle(r,x0,y0,color,size,parent,handleStatus,centerswitch)
 
if centerswitch
theta=linspace(0,2*pi,360);
handle=plot(x0 + r*cos(theta),y0 + r*sin(theta),'DisplayName','Catchment mean radius: 250m from source.','MarkerFaceColor',[1 1 1],'MarkerEdgeColor',[0 1 1],'MarkerSize',8,...
        'Marker','.',...
        'LineWidth',8,...
        'Color',[0.788235294117647 0.788235294117647 0.788235294117647],'Parent',parent);

elseif ~centerswitch    
theta=linspace(0,2*pi,360);
handle=plot(x0 + r*cos(theta),y0 + r*sin(theta),color,...
    'LineWidth',size,'Parent',parent,'HandleVisibility',handleStatus);
% labels{labelsCount}='Coweeta Landscape';labelsCount=labelsCount+1;
%     'MarkerSize',10,...
%     'MarkerEdgeColor','b',...
%     'MarkerFaceColor',[0.5,0.5,0.5]...
end
centerswitch=0;
end

% scatter(RiverCoords(:,1),RiverCoords(:,2),55,'MarkerEdgeColor','black',...
%               'MarkerFaceColor','white',...
%               'LineWidth',1.5)
% labels{labelsCount}='River Placement';labelsCount=labelsCount+1;



% scatter(RiverCoords(:,1),RiverCoords(:,2),55,'MarkerEdgeColor','black',...
%               'MarkerFaceColor','white',...
%               'LineWidth',1.5)
% labels{labelsCount}='River Placement';labelsCount=labelsCount+1;