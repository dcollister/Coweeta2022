function MultiDimHistoSingGenSubPopSpecificFromTable(A,reproAgsCollective,GraphTitleHolder,subtitles,subtitlesForSaves,graphFilename,singleGraphFilename,ofatParamString)
    load('LandandAltGrids.mat','altLandGrid','landGrid');
    red = [1, 0, 0];
    pink = [255, 192, 203]/255;
    orange=[251, 98, 5]/255;
    green=[94 223 12]/255;
    myBlue=[57 168 251]/255;
    gray='#9B9B9B';
    %         BirthBiVarDistBotCol=[0 0 255]/255;
    %         BirthBiVarDistTopCol=[0 255 255]/255;
    BirthBiVarDistBotCol=[0 55 65]/255;
    BirthBiVarDistTopCol=[0 255 0]/255;
    DeathBiVarDistBotCol=[174 255 3]/255;
    DeathBiVarDistTopCol=[254 34 34]/255;
    for tableCount=5%1:width(reproAgsCollective)
if tableCount==5
        boundaryAgsGraphFunction(tableCount,graphFilename,GraphTitleHolder,singleGraphFilename,subtitles,subtitlesForSaves,reproAgsCollective,altLandGrid,landGrid,...
            red,pink,orange,green,myBlue,gray,BirthBiVarDistTopCol,BirthBiVarDistBotCol,DeathBiVarDistBotCol,DeathBiVarDistTopCol,ofatParamString);
