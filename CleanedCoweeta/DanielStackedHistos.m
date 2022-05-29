function resultsStructure=DanielStackedHistos(agentTable,varType,varName,titleString,resultsCats,colors,sheetCount,tilecount,resultsStructure,resultsCount)

data=agentTable{:,varType};
data2=agentTable{agentTable.DeathType=='Reproducing Agent',varType};

med = median(data);results.allmed=med;
mu = mean(data);results.allmu=mu;
sigma = std(data);results.allsigma=sigma;
upperPerformValue=quantile(data, 0.95);results.all95=upperPerformValue;
maxDist = max(data);results.allMax=maxDist;
xMax=round(maxDist,1,'significant')+100;

med2 = median(data2);results.repromed=med2;
mu2 = mean(data2);results.repromu2=mu2;
sigma2 = std(data);results.reprosigma2=sigma2;
upperPerformValue2=quantile(data2, 0.95);results.repro95=upperPerformValue2;
maxDist2 = max(data2);results.repromaxDist2=maxDist2;

numberBins=min(height(unique(data)),xMax/5);results.numberBins=numberBins;

histogram(data,numberBins,'Normalization','pdf', 'EdgeColor',colors{1}, 'FaceColor',colors{1},'FaceAlpha',0.4);

hold on;
medLine= line([med2 med2],ylim, 'Color', 'b', 'LineWidth', 2, 'LineStyle', '-.','visible','off');
meanLine= line([mu2 mu2],ylim, 'Color', 'k', 'LineWidth', 2,'visible','off');
sdLine2= line([upperPerformValue2 upperPerformValue2],ylim, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '-','visible','off');
maxLine= line([maxDist2 maxDist2],ylim, 'Color', 'k', 'LineWidth', 2, 'LineStyle', ':','visible','off');

allHist = histogram(data,numberBins,'Normalization','pdf', 'EdgeColor',colors{1}, 'FaceColor',colors{1},'FaceAlpha',0.4);
reproHist = histogram(data2,numberBins,'Normalization','pdf', 'EdgeColor',colors{1}, 'FaceColor',colors{2},'FaceAlpha',.6);

resultsStructure=assignResultsValuesToStructure(resultsStructure,resultsCount,sheetCount,tilecount,results);

grid on;

sHistogram = sprintf('  All Agents ');

sMedian2 = sprintf('  Median = %.1f m', med2);
sMean2 = sprintf('  $%s$ = %.1f m ', '\mu', mu2);
sSD2 = sprintf('  95%s Threshold = %.1f m', '\%', upperPerformValue2);
sMax2 = sprintf('  Max = %.1f m', maxDist2); 
sHisto2 = sprintf(' Repro Agents');

title({titleString,'PDF Comparison: All Agents vs Successful Agents'}, 'FontSize', 12);
legend([allHist,reproHist],{sHistogram,sHisto2},'Location','best','Interpreter','latex','FontSize',12);
% legend([allHist,reproHist,meanLine,medLine,sdLine2,maxLine],{sHistogram,sHisto2,sMedian2,sMean2,sSD2,sMax2},'Location','best','Interpreter','latex','FontSize',12);
ax = ancestor(medLine, 'axes');
ax.XAxis.Exponent = 0;
ax.XLim=[-25 xMax];
xlabel(varName);
ylabel('Probability Density')
ax.YAxis.Exponent = 0;
ax.YAxis.TickLabelFormat = '%0.2f';
totalXLim=ax.XLim;
totalYLim=ax.YLim;
hold off
end
