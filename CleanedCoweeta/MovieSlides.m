function resultsStructure=MovieSlides(agentsInfoTable,parameterValues,videoStorLoc,~,timeStamp,generationCounter,Elevation,River,resultsStructure,resultsCount)
colors={'k','b','g','r'};reproConfirm=0;
sumVals=summary(agentsInfoTable);

dataType={'RadialMax','deathDist'};
dataCoords={{'RMaxCoords_1','RMaxCoords_2'},{'DeathCoords_1','DeathCoords_2'}};
dataTime={{'RadialMaxTime'},{'DeathTime'}};
dataTypeEle={'EleMaxVec' 'EleDeathVec'};

resultsCats=sumVals.DeathType.Categories;
allCats={'Reproducing Agent';'Death From Environment';'Boundary Escape'};allCatScatShape={'o','s','h'};

headerString=sprintf('Generation %d with %d Total Agents ',generationCounter,height(agentsInfoTable));
paramString= [strcat('ET:',num2str(parameterValues(1),'%.2e')) strcat(' Death:',num2str(parameterValues(3),'%.2e')); strcat('RT:',num2str(parameterValues(2),'%.2e')) strcat(' Repro:',num2str(parameterValues(4),'%.2e'))];

figureName{1}='Reproducing Agents Maximum Displacement';
dataName{1}='Maximum Displacement Achieved (m)';

figureName{2}='Reproducing Agents Death Displacement';
dataName{2}='Death Displacement (m)';



%     agentString{1}=sprintf('Generation %d Reproducing Agents\n %.4g%% Success Rate',generationCounter,(height(agentsInfoTable(agentsInfoTable.DeathType=='Reproducing Agent',:))/height(agentsInfoTable)*100));
typeCount=1;
for agentCount=1:height(sumVals.DeathType.Categories)
if contains(sumVals.DeathType.Categories{agentCount},'Reproducing Agent')
    agentString{typeCount}=sprintf('%g Reproducing Agents\n %.3g %% of Population.',sumVals.DeathType.Counts(agentCount),100*sumVals.DeathType.Counts(agentCount)/height(agentsInfoTable));
    Shapes{typeCount}=allCatScatShape{1};reproPointer=typeCount;
    resultsStructure(resultsCount).PercentReproducers=100*sumVals.DeathType.Counts(agentCount)/height(agentsInfoTable);
    reproConfirm=1;
    typeCount=typeCount+1;
elseif contains(sumVals.DeathType.Categories{agentCount},'Death From Environment')
    agentString{typeCount}=sprintf('%g Environmental Death Agents\n%.3f%% of Population.',sumVals.DeathType.Counts(agentCount),100*sumVals.DeathType.Counts(agentCount)/height(agentsInfoTable));
    Shapes{typeCount}=allCatScatShape{2};
    resultsStructure(resultsCount).PercentEnvironmentalDeaths=100*sumVals.DeathType.Counts(agentCount)/height(agentsInfoTable);
    typeCount=typeCount+1;
elseif contains(sumVals.DeathType.Categories{agentCount},'Boundary Escape')
    agentString{typeCount}=sprintf('%g Boundary Agents\n%.3f%% of Population.',sumVals.DeathType.Counts(agentCount),100*sumVals.DeathType.Counts(agentCount)/height(agentsInfoTable));
    Shapes{typeCount}=allCatScatShape{3};
    resultsStructure(resultsCount).PercentBoundaryEscape=100*sumVals.DeathType.Counts(agentCount)/height(agentsInfoTable);
    typeCount=typeCount+1;    
end
end

if ~reproConfirm
    agentString{typeCount}=sprintf('Generation %d with No Reproducing Agents\n 0%% Success Rate',generationCounter);
    resultsStructure(resultsCount).PercentReproducers=0;
