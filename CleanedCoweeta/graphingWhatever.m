function graphingWhatever(CoweetaFolder,runType,scatterCoorsFor3dRiver,coords,altLandGrid)
% load('Coweeta\LandandAltGrids.mat')
% count=1;
% for i=1:size(landGrid,1)
% for j=1:size(landGrid,2)
% scatterCoorsFor3dRiver(count,1)=i;
% scatterCoorsFor3dRiver(count,2)=j;
% scatterCoorsFor3dRiver(count,3)=landGrid2(i,j);
% count=count+1;
% end
% end
if isfile([CoweetaFolder,'2DStartProjection.fig'])==0
RiverX=scatterCoorsFor3dRiver(:,1);AgentX=coords(:,1);
RiverY=scatterCoorsFor3dRiver(:,2);AgentY=coords(:,2);
RiverZ=scatterCoorsFor3dRiver(:,3);AgentZ=coords(:,3);
A=find(RiverZ~=0);
count=1;
for i=1:size(A,1)
    YY(count,1)=RiverX(A(i));
    XX(count,1)=RiverY(A(i));
    ZZ(count,1)=RiverZ(A(i));
    count=count+1;
end
TwoDProj=figure('units','normalized','outerposition',[0 0 1 1]);
hold on
mesh(altLandGrid)
% colormap(autumn(100))
% S = repmat([50,25,10],numel(X),1);
% C = repmat([1,2,3],numel(X),1);
% s = S(:);
% c = C(:);
scatter3(YY,XX,ZZ,'filled','blue','MarkerEdgeColor',[0 0 .5]);
h1=scatter3(AgentX,AgentY,AgentZ+0.4,96,'MarkerEdgeColor',[0 0 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);
legend([h1],'Birth Location');
view(0,90);
hcb=colorbar;
colorTitleHandle = get(hcb,'Title');
titleString = 'Elevation in Feet';
set(colorTitleHandle ,'String',titleString);
title(runType,'');
% view(40,35)
hold off
saveas(TwoDProj,[CoweetaFolder,'2DStartProjection.fig']);
saveas(TwoDProj,[CoweetaFolder,'2DStartProjection.jpg'],'jpeg');
close(TwoDProj)



ThreeDProj=figure('units','normalized','outerposition',[0 0 1 1]);
hold on
mesh(altLandGrid)
% colormap(parula(5))
% S = repmat([50,25,10],numel(X),1);
% C = repmat([1,2,3],numel(X),1);
% s = S(:);
% c = C(:);
scatter3(YY,XX,ZZ,'filled','black');
h1=scatter3(AgentX,AgentY,AgentZ+0.4,96,'MarkerEdgeColor',[0 0 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);
legend([h1],'Birth Location');
view(0,90);
hcb=colorbar;
colorTitleHandle = get(hcb,'Title');
titleString = 'Elevation in Feet';
set(colorTitleHandle ,'String',titleString);
title(runType,'');
view(105,50)
hold off
saveas(ThreeDProj,[CoweetaFolder,'3DStartTemplate.fig']);
saveas(ThreeDProj,[CoweetaFolder,'3DStartTemplate.jpg'],'jpeg');
close(ThreeDProj)
else
end