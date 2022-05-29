    % put in the image retrieval files here.  This is where we are also
    % going to generate the information we need from each file.  Consider
    % the following targets as top priority:
%     1 - displacements (max/death) in euclidean and height
%     2 - mean/stan div
%     3 - Graphs
%     4 - graphallshortestpaths

%Radius is neighborhood around points focused on in narrowed processing.
%Consider that you need to filter before this: group of highest values and
%origins, vs highest amounts etc.
%CoordsChoices: 1=birthcoords 2=deathCoords 3=maxCoords
function singleFileVisualize(UpdatedNamesandParamsTable,landData,landscapeName,ofatParamString,graphFilename,singleGraphFilename,imageStorLoc,...
        plotType,singleX,singleY,sourceRadius,innerCatchRadius,outerCatchRadius)
    extrasSwitch=0;
close all
load(landData,'ElevationGrid','RivElevationsOnlyMatrix','RiverCoords','landGridBinary');

neighborhoodRadius=25;
CoordsChoice=1;
%% Not reading the subgroup folders correctly.  What the flying ..  Currently leaving it selecting all 
ProbBirthNameAll=UpdatedNamesandParamsTable.ProbReproduction;

for pbCounter=2%1:height(UpdatedNamesandParamsTable)
    dirName=strcat(UpdatedNamesandParamsTable.ProcessedName(pbCounter),'All*.csv');
ProbBirthName=ProbBirthNameAll(pbCounter);
parameterValues=[UpdatedNamesandParamsTable.ET(pbCounter) UpdatedNamesandParamsTable.RT(pbCounter) UpdatedNamesandParamsTable.ProbDeath(pbCounter) UpdatedNamesandParamsTable.ProbReproduction(pbCounter)];
% ProbBirthName=extractBetween(dirName,'CombinedFiles','\All');
mainDirContents = dir(dirName);
mainDirContents([mainDirContents.isdir]) = [];   %remove non-folders
mask = ismember( {mainDirContents.name}, {'.', '..'});
mainDirContents(mask) = [];
num_subfolder = length(mainDirContents);

