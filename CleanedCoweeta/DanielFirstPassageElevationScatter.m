function resultsStructure=DanielFirstPassageElevationScatter(agentsInfoTable,Elevation,River,resultsCats,varCoords,varTime,Shapes,reproPointer,sheetCount,tilecount,resultsStructure,resultsCount)
%sub2ind(size(altGrid),agentMat{:,'RMaxCoords_2'},agentMat{:,'RMaxCoords_1'})
% load('LandandAltGrids.mat','altLandGrid','landGrid');
% load('sampleSet.mat','agentsInfoTable');
altLandGrid=Elevation;landGrid=River;timeVar=varTime(1);
intervalWidth=5;
maxTimeActual=max(agentsInfoTable{:,timeVar});
Coords = GenerateFirstPassageCoords(agentsInfoTable,resultsCats,varCoords,varTime);


hold on
grid on

%% Fix landscape beneath heatmap
[LandCont,contH]=contour(altLandGrid,'showtext','on');
contH.LineWidth = 0.5;
contH.EdgeColor=[0 0 0];
clabel(LandCont,contH,'FontSize',10,'color','k','FontSmoothing','on','LabelSpacing',200)

%% Fix River above landscape
[rivRowY,rivColX]=find(landGrid==1);
rivScat=scatter(rivColX,rivRowY,12,'MarkerEdgeColor','k','MarkerFaceColor','k');
SpawnLocScat1=scatter(agentsInfoTable{:,'BirthCoords_1'},agentsInfoTable{:,'BirthCoords_2'},86,'filled','o','MarkerFaceColor','white','MarkerFaceAlpha',0.5,'MarkerEdgeColor','black');
SpawnLocScat1=scatter(agentsInfoTable{:,'BirthCoords_1'},agentsInfoTable{:,'BirthCoords_2'},86,'filled','p','MarkerFaceColor','red','MarkerFaceAlpha',0.5,'MarkerEdgeColor','black');

% for scatCount=1:height(Coords)
    tableOfNote=Coords{reproPointer};pointStyle=Shapes{reproPointer};
    s=scatter(tableOfNote,varCoords{1},varCoords{2},'filled','Marker',pointStyle,'ColorVariable',timeVar{1});
%     s.SizeData = 5;
%     cbc=colorbar;
% end
% view(2);

PopC=colorbar;
w = PopC.LineWidth;
PopC.LineWidth = 1.5;
% Names=strcat(string(PopC.Ticks),' or ~ ',string(PercentLabels),'%');
% PopC.TickLabels = Names;
PopC.Label.String = 'Time in seconds';
pos = get(PopC,'Position');
cellSizeString=PopC.Label.String;
title(PopC,cellSizeString);

% colorbar
% C=caxis;
% caxis([C(1),C(2)]);

% lgd=legend('Elevation Contour Isolines (meters above sea level).','The Coweeta river network.','Reproduction Locations.');
% lgd.Location='best';
titleName={'Scatterplot of Agents','Time to Position'};
title(titleName)
xlabel('Lattitude (meters)')
ylabel('Longitude (meters)')
%                                 ylabel.orientation='vertical';
% zlabel('Number of reproducing agents')
% view(-45,42);

% 

hold off
end
% titleName=strcat({[titleTopLineFrontPiece, ' with ~',num2str(PercentBirthsOfTotal) ,'% of the population reproducing.']
%     [num2str(length) ' successful agents out of a population of ' num2str(TotalPopSize) '.  Longest lifespan: ' num2str(maxTime) ' seconds.']
%     ['Elevation: ' PhysFactorNames{TChoice1} '. River: ' PhysFactorNames{TChoice2} '.']
%     ['Environment Lethality: ' BioFactorNames{BioChoice1} '. Chance of Reproduction: ' BioFactorNames{BioChoice2} '.']
%     });
%     lgd.Orientation='horizontal';
%         PopDistHist=histogram2(testAgTable{:,'DeathCoords_1'},testAgTable{:,'DeathCoords_2'},[binsYRows binsXCols],'BinMethod','integers','DisplayStyle','bar3','EdgeAlpha',0.5);
%                                 the following line skip the name of the previous plot from the legend
%         PopDistHist.Annotation.LegendInformation.IconDisplayStyle = 'off';