% amountString{1}=sprintf(' Agents, or %.3f %s of the Total Population.',num2str(height(agentsInfoTable)),num2str(height(agentsInfoTable)/height(agentsInfoTable)),'%')
% infoVec=agentInfoMat.deathDist;

elseif reproConfirm
for sheetCount=1:width(dataType)
tilecount=1;

masterSheet=figure('WindowState','maximized','Name',figureName{sheetCount});
h=tiledlayout(masterSheet,2,2,'TileSpacing','compact','Padding','compact');

%% Upper left slide: Total vs selected population histograms with mean,median, 95% and max values computed.
nexttile(h,tilecount)
resultsStructure=DanielStackedHistos(agentsInfoTable,dataType{sheetCount},dataName{sheetCount},agentString{reproPointer},resultsCats,colors,sheetCount,tilecount,resultsStructure,resultsCount);
tilecount=tilecount+1;

%% Upper right slide: Scatterplot of var vs Delta Elevation with mean, median, 95% and max values computed. 
nexttile(h,2)
resultsStructure=DanielEleVsDist(agentsInfoTable,dataType{sheetCount},dataTypeEle{sheetCount},dataTime{sheetCount},dataName{sheetCount},agentString{reproPointer},resultsCats,colors,sheetCount,tilecount,resultsStructure,resultsCount);
tilecount=tilecount+1;

%% Lower left slide: 2D heatmap of repro
nexttile(h,3)
resultsStructure=DanielMapThreeD(agentsInfoTable,Elevation,River,dataType{sheetCount},dataCoords{sheetCount},sheetCount,tilecount,resultsStructure,resultsCount);
tilecount=tilecount+1;

%% Lower right slide: 
nexttile(h,4)
resultsStructure=DanielFirstPassageElevationScatter(agentsInfoTable,Elevation,River,resultsCats,dataCoords{sheetCount},dataTime{sheetCount},Shapes,reproPointer,sheetCount,tilecount,resultsStructure,resultsCount);
tilecount=tilecount+1;

title(h,{figureName{sheetCount},paramString}, 'FontSize', 15);
xlabel(h,dataName{sheetCount}, 'FontSize', 15)
ylabel(h,'Probability Distribution', 'FontSize', 15)
% sheetOutput{sheetCount}=masterSheet;
if ~isfile([videoStorLoc dataType{sheetCount} '_Generation_' num2str(generationCounter) num2str(resultsStructure(resultsCount).SimulationTimestamp) '.fig'])
            savefig(masterSheet,[videoStorLoc dataType{sheetCount} '_Generation_' num2str(generationCounter) num2str(resultsStructure(resultsCount).SimulationTimestamp) '.fig'],'compact');
            saveas(masterSheet,[videoStorLoc dataType{sheetCount} '_Generation_' num2str(generationCounter) num2str(resultsStructure(resultsCount).SimulationTimestamp) '.jpg']);
end

if sheetCount==1
            resultsStructure(resultsCount).maxFigLocation=[videoStorLoc dataType{sheetCount} '_Generation_' num2str(generationCounter) num2str(resultsStructure(resultsCount).SimulationTimestamp) '.fig'];
elseif sheetCount==2
            resultsStructure(resultsCount).deathFigLocation=[videoStorLoc dataType{sheetCount} '_Generation_' num2str(generationCounter) num2str(resultsStructure(resultsCount).SimulationTimestamp) '.fig'];
end
close(masterSheet);
end



end































