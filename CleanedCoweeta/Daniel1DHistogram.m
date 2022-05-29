function [histoObject]=Daniel1DHistogram(data,dataType,agentString,styleChoice,color,hString,totalXLim, totalYLim)

if styleChoice==1

%% Option 1
h = histogram(data);
dataMean = mean(data(:));
dataMedian = median(data(:));
grid on;
hold on;
% Put up vertical lines there
xline(dataMean, 'Color', 'r', 'LineWidth', 2);
xline(dataMedian, 'Color', 'k', 'LineWidth', 2);
% Find bin centers
binCenters = (h.BinEdges(1:end-1) + h.BinEdges(2:end))/2;
% Put up red x on top of the bar
[~, index] = min(abs(dataMean - binCenters));
plot(binCenters(index), h.Values(index), 'r', 'LineWidth', 3);
[~, index] = min(abs(dataMedian - binCenters));
plot(binCenters(index), h.Values(index), 'k', 'LineWidth', 3);

elseif styleChoice==2

%% Option 2
numBins=850/5;
h = histogram(data, numBins,'Normalization','probability', 'EdgeColor', 'black','FaceAlpha',1,'FaceColor',color);
% xlabel(dataType, 'FontSize', 15);
% ylabel('Frequency Distribution', 'FontSize', 15);
hold on
grid on;
% Compute mean and standard deviation.
% mod=mode(data);
% % % 
med = median(data);
mu = mean(data);
sigma = std(data);
maxDist = max(data);
% % % 
% % % % Indicate those on the plot.
% % % % xline(mod, 'Color', 'm', 'LineWidth', 2, 'LineStyle', '-.');
% % % medLine=xline(med, 'Color', 'b', 'LineWidth', 2, 'LineStyle', '-.','visible','off');
% % % meanLine=xline(mu, 'Color', 'k', 'LineWidth', 2,'visible','off');
% % % sdLine1=xline(mu - sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '-','visible','off');
% % % sdLine2=xline(mu + sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '-');
% % % maxLine=xline(maxDist, 'Color', 'k', 'LineWidth', 2, 'LineStyle', ':','visible','off');
% % % 
% % % % sMode = sprintf('  Mode = %.1f meters', mod);

medLine= line(nan,nan, 'Color', 'b', 'LineWidth', 2, 'LineStyle', '-.');
meanLine= line(nan,nan, 'Color', 'k', 'LineWidth', 2);
sdLine1= line(nan,nan, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '-');
maxLine= line(nan,nan, 'Color', 'k', 'LineWidth', 2, 'LineStyle', ':');

sMedian = sprintf('  Median = %.1f meters', med);
sMean = sprintf('  $%s$ = %.1f meters', '\mu', mu);
sSD1 = sprintf('  $%s$ = %.3f meters','\sigma',sigma);
% % % sSD2 = sprintf('  $%s$ $%s$ 1 $%s$ = [%.3f,%.3f]', '\mu','\pm','\sigma',(mu-sigma),(mu+sigma));
sMax = sprintf('  Max = %.1f meters', maxDist);

% Position the text 90% of the way from bottom to top.
% text(0.65*maxDist, 0.95*max(h.Values), sMean, 'Color', 'k', ...
% 	'FontWeight', 'bold', 'FontSize', 12, ...
% 	'EdgeColor', 'k', 'LineWidth', 2, 'BackgroundColor','w','visible','off');
% 
% text(0.65*maxDist, 0.8*max(h.Values), sMedian, 'Color', 'k', ...
% 	'FontWeight', 'bold', 'FontSize', 12, ...
% 	'EdgeColor', 'b', 'LineWidth', 2, 'LineStyle', '-.', 'BackgroundColor','w');
% 
% text(0.65*maxDist, 0.65*max(h.Values), sMode, 'Color', 'k', ...
% 	'FontWeight', 'bold', 'FontSize', 12, ...
% 	'EdgeColor', 'm', 'LineWidth', 2, 'LineStyle', '-.', 'BackgroundColor','w');
% 
% text(0.65*maxDist, 0.65*max(h.Values), sSD, 'Color', 'k', ...
% 	'FontWeight', 'bold', 'FontSize', 12, ...
% 	'EdgeColor', 'r', 'LineWidth', 2, 'LineStyle', '-', 'BackgroundColor','w');
% 
% text(0.65*maxDist, 0.5*max(h.Values), sMax, 'Color', 'k', ...
% 	'FontWeight', 'bold', 'FontSize', 12, ...
% 	'EdgeColor', 'k', 'LineWidth', 2, 'LineStyle', ':', 'BackgroundColor','w');

% topTitleBarsprintf(agentString, .  Mean = %.3f.  SD = %.3f', numBins, mu, sigma);
title(agentString, 'FontSize', 12);
% legend(h,{sMedian,sMean,sSD1,sSD2,sMax},"Location",'best','Interpreter','latex','FontSize',12);
legend([h,medLine,meanLine,sdLine1,maxLine],{hString,sMedian,sMean,sSD1,sMax},"Location",'best','Interpreter','latex','FontSize',12);
ax = ancestor(h, 'axes');
ax.XAxis.Exponent = 0;
ax.XLim=totalXLim;
% ax.YLim=totalYLim;
ax.YAxis.Exponent = 0;
ax.YAxis.TickLabelFormat = '%0.3f';
hold off


elseif styleChoice==3

    
elseif styleChoice==4
% 
% %% Option 3
% numBins=400;
% h = histogram(data, numBins,'Normalization','probability', 'EdgeColor', 'none');
% xlabel(dataType, 'FontSize', 15);
% ylabel('Frequency Distribution', 'FontSize', 15);
% hold on
% grid on;
% % Compute mean and standard deviation.
% med = median(data);
% mu = mean(data);
% sigma = std(data);
% kurt = kurtosis(data);
% % Indicate those on the plot.
% xline(med, 'Color', 'b', 'LineWidth', 2);
% xline(mu, 'Color', 'm', 'LineWidth', 2);
% xline(mu - sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
% xline(mu + sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
% sMean = sprintf('  Median = %.3f\n  Mean = %.3f\n  SD = %.3f  Kurtosis = %%.3f', med, mu, sigma,kurt);
% % Position the text 90% of the way from bottom to top.
% text(mu, 0.9*max(h.Values), sMean, 'Color', 'k', ...
% 	'FontWeight', 'bold', 'FontSize', 12, ...
% 	'EdgeColor', 'b');
% presMean2= sprintf('Histogram with %d bins.  Mean = %.3f.  SD = %.3f', numBins, mu, sigma);
% sMean2=strcat(agentString,presMean2);
% title(sMean2, 'FontSize', 14);
% hold off
end













end