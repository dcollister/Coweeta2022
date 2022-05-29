function create1d2dSheetReport(agentsInfoTable,parameterValues,imageStorLoc,landscapeName,timeStamp)
colors={'k','b','g','r'};
sumVals=summary(agentsInfoTable);

resultsCats=sumVals.DeathType.Categories;
allCats={'Reproducing Agent';'Death From Environment';'Boundary Escape'};

headerString=sprintf('%d Total Agents in One Generation',height(agentsInfoTable));
paramString=strcat('Elevation Bias'," ",num2str(parameterValues(1),'%.2d'),'. River Bias '," ",num2str(parameterValues(2),'%.2d'),...
    '. Prob. Environment Death '," ",num2str(parameterValues(3),'%.2d'),'. Prob Reproduction '," ",num2str(parameterValues(4),'%.2d'),'.');

figureName{1}='Maximum Displacement Frequency Distributions by Performance Group';
dataName{1}='Maximum Displacement Achieved (m)';

figureName{2}='Death Displacement Frequency Distributions by Performance Group';
dataName{2}='Death Displacement (m)';
 

agentString{1}=sprintf('%d Total Agents\n One Generation',height(agentsInfoTable));

dataType={'RadialMax','deathDist'};
% amountString{1}=sprintf(' Agents, or %.3f %s of the Total Population.',num2str(height(agentsInfoTable)),num2str(height(agentsInfoTable)/height(agentsInfoTable)),'%')
% infoVec=agentInfoMat.deathDist;
for sheetCount=1:width(dataType)

masterSheet=figure('WindowState','maximized','Name',figureName{sheetCount});
h=tiledlayout(masterSheet,2,2,'TileSpacing','compact','Padding','compact');

%% All collected 
nexttile(h,1)

[totalXLim, totalYLim]=DanielBarGraph(agentsInfoTable,dataType{sheetCount},dataName{sheetCount},agentString{1},resultsCats,colors);

%% Reproducing Agents
typeCount=2;
for agentCount=1:height(sumVals.DeathType.Categories)
if contains(sumVals.DeathType.Categories{agentCount},'Reproducing Agent')
nexttile(h,2)

agentString{typeCount}=sprintf('%g Reproducing Agents\n%.3f%% of Population.',sumVals.DeathType.Counts(agentCount),100*sumVals.DeathType.Counts(agentCount)/height(agentsInfoTable));

Daniel1DHistogram(agentsInfoTable{agentsInfoTable.DeathType == 'Reproducing Agent',dataType{sheetCount} },...
    dataName{sheetCount},agentString{typeCount},2,colors{2},'Reproducing Agents',totalXLim, totalYLim)

typeCount=typeCount+1;

%% Environment Deaths
elseif contains(sumVals.DeathType.Categories{agentCount},'Death From Environment')
nexttile(h,3)
agentString{typeCount}=sprintf('%g Environmental Death Agents\n%.3f%% of Population.',sumVals.DeathType.Counts(agentCount),100*sumVals.DeathType.Counts(agentCount)/height(agentsInfoTable));
Daniel1DHistogram(agentsInfoTable{agentsInfoTable.DeathType == 'Death From Environment',dataType{sheetCount} },...
    dataName{sheetCount},agentString{typeCount},2,colors{3},'Environmental Death Agents',totalXLim, totalYLim)
typeCount=typeCount+1;

%% Boundary Escapes
elseif contains(sumVals.DeathType.Categories{agentCount},'Boundary Escape')
nexttile(h,4)
agentString{typeCount}=sprintf('%g Boundary Agents\n%.3f%% of Population.',sumVals.DeathType.Counts(1),100*sumVals.DeathType.Counts(1)/height(agentsInfoTable));
Daniel1DHistogram(agentsInfoTable{agentsInfoTable.DeathType == 'Boundary Escape' ,dataType{sheetCount} },...
    dataName{sheetCount},agentString{typeCount},2,colors{4},'Boundary Agents',totalXLim, totalYLim)
typeCount=typeCount+1;
end

end
title(h,{paramString,figureName{sheetCount}}, 'FontSize', 15);
xlabel(h,dataName{sheetCount}, 'FontSize', 15)
ylabel(h,'Probability Distribution', 'FontSize', 15)
sheetOutput{sheetCount}=masterSheet;
if ~isfile([imageStorLoc landscapeName dataType{sheetCount} '_ET:' num2str(parameterValues(1)) '_RT:' num2str(parameterValues(2)) '_PD:' num2str(parameterValues(3)) '_Repro:' num2str(parameterValues(4)) timeStamp '.fig'])
            savefig(masterSheet,[imageStorLoc landscapeName dataType{sheetCount} '_ET_' num2str(parameterValues(1)) '_RT_' num2str(parameterValues(2)) '_PD_' num2str(parameterValues(3)) '_Repro_' num2str(parameterValues(4)) timeStamp '.fig'],'compact');
            saveas(masterSheet,[imageStorLoc landscapeName dataType{sheetCount} '_ET_' num2str(parameterValues(1)) '_RT_' num2str(parameterValues(2)) '_PD_' num2str(parameterValues(3)) '_Repro_' num2str(parameterValues(4)) timeStamp '.jpg']);
end
close(masterSheet);
end
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