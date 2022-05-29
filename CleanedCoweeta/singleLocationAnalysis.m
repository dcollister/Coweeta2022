function singleLocationAnalysis(landscapeName,imageStorLoc,A,plotType,centerX,centerY,sourceR,catchInR,catchOutR,parameterValues)

[ETstr, RTstr, PDstr, PBstr]=paramStrGen(parameterValues);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Plot landscape and nbhds %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('LandandAltGrids.mat','altLandGrid','landGrid');

resultsStructure.RunType='Homogeneous';
resultsStructure.SourceCenter=[centerX centerY];
resultsStructure.SourceR=sourceR;
resultsStructure.InnerCatchDistance=catchInR;
resultsStructure.OuterCatchDistance=catchOutR;
resultsStructure.ParameterValues=parameterValues;

A=addElevations(A,altLandGrid);

[A,sourceAgsMat,sourceAllAgsIDs, SourceBoundIDs, SourceEnviDeathIDs, SourceReproIDs,sourceIDs]=...
    SourceAgents(centerX,centerY,A,sourceR,catchInR,catchOutR);
[externalSupportAgsMat,supportAgsIDs,nonSupportAgsIds]=...
    SupportAgents(A,sourceR,catchInR,catchOutR);
ReproMat=sourceAgsMat;
[rivCoords,rivNodesInReg,clusters]=...
    FindRiverAreas(altLandGrid,landGrid,centerX,centerY,sourceR,catchInR,catchOutR,ReproMat);

colors={'#3cb44b','#ffe119','#4363d8','#f58231','#f032e6','#bfef45','#fabed4','#469990','#dcbeff','#9A6324','#fffac8','#a9a9a9','#e6194B','#000075','#42d4f4'};
for colorCount=1:size(clusters,2)
    clusters{2,colorCount}=colors{colorCount};
end

create1d2dSheetReport(A,parameterValues,imageStorLoc,landscapeName)
Daniel2DImaging
catchmentLandscapeFigure=struct;%create struct to hold all handles
landscapeNameWithRadius=strcat(landscapeName,'Radius250mIndividualCatchmentsMeanHeights');

