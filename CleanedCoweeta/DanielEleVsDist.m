function resultsStructure=DanielEleVsDist(agentTable,varType,varEle,varTime,varName,titleString,resultsCats,colors,sheetCount,tilecount,resultsStructure,resultsCount)

dataPre1=agentTable{agentTable.DeathType=='Reproducing Agent',{varType varEle varTime{1}}};
dataPreTime=agentTable{agentTable.DeathType=='Reproducing Agent',varTime{1}};
[dataPre2,dataPre2id1,~]=unique(dataPre1,'rows');dataTime=dataPreTime(dataPre2id1);dataPre2=[dataPre2 dataTime];
dataForScattering=sortrows(dataPre2,3,'ascend');
x=dataForScattering(:,1);y=dataForScattering(:,2);z=dataForScattering(:,3);
c=parula(height(dataPre2));d=jet(height(dataForScattering));%c=linspace(min(y),max(y),length(y))';

dataForScatteringSplitUpper=dataForScattering(y>=0,:);
upper95PerformValue=quantile(dataForScatteringSplitUpper, 0.95);results.upper95=upper95PerformValue;
cUpper=hot(height(dataForScatteringSplitUpper));

dataForScatteringSplitLower=dataForScattering(y<0,:);
cLower=cool(height(dataForScatteringSplitLower));
lower95PerformValue1=quantile(dataForScatteringSplitLower, 0.05);results.lower05=lower95PerformValue1;
lower95PerformValue2=quantile(dataForScatteringSplitLower, 0.95);results.lower95=lower95PerformValue2;

medUp = median(dataForScatteringSplitUpper);results.medUp=medUp;
medDown = median(dataForScatteringSplitLower);results.medDown=medDown;

muUp = mean(dataForScatteringSplitUpper);results.muUp=muUp;
muDown = mean(dataForScatteringSplitLower);results.muDown=muDown;

sigmaUp = std(dataForScatteringSplitUpper);results.sigmaUp=sigmaUp;
sigmaDown = std(dataForScatteringSplitLower);results.sigmaDown=sigmaDown;

maxUp = max(dataForScatteringSplitUpper);results.maxUp=maxUp;
minDown = min(dataForScatteringSplitLower);results.minDown=minDown;
maxDown = max(dataForScatteringSplitLower);results.maxDown=maxDown;

xMax=round(max(x),1,'significant')+100;
TimeMax=round(max(z),1,'significant');

resultsStructure=assignResultsValuesToStructure(resultsStructure,resultsCount,sheetCount,tilecount,results);

grid on;
background=scatter(x,y,18,'k','filled');
axes1 = background.Parent;

if ~(size(results(:).upper95,1)>1)
hold on
% upperVerticalLine= 

% lowerVerticalLine= 
line([lower95PerformValue2(1) lower95PerformValue2(1)],[axes1.YLim(1) lower95PerformValue1(2)], 'Color', 'red', 'LineWidth', 2, 'LineStyle', '-.','visible','on');
% lowerHorizontalLine= 
line([axes1.XLim(1) lower95PerformValue2(1)],[lower95PerformValue1(2) lower95PerformValue1(2)], 'Color', 'red', 'LineWidth', 2, 'LineStyle', '-.','visible','on');
lowerHorizontalLineForLegend= line(nan,nan, 'Color', 'red', 'LineWidth', 2, 'LineStyle', '-.');

medDownLine= line(nan,nan, 'Color', 'k', 'LineWidth', 2);
meanDownLine= line(nan,nan, 'Color', 'b', 'LineWidth', 2);
sdDownLine1= line(nan,nan, 'Color', 'k', 'LineWidth', 2);
% sdDownLine2= line(nan,nan, 'Color', 'r');
minDownLine= line(nan,nan, 'Color', 'k', 'LineWidth', 2);

elevationComparison=scatter(x,y,17,c,'filled','MarkerEdgeColor','k','Parent',axes1);
set(axes1,'CLim',[0 TimeMax]);
eleColorbar=colorbar(axes1);
eleColorbar.Ruler.Exponent = 0;

colorbarString = sprintf('  %s Time (s)', '\Delta');

yAxisSring=sprintf('  %s Elevation (m)', '\Delta');

colorTitle=title(eleColorbar,colorbarString);
graphTitlestring=strcat(varName, ' vs ', yAxisSring);

sMedDown = sprintf(' Med %s = %.1f m', '$ (\Delta E < 0 ) $', medDown(2));
sMeanDown = sprintf('  $%s %s$ = %.1f m', '\mu', '(\Delta E < 0 )', muDown(2));
sSD1Down = sprintf('  $%s %s$ = %.3f m','\sigma', '(\Delta E < 0 )',sigmaDown(2));
sLowerLine = sprintf('  95%s Threshold: (%.1f m, %.1f m)','\%', lower95PerformValue2(1), lower95PerformValue1(2));
sMinDown = sprintf('  Min %s = %.1f m', '$ (\Delta E < 0 ) $', minDown(2));

title({titleString,graphTitlestring}, 'FontSize', 12);

% lgd=legend([medUpLine,meanUpLine,sdUpLine1,upperHorizontalLineForLegend,maxUpLine,medDownLine,meanDownLine,sdDownLine1,lowerHorizontalLineForLegend,minDownLine],...
%     {sMedUp,sMeanUp,sSD1Up,sUpperLine,sMaxUp,sMedDown,sMeanDown,sSD1Down,sLowerLine,sMinDown},...
%     'Location','best','Interpreter','latex','FontSize',10,'NumColumns',2);
lgd=legend([lowerHorizontalLineForLegend],...
    {sLowerLine},...
    'Location','northeast','Interpreter','latex','FontSize',10,'NumColumns',1);