for runCount=1:num_subfolder
A=readtable([mainDirContents(runCount).folder '\' mainDirContents(runCount).name]);
[popName,saverStringPopName]=populationTypeStringTempGen(mainDirContents(runCount).name);
% A=readtable('SimResults\CoweetaCollection\Coweeta\Whole\Complete\Riv_All\Homo\W_0_ET_100000_RT_100000ProbDeath_1e-05\ProbBirth_0.01\AllCollectedInformation_2021_10_04_09_15_47.csv');
BirthCords = [A.BirthCoords_1 A.BirthCoords_2];
DeathCords = [A.DeathCoords_1 A.DeathCoords_2];
RadialMaxCoords=[A.RMaxCoords_1 A.RMaxCoords_2];
DeathTime = A.DeathTime;
DeathDistVals = A.deathdiffX;
RadialMaxTime = A.RadialMaxTime;
RadialMaxVals = A.RadialMax;
CoordsForChoiceSandbox={BirthCords DeathCords RadialMaxCoords};
TimesForChoiceSandbox={DeathTime RadialMaxTime};
ValsForChoiceSandbox={DeathDistVals RadialMaxVals};

CoordsChoiceOutput=CoordsForChoiceSandbox{CoordsChoice};

%  Currently setting the points of interest as being the birth locations.
%  Grab all the unique coords. 'Stable'  Keeps them in the order from the
%  array.
%  [C,IA,IC] = UNIQUE(A,'rows') also returns index vectors IA and IC such
%     that C = A(IA,:) and A = C(IC,:).

% P1=NarrowedCoords vector
% P2=1-d vector of indices s.t. NarrowedCoords=CoordsArray(P2,:)
% P3=1-d vector containing labels connecting each unique coord in NarrowedCoord to coords in CoordsArra
[UniqueBirthCoords,UniFromCoordsInds,UniLbls4CompleteCoords]=unique(CoordsChoiceOutput,'rows','stable');
heightOfUniqueBirthPoints=size(UniqueBirthCoords,1);
distMatForAllUniCoords=zeros(heightOfUniqueBirthPoints,heightOfUniqueBirthPoints);
BirthCoordsNeighbors=cell(heightOfUniqueBirthPoints,4);

% First part:  Create a distance matrix of size uniCoords x uniCoords for 2-d search of coord distances, saved as "distMat", which is built off of the chosen
% neighborhood epsilon value *neighborhoodRadius* from provided coords.

% Second part:  Create a table from refined coords within e-radius
%   Table.1=>  distVecInds=indices for P1 within condition
%   Table.2=>  coords=P1(distVecInds)
%   Table.3=
for distCount1=1:heightOfUniqueBirthPoints
    singPointVec=(ones(heightOfUniqueBirthPoints,2).*UniqueBirthCoords(distCount1,1:2)-UniqueBirthCoords);
    distMatForAllUniCoords(distCount1,:)=sqrt(singPointVec(:,1).^2+singPointVec(:,2).^2);
    distVecFromUniCoordsInds=distMatForAllUniCoords(distCount1,:)<neighborhoodRadius;
    pointLocIDs=UniFromCoordsInds(distVecFromUniCoordsInds);
    
    BirthCoordsNeighbors{distCount1,1}=distVecFromUniCoordsInds;%.distInds
    BirthCoordsNeighbors{distCount1,2}=UniqueBirthCoords(distVecFromUniCoordsInds,1:2);%.NarrowedCoords
    BirthCoordsNeighbors{distCount1,3}=pointLocIDs;%.LabelsFromNarrowIDs
%     neighbors{distCount1}.distanceMatrixPreNarrow=UniLbls4CompleteCoords();
end


imagePreName=[mainDirContents(runCount).folder '\Figures\' saverStringPopName];
GraphTitle=strcat('ET_', num2str(UpdatedNamesandParamsTable.ET(pbCounter)),'_RT_', num2str(UpdatedNamesandParamsTable.RT(pbCounter)),...
    '_PD_', num2str(UpdatedNamesandParamsTable.ProbDeath(pbCounter)),'_PB_', num2str(UpdatedNamesandParamsTable.ProbReproduction(pbCounter)),'__');
% GraphTitle=strcat('EllowRiverlowLandSafeBirthRate',ProbBirthName);

%% Graph of river and region of interest code
pd = fitdist(RadialMaxVals,'Normal');
runTypeName=mainDirContents(runCount).name(1:end-4);
imageTitle=strcat('Maximum Distances for ',popName);
normFigName=strcat(imagePreName,'NormalFitAttempt.fig');
normJPGName=strcat(imagePreName,'NormalFitAttempt.png');
methods(pd);
ci95 = paramci(pd);
ci99 = paramci(pd,'Alpha',.01);
RadialMaxVals_values = min(RadialMaxVals):( (max(RadialMaxVals) - min(RadialMaxVals)) / 100 ):max(RadialMaxVals);
y = pdf(pd,RadialMaxVals_values);

%% There is more work to be done in here, comparing histograms from the subpopulations to the main vec, but the tools are basically here.
[quantileValues]=createPdfPlotFigure(RadialMaxVals_values,y,normFigName,normJPGName,pd,imageTitle,RadialMaxVals,A);

plotTopFlyersAgainstGradient(ElevationGrid,RiverCoords,A,landscapeName,GraphTitle,graphFilename,singleGraphFilename,imageStorLoc,ofatParamString,...
    plotType,singleX,singleY,sourceRadius,innerCatchRadius,outerCatchRadius,parameterValues)
end
if extrasSwitch==1
%% Show the placement of the agents of interest

subplot(1,1,4)=PDFfig;
testHist=histfit(RadialMaxVals);
createHistPlotFigure
normHistFigName=strcat(imagePreName,'NormalHistFitAttempt.fig');
normHistJPGName=strcat(imagePreName,'NormalHistFitAttempt.png');
savefig(testHist,normHistFigName,'compact');
saveas(testHist,normHistJPGName);
testQQplot=qqplot(RadialMaxVals,pd);
normQQFigName=strcat(imagePreName,'NormalQQFitAttempt.fig');
normQQJPGName=strcat(imagePreName,'NormalQQFitAttempt.png');
savefig(testQQplot,normQQFigName,'compact');
saveas(testQQplot,normQQJPGName);
%% Left off here.  Grab each coordinate and make a highest-lowest plot of
% location to distance traveled, both average and individual as our goal.  Need the distance matrix.%
pd = fitdist(RadialMaxVals,'Kernel','Kernel','epanechnikov');
methods(pd);
ci95 = paramci(pd);
ci99 = paramci(pd,'Alpha',0.01);
RadialMaxVals_values = 50:1:250;
y = pdf(pd,RadialMaxVals_values);
createPdfPlotFigure(RadialMaxVals_values,y)
histfit(RadialMaxVals)
qqplot(x,pd)

boxplot(RadialMaxVals)
hold on
scatter(RiverCoords(:,1),RiverCoords(:,2),24,'blue','filled')
scatter(BirthCoordsNeighbors{distCount1,2}(:,1),BirthCoordsNeighbors{distCount1,2}(:,2))
hold off


%% Create histogram2 of A.DeathCoords_1 and A.DeathCoords_2
h = histogram2(A.DeathCoords_1,A.DeathCoords_2,'DisplayName','DeathCoords_2');

% Add xlabel, ylabel, title, and legend
xlabel('DeathCoords_1')
ylabel('DeathCoords_2')
title('DeathCoords_1 vs. DeathCoords_2')
legend
end
end
end