else
end
%         GraphTitle=strcat(GraphTitleHolder,subtitles{tableCount});
%         figSaveName=strcat(graphFilename,GraphTitleHolder,subtitles(tableCount),'fig');
%         jpgSaveName=strcat(graphFilename,GraphTitleHolder,subtitles(tableCount),'jpg');
%         reproAgs=reproAgsCollective{tableCount}; if
%         height(reproAgs.BirthCoords_1)>0
%             BirthCountMat=zeros(size(landGrid));
%             MaxCountMat=zeros(size(landGrid));
%             DeathCountMat=zeros(size(landGrid)); singleHomoSwitch=2;
%             %clean up grab for 3dhisto build for i=1:size(reproAgs,1)
%                 BirthCountMat(reproAgs.BirthCoords_2(i),reproAgs.BirthCoords_1(i))=BirthCountMat(reproAgs.BirthCoords_2(i),reproAgs.BirthCoords_1(i))+1;
%                 MaxCountMat(reproAgs.RMaxCoords_2(i),reproAgs.RMaxCoords_1(i))=MaxCountMat(reproAgs.RMaxCoords_2(i),reproAgs.RMaxCoords_1(i))+1;
%                 DeathCountMat(reproAgs.DeathCoords_2(i),reproAgs.DeathCoords_1(i))=DeathCountMat(reproAgs.DeathCoords_2(i),reproAgs.DeathCoords_1(i))+1;
%             end
% 
%             LeftColMax=DeathCountMat(:,1);RightColMax=DeathCountMat(:,width(DeathCountMat));TopRowMax=DeathCountMat(1,:);BottomRowMax=DeathCountMat(height(DeathCountMat),:);
%             leftMaxRowY=find(LeftColMax==max(LeftColMax));leftMaxColX=ones(size(leftMaxRowY));
% 
%             rightMaxRowY=find(RightColMax==max(RightColMax));rightMaxColX=ones(size(rightMaxRowY)).*width(DeathCountMat);
%             topMaxColX=find(TopRowMax'==max(TopRowMax));topMaxRowY=ones(size(topMaxColX));
% 
%             bottomMaxColX=find(BottomRowMax'==max(BottomRowMax));bottomMaxRowY=ones(size(bottomMaxColX)).*height(DeathCountMat);
%             left=[leftMaxRowY leftMaxColX];right=[rightMaxRowY
%             rightMaxColX];top=[topMaxColX
%             topMaxRowY];bottom=[bottomMaxColX bottomMaxRowY];
% 
%             XL=(reproAgs.DeathCoords_1==leftMaxColX(1) &
%             reproAgs.DeathCoords_2==leftMaxRowY(1));XR=(reproAgs.DeathCoords_1==rightMaxColX(1)
%             & reproAgs.DeathCoords_2==rightMaxRowY(1));
%             XT=(reproAgs.DeathCoords_1==topMaxColX(1) &
%             reproAgs.DeathCoords_2==topMaxRowY(1));XB=(reproAgs.DeathCoords_1==bottomMaxColX(1)
%             & reproAgs.DeathCoords_2==bottomMaxRowY(1));
%             leftAgs=reproAgs(XL,:);rightAgs=reproAgs(XR,:);topAgs=reproAgs(XT,:);botAgs=reproAgs(XB,:);
%             BirthCoordsForLineSegments=[leftAgs.BirthCoords_1
%             leftAgs.BirthCoords_2;rightAgs.BirthCoords_1
%             rightAgs.BirthCoords_2;topAgs.BirthCoords_1
%             topAgs.BirthCoords_2;botAgs.BirthCoords_1
%             botAgs.BirthCoords_2];
%             DeathCoordsForLineSegments=[leftAgs.DeathCoords_1
%             leftAgs.DeathCoords_2;rightAgs.DeathCoords_1
%             rightAgs.DeathCoords_2;topAgs.DeathCoords_1
%             topAgs.DeathCoords_2;botAgs.DeathCoords_1
%             botAgs.DeathCoords_2]; [plotx,ploty]=find(BirthCountMat>0);
%             plotz=zeros(size(plotx)); for i=1:height(plotx)
%                 plotz(i,1)=BirthCountMat(plotx(i),ploty(i));
%             end
% 
%             plotBirthCoords=[plotx ploty plotz];
%             plotBirthCoords=sortrows(plotBirthCoords,3,'ascend');
%             [za,zb,zc]=unique(plotBirthCoords(:,3)); lengthz=height(za);
%             plotBirthVecColors=zeros(size(plotBirthCoords));
% 
%             [plotxx,plotyy]=find(DeathCountMat>0);
%             plotzz=zeros(size(plotxx)); for ii=1:height(plotxx)
%                 plotzz(ii,1)=DeathCountMat(plotxx(ii),plotyy(ii));
%             end
% 
%             plotDeathCoords=[plotxx plotyy plotzz];
%             plotDeathCoords=sortrows(plotDeathCoords,3,'ascend');
%             [zza,zzb,zzc]=unique(plotDeathCoords(:,3));
%             lengthzz=height(zza);
%             plotDeathVecColors=zeros(size(plotDeathCoords));
% 
%             colors_BirthBiVarDistz =
%             [linspace(BirthBiVarDistBotCol(1),BirthBiVarDistTopCol(1),lengthz)',...
%                 linspace(BirthBiVarDistBotCol(2),BirthBiVarDistTopCol(2),lengthz)',...
%                 linspace(BirthBiVarDistBotCol(3),BirthBiVarDistTopCol(3),lengthz)'];
% 
%             colors_DeathBiVarDistz =
%             [linspace(DeathBiVarDistBotCol(1),DeathBiVarDistTopCol(1),lengthzz)',...
%                 linspace(DeathBiVarDistBotCol(2),DeathBiVarDistTopCol(2),lengthzz)',...
%                 linspace(DeathBiVarDistBotCol(3),DeathBiVarDistTopCol(3),lengthzz)'];
% 
%             for colorCount=1:height(plotBirthCoords)
%                 plotBirthVecColors(colorCount,:)=colors_BirthBiVarDistz(zc(colorCount),1:3);
%             end
%             plotBirthVecC=[min(plotBirthVecColors):((max(plotBirthVecColors)
%             - min(plotBirthVecColors)) \ 10):max(plotBirthVecColors);];
%             for colorCount=1:height(plotDeathCoords)
%                 plotDeathVecColors(colorCount,:)=colors_DeathBiVarDistz(zzc(colorCount),:);
%             end
%             plotDeathVecC=[min(plotDeathVecColors):((max(plotDeathVecColors)
%             - min(plotDeathVecColors)) \ 10):max(plotDeathVecColors)];
% 
%             %% Size of vectors of interest.  Currently set to successful
%             births (length) and #locations (length2)
%             %% **************************************************** %%
%             %% **************************************************** %%
%             maxTime=max(reproAgs.DeathTime);
%             length=size(reproAgs.BirthCoords_2,1);
%             AHold=[reproAgs.BirthCoords_1 reproAgs.BirthCoords_2];
%             B=unique(AHold,'rows'); binsYRows=max(B(:,1))-min(B(:,1));
%             binsXCols=max(B(:,2))-min(B(:,2)); length2=size(B,1); %%
%             Color vectors for scatter/hist work colors_Bound =
%             [linspace(red(1),pink(1),length)',
%             linspace(red(2),pink(2),length)',...
%                 linspace(red(3),pink(3),length)'];
%             colors_SpawnLoc = [linspace(orange(1),orange(1),length)',...
%                 linspace(orange(2),orange(2),length)',...
%                 linspace(orange(3),orange(3),length)'];
%             colors_SpawnLocZ =
%             [linspace(orange(1),orange(1),lengthz)',...
%                 linspace(orange(2),orange(2),lengthz)',...
%                 linspace(orange(3),orange(3),lengthz)'];
%             colors_BirthBiVarDist =
%             [linspace(BirthBiVarDistBotCol(1),BirthBiVarDistTopCol(1),length2)',...
%                 linspace(BirthBiVarDistBotCol(2),BirthBiVarDistTopCol(2),length2)',...
%                 linspace(BirthBiVarDistBotCol(3),BirthBiVarDistTopCol(3),length2)'];
% 
%             a=max(max(DeathCountMat));
%             TotalPopSize=sum(sum(DeathCountMat));
%             PercentBirthsOfTotal=roundn((100*length/TotalPopSize),-2);
% 
%             linSpacePercentInterval=roundn(a/(length*10),-3);%
%             linSpaceEndPercent=roundn(a/(length),-4);
%             linSpaceLabels=100*(0:linSpacePercentInterval:linSpaceEndPercent);
% 
%             linSpaceEnd=roundn(a,(floor(log10(a+1))-1));%
% 
%             %% **************************************************** %%
%             %% **************************************************** %% %%
%             Color vectors for scatter/hist work
% 
%             %% Graph generation for 3-d histogram evaluation
% 
% 
%             if ~isfile(figSaveName)
%                 reproAgsFig=figure('WindowState','maximized','Name',subtitles{tableCount},'NumberTitle','off');
%                 ax1=axes(); ax1.Colormap = plotBirthVecColors;
%                 ax1Lims(1)=min(plotz);ax1Lims(2)= max(plotz); %
%                 axesreproAgsFig = axes('Parent',reproAgsFig); % Set up
%                 figure properties: % Enlarge figure to full screen.
%                 set(reproAgsFig, 'Units', 'Normalized',
%                 'OuterPosition',[-0.0046875 0.037962962962963 1.009375
%                 0.97037037037037]); % Get rid of tool bar and pulldown
%                 menus that are along top of figure.
%                 set(reproAgsFig,'Color','w'); hold on grid on %% plot
%                 landscape and river %         contH.Parent=reproAgsFig;
%                 [rivRowY,rivColX]=find(landGrid==1);
%                 [LandCont,contH]=contour(altLandGrid,'showtext','on','LineColor',[0
%                 0 0]); contH.LineWidth = 0.5; %
%                 clabel(LandCont,contH,'FontSize',10,'color','k','FontSmoothing','on','LabelSpacing',200)
%                 rivScat=scatter(rivColX,rivRowY,86,'MarkerEdgeColor',myBlue,'MarkerFaceColor',myBlue);
% 
%                 %         %% plot spawn locations %         if
%                 singleHomoSwitch==1 %
%                 SpawnLocScat1=scatter(reproAgs.BirthCoords_1,reproAgs.BirthCoords_2,86,myBlue,'filled','p');
%                 %         elseif singleHomoSwitch==2 %
%                 SpawnLocScat1=scatter(reproAgs.BirthCoords_1,reproAgs.BirthCoords_2,86,myBlue,'filled','p');
%                 %         end
% 
%                 %%  3d histo %
%                 SpawnLocScat2=scatter(MatrixOfInterest(:,4),MatrixOfInterest(:,5),168,'y','filled','p');
%                 %         PopDistHist.Parent=reproAgsFig; %
%                 the following line skip the name of the previous plot
%                 from the legend %
%                 PopDistHist.Annotation.LegendInformation.IconDisplayStyle
%                 = 'off';
%                 birthPlot=scatter3(plotBirthCoords(:,2),plotBirthCoords(:,1),ones(height(plotBirthCoords(:,1)),1),24,plotBirthVecColors,'filled');
% 
%                 % Add a 2nd invisible axis to host the 2nd colormap and
%                 colorbar % HandleVisibility is set to off to avoid
%                 accidentally accessing those axes. ax2 =
%                 axes('Visible','off','HandleVisibility','off');
%                 ax2Lims(1)=min(plotzz);ax2Lims(2)=max(plotzz); % Define
%                 the colormap for the quiver data cmap =
%                 plotDeathVecColors; ax2.Colormap = cmap;
%                 deathPlot=scatter3(plotDeathCoords(:,2),plotDeathCoords(:,1),plotDeathCoords(:,3),24,plotDeathVecColors,'filled');
%                 for arrowCount=1:height(BirthCoordsForLineSegments)
%                     plot_arrow(BirthCoordsForLineSegments(arrowCount,1),BirthCoordsForLineSegments(arrowCount,2),...
%                         DeathCoordsForLineSegments(arrowCount,1),DeathCoordsForLineSegments(arrowCount,2),'linewidth',1.1,'color',[0.5
%                         0.5 0.5],'facecolor',[0.5 0.5 0.5],...
%                         'headwidth',0.05,'headheight',0.05);
%                     plot(BirthCoordsForLineSegments(arrowCount,1),BirthCoordsForLineSegments(arrowCount,2),'MarkerSize',8,'Marker','o','Color','k','MarkerFaceColor','k');
%                 end
%                 d1=datatip(deathPlot,leftMaxColX,leftMaxRowY,'Location','northwest');
%                 d2=datatip(deathPlot,rightMaxColX,rightMaxRowY,'Location','northeast');
%                 d3=datatip(deathPlot,topMaxColX(1),topMaxRowY(1),'Location','southeast');%,'SnapToDataVertex','off'
%                 %
%                 datatip(deathPlot,bottomMaxColX(1),bottomMaxRowY(1),'Location','northeast')
%                 %
%                 PopDistHist=histogram2(reproAgs.BirthCoords_1,reproAgs.BirthCoords_2,[binsYRows
%                 binsXCols],'BinMethod','integers','DisplayStyle','bar3','FaceColor','flat');
%                 %% Figure out shadow on back panel %         shading
%                 interp %         shadowplot x axis equal xlim([0,976])
%                 ylim([0,834]) zlim([0,100]) pbaspect([1 1 3]) cb(1) =
%                 colorbar(ax1); ax1Pos = ax1.OuterPosition; cb(2) =
%                 colorbar(ax2); % Split the vertical space between the 2
%                 CBs. cb(2).Position(4) = cb(2).Position(4)*.48;
%                 cb(1).Position(4) = cb(1).Position(4)*.48;
%                 cb(1).Position(2) = sum(cb(2).Position([2,4]))+.04;
%                 cb(2).Position([1,3]) = cb(1).Position([1,3]);
%                 ax1.OuterPosition = ax1Pos; caxis(ax1,ax1Lims);
%                 caxis(ax2,ax2Lims); ylabel(cb(1),'Escapee Birth Counts');
%                 ylabel(cb(2),'Escapee Boundary Counts');
%                 lgd=legend('Elevation Contour Isolines (meters above sea
%                 level).','The Coweeta river network.','Escapee Spawning
%                 Distribution.','Escape Location Concentrations'); %
%                 lgd.Parent=reproAgsFig; %         PopC=colorbar; %
%                 PopC.Parent=reproAgsFig; %         w = PopC.LineWidth; %
%                 PopC.LineWidth = 1.5; %         PopC.Ticks =
%                 linspace(min(za),max(za),10); %Create 8 ticks from zero
%                 to 1 %         PopC.TickLabels = num2cell(linSpaceLabels)
%                 ; %         PopC.Label.String = 'Agent Count'; %
%                 pos = get(PopC,'Position'); %         view([-19.359375
%                 64.8481651376147]);
% 
%                 %         titleName=strcat({[titleTopLineFrontPiece, '
%                 with ~',num2str(PercentBirthsOfTotal) ,'% of the
%                 population reproducing.'] %             [num2str(length)
%                 ' successful agents out of a population of '
%                 num2str(TotalPopSize) '.  Longest lifespan: '
%                 num2str(maxTime) ' seconds.'] %             ['Elevation:
%                 ' PhysFactorNames{TChoice1} '. River: '
%                 PhysFactorNames{TChoice2} '.'] %
%                 ['Environment Lethality: ' BioFactorNames{BioChoice1} '.
%                 Chance of Reproduction: ' BioFactorNames{BioChoice2} '.']
%                 %             });
% 
%                 titleName=GraphTitle;
% 
%                 %         lgd.Location='northwest';
%                 set(lgd,'Position',[0.0236342176258992 0.821358616195852
%                 0.213932295975586 0.0928151729779366]); %
%                 lgd.Orientation='horizontal';
% 
%                 %
%                 title(reproAgsFig,'txt',titleName,'Position',[443.7323,862.1461,521.3866,26.2333])
%                 title(titleName) %
%                 set(title,'Position',[443.7323,862.1461,521.3866,26.2333])
%                 xlabel('Lattitude (meters)') ylabel('Longitude (meters)')
%                 %
%                 ylabel.orientation='vertical'; zlabel('Number of
%                 reproducing agents') %
%                 ax1.DataTipTemplate.DataTipRows(1).Label = ''; %
%                 ax1.DataTipTemplate.DataTipRows(2).Label = ''; %
%                 ax1.DataTipTemplate.DataTipRows(3).Label = 'Agent Count';
%                 %           s.DataTipTemplate.DataTipRows(2).Label =
%                 'Fatalities'; hold off
%                 savefig(reproAgsFig,figSaveName,'compact');
%                 saveas(reproAgsFig,jpgSaveName,'jpg'); close(reproAgsFig)
%             else end
%         else end
    end
    %% Maybe Bivariate plot for later
    %         x=reproAgs.BirthCoords_1;y=reproAgs.BirthCoords_2;
    %         hist3([x,y],[binsYRows binsXCols])
    % xlabel('Longitude') ylabel('Latitude') hold on
    % PopDistHist3=hist3([reproAgs.BirthCoords_1,reproAgs.BirthCoords_2],[binsYRows
    % binsXCols]); N_pcolor = PopDistHist3';
    % N_pcolor(size(N_pcolor,1)+1,size(N_pcolor,2)+1) = 0; xl =
    % linspace(min(x),max(x),size(N_pcolor,2)); % Columns of N_pcolor yl =
    % linspace(min(y),max(y),size(N_pcolor,1)); % Rows of N_pcolor % h =
    % pcolor(xl,yl,N_pcolor); colormap('hot') % Change color scheme
    % colorbar % Display colorbar h.ZData =
    % -50-max(N_pcolor(:))*ones(size(N_pcolor)); ax = gca;
    % ax.ZTick(ax.ZTick < 0) = []; title('Seamount Location Histogram and
    % Intensity Map');