% title(lgd,'$$\Delta E > 0  \hspace{4cm} \Delta E < 0 $$',"Interpreter","latex");
xlabel(varName);
ylabel(yAxisSring);
hold off

else

hold on
% upperVerticalLine= 
line([upper95PerformValue(1) upper95PerformValue(1)],[axes1.YLim(1) upper95PerformValue(2)], 'Color', 'red', 'LineWidth', 2, 'LineStyle', '--','visible','on');
% upperHorizontalLine= 
line([axes1.XLim(1) upper95PerformValue(1)],[upper95PerformValue(2) upper95PerformValue(2)], 'Color', 'red', 'LineWidth', 2, 'LineStyle', '--','visible','on');
upperHorizontalLineForLegend= line(nan,nan, 'Color', 'red', 'LineWidth', 2, 'LineStyle', '--');

% lowerVerticalLine= 
line([lower95PerformValue2(1) lower95PerformValue2(1)],[axes1.YLim(1) lower95PerformValue1(2)], 'Color', 'red', 'LineWidth', 2, 'LineStyle', '-.','visible','on');
% lowerHorizontalLine= 
line([axes1.XLim(1) lower95PerformValue2(1)],[lower95PerformValue1(2) lower95PerformValue1(2)], 'Color', 'red', 'LineWidth', 2, 'LineStyle', '-.','visible','on');
lowerHorizontalLineForLegend= line(nan,nan, 'Color', 'red', 'LineWidth', 2, 'LineStyle', '-.');

medUpLine= line(nan,nan, 'Color', 'k', 'LineWidth', 2);
meanUpLine= line(nan,nan, 'Color', 'b', 'LineWidth', 2);
sdUpLine1= line(nan,nan, 'Color', 'k', 'LineWidth', 2);
% sdUpLine2= line(nan,nan, 'Color', 'r');
maxUpLine= line(nan,nan, 'Color', 'k', 'LineWidth', 2);

medDownLine= line(nan,nan, 'Color', 'k', 'LineWidth', 2);
meanDownLine= line(nan,nan, 'Color', 'b', 'LineWidth', 2);
sdDownLine1= line(nan,nan, 'Color', 'k', 'LineWidth', 2);
% sdDownLine2= line(nan,nan, 'Color', 'r');
minDownLine= line(nan,nan, 'Color', 'k', 'LineWidth', 2);

elevationComparison=scatter(x,y,17,c,'filled','MarkerEdgeColor','k','Parent',axes1);
set(axes1,'CLim',[0 TimeMax]);
eleColorbar=colorbar(axes1);
eleColorbar.Ruler.Exponent = 0;

colorbarString = sprintf('  %s Time (s)', '\Delta');

yAxisSring=sprintf('  %s Elevation (m)', '\Delta');

colorTitle=title(eleColorbar,colorbarString);
graphTitlestring=strcat(varName, ' vs ', yAxisSring);

nineFive1=upper95PerformValue(1);nineFive2=upper95PerformValue(2);

sMedUp = sprintf(' Med %s = %.1f m', '$ (\Delta E > 0 ) $', medUp(2));
sMeanUp = sprintf('  $%s %s$ = %.1f m', '\mu', '(\Delta E > 0 )', muUp(2));
sSD1Up = sprintf('  $%s %s$ = %.3f m','\sigma', '(\Delta E > 0 )',sigmaUp(2));
sUpperLine = sprintf('  95%s Threshold: (%.1f m, %.1f m)','\%',nineFive1,nineFive2);
sMaxUp = sprintf('  Max %s = %.1f m', '$ (\Delta E > 0 ) $', maxUp(2));

sMedDown = sprintf(' Med %s = %.1f m', '$ (\Delta E < 0 ) $', medDown(2));
sMeanDown = sprintf('  $%s %s$ = %.1f m', '\mu', '(\Delta E < 0 )', muDown(2));
sSD1Down = sprintf('  $%s %s$ = %.3f m','\sigma', '(\Delta E < 0 )',sigmaDown(2));
sLowerLine = sprintf('  95%s Threshold: (%.1f m, %.1f m)','\%', lower95PerformValue2(1), lower95PerformValue1(2));
sMinDown = sprintf('  Min %s = %.1f m', '$ (\Delta E < 0 ) $', minDown(2));

title({titleString,graphTitlestring}, 'FontSize', 12);

% lgd=legend([medUpLine,meanUpLine,sdUpLine1,upperHorizontalLineForLegend,maxUpLine,medDownLine,meanDownLine,sdDownLine1,lowerHorizontalLineForLegend,minDownLine],...
%     {sMedUp,sMeanUp,sSD1Up,sUpperLine,sMaxUp,sMedDown,sMeanDown,sSD1Down,sLowerLine,sMinDown},...
%     'Location','best','Interpreter','latex','FontSize',10,'NumColumns',2);
lgd=legend([upperHorizontalLineForLegend,lowerHorizontalLineForLegend],...
    {sUpperLine,sLowerLine},...
    'Location','northeast','Interpreter','latex','FontSize',10,'NumColumns',1);

% title(lgd,'$$\Delta E > 0  \hspace{4cm} \Delta E < 0 $$',"Interpreter","latex");
xlabel(varName);
ylabel(yAxisSring);
hold off
end
end