% 
% %% Reproducing Agents
% typeCount=2;
% for agentCount=1:height(sumVals.DeathType.Categories)
% if contains(sumVals.DeathType.Categories{agentCount},'Reproducing Agent')
% nexttile(h,2)
% 
% Daniel1DHistogram(agentsInfoTable{agentsInfoTable.DeathType == 'Reproducing Agent',dataType{sheetCount} },...
%     dataName{sheetCount},agentString{typeCount},2,colors{2},'Reproducing Agents',totalXLim, totalYLim)
% typeCount=typeCount+1;
% 
% %% Environment Deaths
% elseif contains(sumVals.DeathType.Categories{agentCount},'Death From Environment')
% nexttile(h,3)
% 
% Daniel1DHistogram(agentsInfoTable{agentsInfoTable.DeathType == 'Death From Environment',dataType{sheetCount} },...
%     dataName{sheetCount},agentString{typeCount},2,colors{3},'Environmental Death Agents',totalXLim, totalYLim)
% typeCount=typeCount+1;
% 
% %% Boundary Escapes
% elseif contains(sumVals.DeathType.Categories{agentCount},'Boundary Escape')
% nexttile(h,4)
% 
% Daniel1DHistogram(agentsInfoTable{agentsInfoTable.DeathType == 'Boundary Escape' ,dataType{sheetCount} },...
%     dataName{sheetCount},agentString{typeCount},2,colors{4},'Boundary Agents',totalXLim, totalYLim)
% typeCount=typeCount+1;
% end
% 
% end
% title(h,{paramString,figureName{sheetCount}}, 'FontSize', 15);
% xlabel(h,dataName{sheetCount}, 'FontSize', 15)
% ylabel(h,'Probability Distribution', 'FontSize', 15)
% % sheetOutput{sheetCount}=masterSheet;
% if ~isfile([videoStorLoc dataType{sheetCount} 'Generation_' num2str(generationCounter) '.fig'])
%             savefig(masterSheet,[videoStorLoc dataType{sheetCount} 'Generation_' num2str(generationCounter) '.fig'],'compact');
%             saveas(masterSheet,[videoStorLoc dataType{sheetCount} 'Generation_' num2str(generationCounter) '.jpg']);
% end
% close(masterSheet);
% end
%    
% t = tiledlayout(3,2);
% nexttile
% histogram(Our_data,'Normalization','pdf')
% line(Our_data_pdf,yNorm)
% nexttile
% qqplot(Our_data,yNorm)
% nexttile
% histogram(Our_data,'Normalization','pdf')
% line(Our_data_pdf,yPoisson)
% nexttile
% qqplot(Our_data,yPoisson)
% nexttile
% plot(x,y3)
% nexttile
% plot(x,y4)
% 
% t.Padding = 'compact';
% t.TileSpacing = 'compact';
% 
% 
% figure
% t = tiledlayout(2,2);
% histogram(Our_data,'Normalization','pdf')
% line(Our_data_pdf,yNorm)
% A = icdf(pdNormal,0.9);
% B = icdf(pdNormal,0.1);
% optN=sshist(Our_data);
% % [optN, CssOut, NssOut]=sshist(Our_data);
% [N,Center] = hist(Our_data);
% [Nop,Cop] = hist(Our_data,optN);
% [f,xi] = ksdensity(Our_data,Cop);
% dNom1 = mode(diff(Center));
% dNom2 = mode(diff(Cop));
% t = tiledlayout(2,2);
% ax1=nexttile;
% histogram(Our_data,optN,'BinLimits',[min(Our_data),max(Our_data)],'Normalization','probability','BinMethod','auto');
% nexttile;
% histogram(Our_data,'Normalization','pdf');
% 
% plot(ax1,CssOut,N/dNom1,'.-')
% ax2=nexttile;
% plot(ax2,Center,N/dNom1,'.-')
% title(ax1,'Default')
% ax1.FontSize = 14;
% ax1.XColor = 'red';
% nexttile
% plot(Cop,Nop/dNom2,'.-')
% nexttile([1 2])
% plot(xi,f*length(Our_data),'.-')
% 
% % [M,C] = hist(Our_data);
% legend('','Optimum','ksdensity')
% title('Frequency Distribution')
% title(t,'My Title')
% xlabel(t,'x-values')
% ylabel(t,'y-values')
% t.Padding = 'compact';
% t.TileSpacing = 'compact';
end