%% Graph generation for 3-d histogram evaluation
%         [m,mx,my]=rfmatrix(test2DMat,binsYRows,binsXCols,flagx,flagy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Graph generation for 3-d histogram evaluation %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure out shadow on back panel
%         shading interp
%         shadowplot x

% 
% BirthBiVarDistBotCol=[0 0 255]/255;
% BirthBiVarDistTopCol=[0 255 255]/255;
% DistBotCol=[57 168 251]/255;
% DistTopCol=[251, 98, 5]/255;
% for i=1:3
%     countColors(:,i)=linspace(DistBotCol(i),DistTopCol(i),max(output)+1);
% end
% countColorVec=countColors(output,:);

% make a custom colormap
% n = 256; % how many levels do you want?
% cvu = linspace(0,1,n).';
% cvd = flipud(cvu);
% cmap = [cvu cvu cvd];
% 
% red = [1, 0, 0];
% pink = [255, 192, 203]/255;
% orange=[251, 98, 5]/255;
% green=[94 223 12]/255;
% myBlue=[57 168 251]/255;
% gray='#9B9B9B';
% 
% %% Size of vectors of interest.  Currently set to successful births (length) and #locations (length2)
% maxTime=max(testAgTable.DeathTime);
% length=height(testAgTable);
% A=testAgTable{:,{'DeathCoords_1','DeathCoords_2'}};
% B=unique(A,'rows');
% binsYRows=floor((max(B(:,1))-min(B(:,1)))/intervalWidth);
% binsXCols=floor((max(B(:,2))-min(B(:,2)))/intervalWidth);
% length2=size(B,1);
% a=max(max(test2DMat));
% 
% TotalPopSize=height(agentsInfoTable);
% PercentBirthsOfTotal=round((100*length/TotalPopSize),-2);
% 
% linSpacePercentInterval=roundn(a/(length*10),-5);
% linSpaceEndPercent=roundn(a/(length),-4);
% linSpaceLabels=100*(0:linSpacePercentInterval:linSpaceEndPercent);
% PercentLabels=linspace(0,linSpaceEndPercent,10);
% linSpaceEnd=roundn(a,(floor(log10(a+1))-1));
% PercentLabels=round(100*linspace(0,linSpaceEndPercent,10),3,"decimals");
% round(PercentLabels,4,"decimals");
%% Color vectors for scatter/hist work
% colors_Bound = [linspace(red(1),pink(1),length)', linspace(red(2),pink(2),length)',...
%     linspace(red(3),pink(3),length)'];
% colors_SpawnLoc = [linspace(orange(1),orange(1),length)',...
%     linspace(orange(2),orange(2),length)',...
%     linspace(orange(3),orange(3),length)'];
% colors_BirthBiVarDist = [linspace(BirthBiVarDistBotCol(1),BirthBiVarDistTopCol(1),length2)',...
%     linspace(BirthBiVarDistBotCol(2),BirthBiVarDistTopCol(2),length2)',...
%     linspace(BirthBiVarDistBotCol(3),BirthBiVarDistTopCol(3),length2)'];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % % % % % % % % % % % % % Begin Graph % % % % % % % % % % % % % % % % % %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Toggle on for separate figure %%
%     reproAgsFig=figure('Name','Successful Reproduction Agents Infographic',...
%     'NumberTitle','off');
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% set(gcf,'Color','w');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     SpawnLocScat2=scatter(MatrixOfInterest(:,4),MatrixOfInterest(:,5),168,'y','filled','p');
%         PopDistHist=histogram2(testAgTable{:,'DeathCoords_1'},testAgTable{:,'DeathCoords_2'},[binsYRows binsXCols],'DisplayStyle','bar3','EdgeAlpha',0.5,'FaceColor','flat');
% set(PopDistHist,'facecolor','none','edgecolor','interp');
% set(PopDistHist,'linewidth',3); % make it fat so it's easier to demonstrate
% view(2); % only show 2-D view
% colormap(cmap);
% colorbar