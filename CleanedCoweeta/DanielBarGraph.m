function [totalXLim, totalYLim]=DanielBarGraph(agentTable,varType,varName,titleString,resultsCats,colors)

data=agentTable{:,varType};

med = median(data);
mu = mean(data);
sigma = std(data);
maxDist = max(data);

% Indicate those on the plot.
% xline(mod, 'Color', 'm', 'LineWidth', 2, 'LineStyle', '-.');

sHistogram = sprintf('  All Agents ');

sMedian = sprintf('  Median = %.1f meters', med);
sMean = sprintf('  $%s$ = %.1f meters', '\mu', mu);
sSD1 = sprintf('  $%s$ = %.3f meters','\sigma',sigma);
% % % sSD2 = sprintf('  $%s$ $%s$ 1 $%s$ = [%.3f,%.3f]', '\mu','\pm','\sigma',(mu-sigma),(mu+sigma));
sMax = sprintf('  Max = %.1f meters', maxDist);
 
numberBins=min(height(unique(data)),850/5);
counts=cell(1,height(resultsCats));binCenters=cell(1,height(resultsCats));

counts{1} = histogram(data,numberBins,'Normalization','probability', 'EdgeColor',colors{1},'FaceAlpha',1);
hold on;
medLine= line(nan,nan, 'Color', 'b', 'LineWidth', 2, 'LineStyle', '-.');
meanLine= line(nan,nan, 'Color', 'k', 'LineWidth', 2);
sdLine1= line(nan,nan, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '-');
maxLine= line(nan,nan, 'Color', 'k', 'LineWidth', 2, 'LineStyle', ':');


% % % medLine=xline(med, 'Color', 'b', 'LineWidth', 2, 'LineStyle', '-.','visible','off');
% % % meanLine=xline(mu, 'Color', 'k', 'LineWidth', 2,'visible','off');
% % % sdLine1=xline(mu - sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '-','visible','off');
% % % sdLine2=xline(mu + sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '-','visible','off');
% % % maxLine=xline(maxDist, 'Color', 'k', 'LineWidth', 2, 'LineStyle', ':','visible','off');
% for i=2:height(resultsCats)+1
% counts{i} = histogram(agentTable{agentTable.DeathType==resultsCats{i-1},varType},numberBins,'Normalization','probability', 'EdgeColor', colors{i},'FaceColor',colors{i});
% end
grid on;
% Put up legend.

title([titleString], 'FontSize', 12);
legend([counts{1},meanLine,medLine,sdLine1,maxLine],{sHistogram,sMedian,sMean,sSD1,sMax},'Location','best','Interpreter','latex','FontSize',12);
% legend([counts{1},meanLine,medLine,sdLine1,sdLine2,maxLine],{sHistogram,sMedian,sMean,sSD1,sSD2,sMax},'Location','best','Interpreter','latex','FontSize',12);
ax = ancestor(medLine, 'axes');
ax.XAxis.Exponent = 0;
ax.XLim=[-25 round(maxDist,1,'significant')+100];
ax.YAxis.Exponent = 0;
ax.YAxis.TickLabelFormat = '%0.3f';
totalXLim=ax.XLim;
totalYLim=ax.YLim;
hold off
end

% 
% binrng = 0;vm=[];
% for i=1:height(resultsCats)
% vm = [vm;agentTable{agentTable.DeathType == resultsCats{i},varType}];
% binrng = binrng+1;
% 
% for k = 1:size(vm,1)
%     counts(k,:) = histc(vm(k,:), binrng);
% end
% bar(binrng,counts,'stacked')
% grid