%% Future load vs generate place
% if ~isfile([landscapeNameWithRadius '.fig'])
s = get(0, 'ScreenSize');
for figCount=1:2
    labelsCount=1;handlesCount=1;
    labels={};handles={};
    catchmentLandscapeFigure(figCount).f=figure('WindowState','maximized','Name','250Radius','Position', [1 1 s(3)-10 s(4)-10]);%,'Position', [10 10 s(3)-10 s(4)-10]
    clf(catchmentLandscapeFigure(figCount).f)%create blank figure
    % figure('Position', [0 0 s(3) s(4)]);
    catchmentLandscapeFigure(figCount).ax=axes('Parent',catchmentLandscapeFigure(figCount).f,'NextPlot','add');

    hold on
    [baseCow,labels,labelsCount]=plotCoweetaLandscapeFig(catchmentLandscapeFigure(figCount).ax,labels,labelsCount);
    % catchmentLandscapeFigure(2).f=openfig([landscapeName '.fig']);

    sourceHandle2=plotSource(sourceR,centerX,centerY,'b-',120,catchmentLandscapeFigure(figCount).ax,'off');
    sourceHandle2.MarkerFaceColor='b';
    handles{handlesCount}=sourceHandle2;handlesCount=handlesCount+1;
    labels{labelsCount}='Catchment Annulus';labelsCount=labelsCount+1;
    centerswitch=1;
    [handle,centerswitch]=plotCircle((catchInR+catchOutR)/2,centerX,centerY,'-',2,catchmentLandscapeFigure(figCount).ax,'on',centerswitch);
    handles{handlesCount}=handle;handlesCount=handlesCount+1;
    labels{labelsCount}=strcat('Catchment mean radius: '," ",num2str((catchInR+catchOutR)/2),'m from source.');labelsCount=labelsCount+1;

    innerEdge=plotCircle(catchInR,centerX,centerY,'r-',3,catchmentLandscapeFigure(figCount).ax,'on',centerswitch);

    outerEdge=plotCircle(catchOutR,centerX,centerY,'r-',3,catchmentLandscapeFigure(figCount).ax,'on',centerswitch);
    handles{handlesCount}=outerEdge;handlesCount=handlesCount+1;
    labels{labelsCount}=strcat('Width of catchment annulus: '," ",num2str((catchOutR-catchInR)),'m.');labelsCount=labelsCount+1;

    %% Plotting all nbhds where annulus intersects river together
    % if nbhdSwitch=1 if plotType==1
    % rivPlot=scatter(rivNodesInReg(:,1),rivNodesInReg(:,2),70,'k','filled','o','Parent',catchmentLandscapeFigure.ax);
    % handles{rivPlot}=outerEdge;handlesCount=handlesCount+1;
    % labels{labelsCount}=strcat('Nbhd Mean Height:
    % ',num2str(3));labelsCount=labelsCount+1;catchmentLandscapeFigure
    %
    % elseif plotType==2
    % rivPlot=scatter3(rivNodesInReg(:,1),rivNodesInReg(:,2),0.5*ones(size(rivNodesInReg,1),1),70,'square','k','Parent',catchmentLandscapeFigure.ax);
    % handles{rivPlot}=outerEdge;handlesCount=handlesCount+1;
    % labels{labelsCount}='Coweeta Landscape';labelsCount=labelsCount+1;
    %
    % elseif plotType==3
    % rivPlot=scatter3(rivNodesInReg(:,1),rivNodesInReg(:,2),rivNodesInReg(:,3),30,'filled','MarkerFaceColor','#FF007F');%pink
    % inner color handles{rivPlot}=outerEdge;handlesCount=handlesCount+1;
    % labels{labelsCount}='Coweeta Landscape';labelsCount=labelsCount+1;
    %
    % end
    theta=linspace(0,2*pi,360);
    dim = [.2 .5 .3 .3];
    %% Plotting Nbhds by individual cluster intersecting with river
    for nbhdCount=1:size(clusters,2)
        rivNodesInRegByNeighbrhd=clusters{1,nbhdCount};
        xNBHD=round(mean(rivNodesInRegByNeighbrhd(:,1)));
        yNBHD=round(mean(rivNodesInRegByNeighbrhd(:,2)));
        heightNbhd=round(mean(rivNodesInRegByNeighbrhd(:,3)));
        if plotType==1
            scatter(rivNodesInRegByNeighbrhd(:,1),rivNodesInRegByNeighbrhd(:,2),50,'filled','MarkerFaceColor','#800000','Parent',catchmentLandscapeFigure(figCount).ax,'HandleVisibility','off');

            catchHandles{nbhdCount}=scatter(rivNodesInRegByNeighbrhd(:,1),rivNodesInRegByNeighbrhd(:,2),30,'filled','MarkerFaceColor',colors{nbhdCount},'Parent',catchmentLandscapeFigure(figCount).ax);
            handles{handlesCount}=catchHandles{nbhdCount};handlesCount=handlesCount+1;
            labels{labelsCount}=strcat('Nbhd ', num2str(nbhdCount), ' mean height: '," ",num2str(heightNbhd),'m. Location: (', num2str(xNBHD), ', ', num2str(yNBHD), ')');labelsCount=labelsCount+1;
            % fill(xNBHD + 10*cos(theta)-25,yNBHD + 10*sin(theta)+25,'white','EdgeColor','black','FaceColor','white','HandleVisibility','off');
            % text(xNBHD-20,yNBHD+25,num2str(labelsCount));

        elseif plotType==2
            scatter3(rivNodesInRegByNeighbrhd(:,1),rivNodesInRegByNeighbrhd(:,2),ones(size(rivNodesInRegByNeighbrhd,1),1),50,'filled','MarkerFaceColor','#800000','Parent',catchmentLandscapeFigure(figCount).ax,'HandleVisibility','off');

            catchHandles{nbhdCount}=scatter3(rivNodesInRegByNeighbrhd(:,1),rivNodesInRegByNeighbrhd(:,2),ones(size(rivNodesInRegByNeighbrhd,1),1),30,'filled','MarkerFaceColor',colors{nbhdCount},'Parent',catchmentLandscapeFigure(figCount).ax);
            handles{handlesCount}=catchHandles{nbhdCount};handlesCount=handlesCount+1;
            labels{labelsCount}=strcat('Nbhd ', num2str(nbhdCount), ' mean height: '," ",num2str(heightNbhd),'m. Location: (', num2str(xNBHD), ', ', num2str(yNBHD), ')');labelsCount=labelsCount+1;

        elseif plotType==3
            scatter3(rivNodesInRegByNeighbrhd(:,1),rivNodesInRegByNeighbrhd(:,2),rivNodesInRegByNeighbrhd(:,3),50,'filled','MarkerFaceColor','#800000','Parent',catchmentLandscapeFigure(figCount).ax,'HandleVisibility','off');

            catchHandles{nbhdCount}=scatter3(rivNodesInRegByNeighbrhd(:,1),rivNodesInRegByNeighbrhd(:,2),rivNodesInRegByNeighbrhd(:,3),30,'filled','MarkerFaceColor',colors{nbhdCount},'Parent',catchmentLandscapeFigure(figCount).ax);
            handles{rivPlot}=catchHandles{nbhdCount};handlesCount=handlesCount+1;
            labels{labelsCount}=strcat('Nbhd '," ", num2str(nbhdCount), ' mean height: '," ",num2str(heightNbhd),'m. Location: (', num2str(xNBHD), ', ', num2str(yNBHD), ')');labelsCount=labelsCount+1;
        end
    end
    %% Scatter the source ags
    if figCount==1
        SourceEnviDeathIDVec=SourceEnviDeathIDs{1};
        SourceReproIDVec=SourceReproIDs{1};
        SourceBoundIDVec=SourceBoundIDs;
        %% Plot Enviro Agents
        if SourceEnviDeathIDVec>0
            sourceAgDeathScat=scatter3(sourceAgsMat.DeathCoords_1(SourceEnviDeathIDVec),sourceAgsMat.DeathCoords_2(SourceEnviDeathIDVec),2*ones(height(SourceEnviDeathIDVec),1),60,'filled','s','MarkerEdgeColor','k','MarkerFaceColor','w',markerfacealpha=0.5);
            sourceAgDeathScat.Parent=catchmentLandscapeFigure(figCount).ax;
            labels{labelsCount}=strcat('Unsuccessful Reproducing Agent Death-Locations from Source NBHD');labelsCount=labelsCount+1;
        end
        %% Plot Reproducing Agents
        if SourceReproIDVec>0
            sourceReproAgDeathScat=scatter3(sourceAgsMat.DeathCoords_1(SourceReproIDVec),sourceAgsMat.DeathCoords_2(SourceReproIDVec),2*ones(height(SourceReproIDVec),1),60,'filled','d','MarkerEdgeColor','k','MarkerFaceColor','w');
            sourceReproAgDeathScat.Parent=catchmentLandscapeFigure(figCount).ax;
            labels{labelsCount}=strcat('Reproducing Agents Death-Locations from Source NBHD');labelsCount=labelsCount+1;
        end
        %% Plot Boundary Agents
        if SourceBoundIDVec>0
            sourceBoundAgDeathScat=scatter3(sourceAgsMat.DeathCoords_1(SourceBoundIDVec),sourceAgsMat.DeathCoords_2(SourceBoundIDVec),2*ones(height(SourceBoundIDVec),1),60,'filled','o','MarkerEdgeColor','k','MarkerFaceColor','w');
            sourceBoundAgDeathScat.Parent=catchmentLandscapeFigure(figCount).ax;
            labels{labelsCount}=strcat('Boundary Agents Death-Locations from Source NBHD');labelsCount=labelsCount+1;
        end
        hold off
        hold on
        sourceNodeForPlot=scatter3(centerX,centerY,3,80,'filled','p','MarkerFaceColor','red','MarkerEdgeColor','blue','DisplayName',['Source Center',newline,'Count = 2',newline,'Source = 10']);
        %     text(centerX,centerY,)
        sourceNodeForPlot.Parent=catchmentLandscapeFigure(figCount).ax;
        CenterLabelStr=strcat('Source Center');
        B=sourceAgsMat(SourceReproIDs{1},:);
        C=sourceAgsMat(SourceReproIDs{4},:);
        boundAgs=sourceAgsMat(SourceBoundIDs,1:width(sourceAgsMat));

        minDeathDisplaceSourceRepro=min(B.deathdiffX);
        meanDeathDisplaceSourceRepro=mean(B.deathdiffX);
        maxDeathDisplaceSourceRepro=max(B.deathdiffX);

        meanMaxReproDist=mean(B.RadialMax);
        maxMaxReproDist=max(B.RadialMax);

        minCatchReproTime=min(C.DeathTime)/60;
        meanCatchReproTime=mean(C.DeathTime)/60;
        maxCatchReproTime=max(C.DeathTime)/60;

        minBoundTime=min(boundAgs.RadialMaxTime)/60;
        meanBoundTime=mean(boundAgs.RadialMaxTime)/60;
        maxBoundTime=max(boundAgs.RadialMaxTime)/60;

        resultsStructure.minDeathDisplaceSourceRepro=minDeathDisplaceSourceRepro;
        resultsStructure.meanDeathDisplaceSourceRepro=meanDeathDisplaceSourceRepro;
        resultsStructure.maxDeathDisplaceSourceRepro=maxDeathDisplaceSourceRepro;

        resultsStructure.minTimeSourceCatchRepro=minCatchReproTime;
        resultsStructure.meanTimeSourceCatchRepro=meanCatchReproTime;
        resultsStructure.maxTimeSourceCatchRepro=maxCatchReproTime;

        resultsStructure.meanMaxDisplaceSourceRepro=meanMaxReproDist;
        resultsStructure.maxMaxDisplaceSourceRepro=maxMaxReproDist;
        
        resultsStructure.minTimeSourceBound=minBoundTime;
        resultsStructure.meanTimeSourceBound=meanBoundTime;
        resultsStructure.maxTimeSourceBound=maxBoundTime;


        labels{labelsCount}=['Source Center',newline,'Successful Reproduction From Source Count = ' num2str(height(SourceReproIDVec)),' or ',num2str(100*height(SourceReproIDVec)/height(sourceAgsMat)),'% of source population.',newline,...
            'Successful Colonization From Source Count = ' num2str(height(C)),' or ',num2str(100*height(C)/height(B)),'% of source reproducers.',newline,...
            'Mean Distance for Reproduction = ',num2str(meanDeathDisplaceSourceRepro), newline,...
            'Mean Maximum Distance = ',num2str(meanMaxReproDist),newline,...
            'First time to Catchment zones = ', num2str(minCatchReproTime), ' minutes.',newline...
            'Mean time to Catchment zones = ', num2str(meanCatchReproTime), ' minutes.',newline,...
            'Max time to Catchment zones = ', num2str(maxCatchReproTime), ' minutes.',newline,...
            'First time to Boundary = ', num2str(minBoundTime), ' minutes.',newline,...
            'Mean time to Boundary = ', num2str(meanBoundTime), ' minutes.',newline,...
            'First time to Boundary = ', num2str(maxBoundTime), ' minutes.'];
        labelsCount=labelsCount+1;
        hold off
        %% Scatter the support ags
    elseif figCount==2
        supportReproIDVec=supportAgsIDs{1};externalBoundIdVec=nonSupportAgsIds{1};
        %% Plot Reproducing Agents
        if supportReproIDVec>0
            supportReproAgsBirthScat=scatter3(A.BirthCoords_1(supportReproIDVec),A.BirthCoords_2(supportReproIDVec),2*ones(height(supportReproIDVec),1),70,'filled','d','MarkerEdgeColor','r','MarkerFaceColor','y');
            supportReproAgsBirthScat.Parent=catchmentLandscapeFigure(figCount).ax;
            labels{labelsCount}=strcat('Birth-Locations of Contributing Agents to Source Neighborhood');labelsCount=labelsCount+1;
        end
        %% Plot Boundary Agents
        if externalBoundIdVec>0
            sourceBoundAgDeathScat=scatter3(A.DeathCoords_1(externalBoundIdVec),A.DeathCoords_2(externalBoundIdVec),2*ones(height(externalBoundIdVec),1),60,'filled','o','MarkerEdgeColor','k','MarkerFaceColor','y');
            sourceBoundAgDeathScat.Parent=catchmentLandscapeFigure(figCount).ax;
            labels{labelsCount}=strcat('Boundary Agents Death-Locations Emerging from Outside Source NBHD Escaping to Boundary');labelsCount=labelsCount+1;
        end
        hold off
        hold on
        sourceNodeForPlot=scatter3(centerX,centerY,3,80,'filled','p','MarkerFaceColor','red','MarkerEdgeColor','blue','DisplayName',['Source Center',newline,'Count = 2',newline,'Source = 10']);
        %     text(centerX,centerY,)
        sourceNodeForPlot.Parent=catchmentLandscapeFigure(figCount).ax;
        CenterLabelStr=strcat('Source Center');
        B=externalSupportAgsMat;
        minReproDist=min(externalSupportAgsMat.deathdiffX);
        meanReproDist=mean(externalSupportAgsMat.deathdiffX);
        maxReproDist=max(externalSupportAgsMat.deathdiffX);

        meanMaxReproDist=mean(externalSupportAgsMat.RadialMax);
        maxMaxReproDist=max(externalSupportAgsMat.RadialMax);

        minCatchSupportReproTime=min(externalSupportAgsMat.DeathTime)/60;
        meanCatchSupportReproTime=mean(externalSupportAgsMat.DeathTime)/60;
        maxCatchSupportReproTime=max(B.DeathTime)/60;

        boundTimes=A(externalBoundIdVec,3);
        minBoundTime=min(boundTimes{:,1})/60;
        meanBoundTime=mean(boundTimes{:,1})/60;
        maxBoundTime=max(boundTimes{:,1})/60;
        
        resultsStructure.minDeathDisplaceSupport=minReproDist;
        resultsStructure.meanDeathDisplaceSupport=meanReproDist;
        resultsStructure.maxDeathDisplaceSupport=maxReproDist;
        resultsStructure.minDeathTimeSupport=minCatchSupportReproTime;
        resultsStructure.meanDeathTimeSupport=meanCatchSupportReproTime;
        resultsStructure.maxDeathTimeSupport=maxCatchSupportReproTime;
        resultsStructure.meanMaxDistSupport=meanMaxReproDist;
        resultsStructure.minBoundTimeExternal=minBoundTime;
        resultsStructure.meanBoundTimeExternal=meanBoundTime;
        resultsStructure.maxBoundTimeExternal=maxBoundTime;


        labels{labelsCount}=['Source Center',newline,'Successful Invasion Count = ' num2str(height(externalSupportAgsMat)),' or ',num2str(100*height(externalSupportAgsMat)/height(A)),'% of total population.',newline,...
            'Successful Invasion Count from Catchment Zone = ' num2str(height(supportAgsIDs{3})),' or ',num2str(100*height(supportAgsIDs{3})/height(externalSupportAgsMat)),'% of all support agents.',newline,...
            'Mean Distance Traveled to Source Location = ',num2str(meanReproDist),newline,...
            'Mean Maximum Distance = ',num2str(meanMaxReproDist),newline,...
            'First time to Source = ', num2str(minCatchSupportReproTime), ' minutes.',newline...
            'Mean time to Source = ', num2str(meanCatchSupportReproTime), ' minutes.',newline,...
            'Max time to Source = ', num2str(maxCatchSupportReproTime), ' minutes.',newline,...
            'First time to Boundary = ', num2str(minBoundTime), ' minutes.',newline,...
            'Mean time to Boundary = ', num2str(meanBoundTime), ' minutes.',newline,...
            'First time to Boundary = ', num2str(maxBoundTime), ' minutes.'];
        hold off
    end

    % alpha(sourceAgDeathScat,.5);
    % alpha(supportAgsBirthScat,.5);


    Legend1=legend(catchmentLandscapeFigure(figCount).ax,labels,'Location','westoutside','FontSize',14,'Color',[.5,1,1]);
    title(catchmentLandscapeFigure(figCount).ax,{'Coweeta with source placed at intersection of branches 5, 6 and 14.',...
        'Catchments placed at all river neighborhoods 240-260 meters from center of source nbhd.',...
        [ETstr, RTstr, PDstr, PBstr]},...
        'fontsize',12,'Editing','on');
    
    LandScapeBaseFig=catchmentLandscapeFigure(figCount).f;
    if figCount==1

        if ~isfile([imageStorLoc landscapeNameWithRadius '_ET:' num2str(parameterValues(1)) '_RT:' num2str(parameterValues(2)) '_PD:' num2str(parameterValues(3)) '_Repro:' num2str(parameterValues(4)) 'SourceAgs.fig'])
            savefig(LandScapeBaseFig,[imageStorLoc landscapeNameWithRadius '_ET_' num2str(parameterValues(1)) '_RT_' num2str(parameterValues(2)) '_PD_' num2str(parameterValues(3)) '_Repro_' num2str(parameterValues(4)) 'SourceAgs.fig'],'compact');
            saveas(LandScapeBaseFig,[imageStorLoc landscapeNameWithRadius '_ET_' num2str(parameterValues(1)) '_RT_' num2str(parameterValues(2)) '_PD_' num2str(parameterValues(3)) '_Repro_' num2str(parameterValues(4)) 'SourceAgs.jpg']);
        end
        close(LandScapeBaseFig);
    elseif figCount==2

        if ~isfile([imageStorLoc landscapeNameWithRadius '_ET_' num2str(parameterValues(1)) '_RT_' num2str(parameterValues(2)) '_PD_' num2str(parameterValues(3)) '_Repro_' num2str(parameterValues(4)) 'SupportAgs.fig'])
            savefig(LandScapeBaseFig,[imageStorLoc landscapeNameWithRadius '_ET_' num2str(parameterValues(1)) '_RT_' num2str(parameterValues(2)) '_PD_' num2str(parameterValues(3)) '_Repro_' num2str(parameterValues(4)) 'SupportAgs.fig'],'compact');
            saveas(LandScapeBaseFig,[imageStorLoc landscapeNameWithRadius '_ET_' num2str(parameterValues(1)) '_RT_' num2str(parameterValues(2)) '_PD_' num2str(parameterValues(3)) '_Repro_' num2str(parameterValues(4)) 'SupportAgs.jpg']);
        end
        close(LandScapeBaseFig);
        %     LandScapeBaseFig=openfig(landscapeNameWithRadius);
        %     catchmentLandscapeFigure(1).f=LandScapeBaseFig;
        %     catchmentLandscapeFigure(1).ax=CurrentAxes;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Cull and plot agents of note %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% s = get(0, 'ScreenSize');
% agentsFigures=figure('WindowState','maximized','Name','250RadiusAgentsGraph','Position', [0 0 s(3) s(4)]);
% clf(agentsFigures);
% agentsFigures.CurrentAxes=axes('Parent',agentsFigures,'NextPlot','add');
% % agentsFigures.ax=axes('Parent',agentsFigures,'NextPlot','add');
% labelsCount=1;handlesCount=1;
% labels={};handles={};
countAgents(A,sourceAgsIDs,supportAgsIDs,clusters,landGrid,centerX,centerY,catchHandles)


h = gca(); % Handle to the main axes
% Copy objects to second axes
hc = copyobj(h, axes,'Position', h.Position, 'Visible', 'off');
% Replace all x values with NaN so the line doesn't appear
hc.XData = nan(size(hc.XData));
% Create right axis legend
legend(hc, 'Location', 'southeastoutside')

Legend2=legend(secondax,'Location','southeastoutside');

secondax
hold on

%% 3d Graphing by table var names!!
% scatter3(singAgsfromCenterNBHD,'DeathCoords_2','DeathCoords_1','deathdiffX');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Important Code Holder for
%% 1) Color Labeling Nbhds Code to color "testval" by elevation  colormap if desired %%
% testvalColorTriple=axesLandScapeFig.Colormap(round((testval-axesLandScapeFig.CLim(1))*256/(axesLandScapeFig.CLim(2)-axesLandScapeFig.CLim(1))),:)

%% 2) scat(3) tbls directly as of 2021b by var name!!! %%%%
% tbl = readtable('patients.xls');
% scatter3(tbl,'Systolic','Diastolic','Weight');
% scatter3(tbl,{'Systolic','Diastolic'},'Age','Weight');
% legend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% singAgsBeyondBoundary
% hist3()
countAgents()
%
% proportionAgs()
%
% minPoptoReachGoals()
%
% averageDistsAgs()
%
% farthestDistAgs()
%
% pathwaysAgs()
%
% highestLikelyNbhdsAgs()
%
% statsAgents()
%
% firstPassTime()
%
% graphAgs()
%
% histoAgs()


end