function [handle]=plotSource(r,x0,y0,color,size,parent,handleStatus)
theta=linspace(0,2*pi,360);
handle=fill(x0 + r*cos(theta),y0 + r*sin(theta),color,'Parent',parent,'EdgeColor','yellow','FaceColor','blue','HandleVisibility','off');
% labels{labelsCount}='Coweeta Landscape';labelsCount=labelsCount+1;
%     'MarkerSize',10,...
%     'MarkerEdgeColor','b',...
%     'MarkerFaceColor',[0.5,0.5,0.5]...
end


% scatter(RiverCoords(:,1),RiverCoords(:,2),55,'MarkerEdgeColor','black',...
%               'MarkerFaceColor','white',...
%               'LineWidth',1.5)
% labels{labelsCount}='River Placement';labelsCount=labelsCount+1;