function FourFigPlot(testFileFolder,testFileCombinedName,testFileCollectedName,testFigSaveFolder,testImagesSaveFolder,saveName,...
        PhysFactorNames,BioFactorNames,titleTopLineFrontPiece,...
        BirthsSetCoords,ReproDeathCountMat,AllDeathCountMat,...
        BioChoice1,BioChoice2,TChoice1,TChoice2,singleHomoSwitch)

load('LandandAltGrids.mat','altLandGrid','landGrid');
        red = [1, 0, 0];
        pink = [255, 192, 203]/255;
        orange=[251, 98, 5]/255;
        green=[94 223 12]/255;
        myBlue=[57 168 251]/255;
        BirthBiVarDistBotCol=[0 0 255]/255;
        BirthBiVarDistTopCol=[0 255 255]/255;
        gray='#9B9B9B';
CollectedFilename=[testFileFolder testFileCollectedName];
ComparisonObject = matfile(CollectedFilename,'Writable',true);
        %% Make Pretty pictures
        
%% Projection Heatmap of agents.  Reproducing deaths, maxes and max-performer line-segments for both overlaid on top of two heatmaps.
CombinedFilename=[testFileFolder testFileCombinedName];
CombinedRunsObject = matfile(CombinedFilename,'Writable',true);
CombinedRuns=CombinedRunsObject.groupRepro(:,[9 28]);
t=CombinedRuns(:,2);maxDistVec=CombinedRuns(:,1);
% rowTimes=(unique(t))';
% CombinedRunsTT = array2timetable(CombinedRuns,'RowTimes',rowTimes);
options = fitoptions('Method', 'LinearLeastSquares');
[fitTestobject,gof] = fit(t,maxDistVec,'poly20',options);
% [pop_fit,delta] = polyval(p,t,ErrorEst);
% [logitCoef2,dev2] = glmfit(t,maxDistVec,'binomial','logit');
% pval = 1 - chi2cdf(dev-dev2,1)

% res = maxDistVec - fitTestobject;
figure, plot(fitTestobject,t,maxDistVec,'o')
title('Residuals for the Quadratic Polynomial Model')

plot(t,maxDistVec,'+',...
     t,pop_fit,'g-',...
     t,pop_fit+2*delta,'r:',...
     t,pop_fit-2*delta,'r:'); 
xlabel('Time in seconds');
ylabel('Maximum Distance in Meters');
title('Quadratic Polynomial Fit with Confidence Bounds')
grid on


%% BoxPlot Comparisons for Initial Runs, extracting the distances attained and frequency of occurance
%% Inputs
ColumnRunHolder=zeros(size(ComparisonObject.ReproAgentsInfo,1),size(ComparisonObject.ReproAgentsInfo,3));
ColumnRunHolder(:,1:size(ComparisonObject.ReproAgentsInfo,3)) = ComparisonObject.ReproAgentsInfo(:,9,1:size(ComparisonObject.ReproAgentsInfo,3)); 
[C, ia, ic] = unique(ColumnRunHolder,'stable');
a_counts = accumarray(ic,1);
value_counts = [C, a_counts]
x = 1:size(ComparisonObject.ReproAgentsInfo,3); 
%% Set Spacing
binWidth = 0.4;  % histogram bin widths
hgapGrp = .15;   % horizontal gap between pairs of boxplot/histograms (normalized)
hgap = 0.06;      % horizontal gap between boxplot and hist (normalized)
%% Compute histogram counts & edges
hcounts = cell(size(ColumnRunHolder,2),2); 
for i = 1:size(ColumnRunHolder,2)
    [hcounts{i,1}, hcounts{i,2}] = histcounts(ColumnRunHolder(:,i),'BinWidth',binWidth); 
end
maxCount = max([hcounts{:,1}]);
%% Plot boxplotsGroup()
fig = figure('Name','Comparison Grids of Metrics',...
            'NumberTitle','off');
ax = axes(fig); 
hold(ax,'on')
% Convert y (mxn matrix) to 1xn cell array of mx1 vectors, required by boxplotWidths
yc = mat2cell(ColumnRunHolder,size(ColumnRunHolder,1),ones(1,size(ColumnRunHolder,2))); 
xInterval = 1; %x-interval is always 1 with boxplot groups
normwidth = (1-hgapGrp-hgap)/2;     
boxplotWidth = xInterval*normwidth; 
% Define colors for each boxplot
colors = lines(size(ColumnRunHolder,2)); 
% Plot colored boxplots
bph = boxplotGroup(ax,yc,'Widths',boxplotWidth,'OutlierSize',3,'PrimaryLabels',compose('%d',x),'Colors',colors);
set(findobj(bph.boxplotGroup,'-property','LineWidth'), 'LineWidth', 1) % increase line widths
%% Add vertical histograms (patches) with matching colors
xCoordinate = 1:size(ColumnRunHolder,2);  %x-positions is always 1:n with boxplot groups
histX0 = xCoordinate + boxplotWidth/2 + hgap;    % histogram base
maxHeight = xInterval*normwidth;       % max histogram height
patchHandles = gobjects(1,size(ColumnRunHolder,2)); 
for i = 1:size(ColumnRunHolder,2)
    % Normalize heights 
    height = hcounts{i,1}/maxCount*maxHeight;
    % Compute x and y coordinates 
    xm = [zeros(1,numel(height)); repelem(height,2,1); zeros(2,numel(height))] + histX0(i);
    yidx = [0 0 1 1 0]' + (1:numel(height));
    ym = hcounts{i,2}(yidx);
    % Plot patches
    patchHandles(i) = patch(xm(:),ym(:),colors(i,:),'EdgeColor',colors(i,:),'LineWidth',1,'FaceAlpha',.45);
    
%% Label, legend and export %%   
        lgd=legend('Elevation Contour Isolines (meters above sea level).','The Coweeta river network.','Spawn Location.');
        
        PopC=colorbar;
        PopC.LineWidth = 1.5;
        PopC.Ticks = linspace(0,linSpaceEnd,size(linSpaceLabels,2)); %Create 8 ticks from zero to 1
        PopC.TickLabels = num2cell(linSpaceLabels) ;
        PopC.Label.String = 'Percentage of reproducing population.';
        view(-10, 50);
        
        titleName=strcat({[titleTopLineFrontPiece, ' with ~',num2str(PercentBirthsOfTotal) ,'% of the population reproducing.']
            [num2str(length) ' successful agents out of a population of ' num2str(TotalPopSize) '.  Longest lifespan: ' num2str(maxTime) ' seconds.']
            ['Elevation: ' PhysFactorNames{TChoice1} '. River: ' PhysFactorNames{TChoice2} '.']
            ['Environment Lethality: ' BioFactorNames{BioChoice1} '. Chance of Reproduction: ' BioFactorNames{BioChoice2} '.']
            });
        
        lgd.Location='northwest';
        %     lgd.Orientation='horizontal';
        
        title(titleName)
        xlabel('Lattitude (meters)')
        ylabel('Longitude (meters)')
        %                                 ylabel.orientation='vertical';
        zlabel('Number of reproducing agents')
        hold off
        
        savefig(reproAgsFig,[testFigSaveFolder saveFileName 'ReproAgHist2.fig'],'compact');
        saveas(reproAgsFig,[testImagesSaveFolder saveFileName 'ReproAgHist2.jpg'],'jpg');
        close(reproAgsFig)
end