%% plotType = 1  ---> 2d plot of nbhds
%% plotType = 2  ---> 1 unit above z axis 3-d scat of nbhds
%% plotType = 3  ---> Nbhds plotted with elevation values

function ProcessingMasterScript()
    %% Notes for tomorrow: Currently param values set to one value.  Need to go through and change to eat variable vals.
    clc
    clear
    singleSwitch=1;
    %% Single OFAT Grab  E1e-3R1e-3Pd1e-3
        landData='CoweetaLandscapeNumericMatrices.mat';
        landscapeName='CoweetaLandscapeWithRiver';
        %% Single Beginning NBHD from Homo Spread Random Walk Runs

        % Filenames

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Plot ags against structure using homogeneous source %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if singleSwitch==1
        runType="Homogeneous Spread";
        singleGraphFilename="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\InfoHolderForImagingTests\HomoSpreadSource\";
        singleOFATFilename="SimResults\CoweetaCollection\InfoHolderForImagingTests\HomoSpreadSource\E1e5R1e5Pd1e-5";
        singlePBFilename="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\InfoHolderForImagingTests\HomoSpreadSource\E1e5R1e5Pd1e-5\ProbBirth_0.01";
        ofatParamString="E1e5R1e5Pd1e-5\";
        imageStorLoc='Images\FebruaryRunProcessingImages\';
        resultsTable='SimResults\CollectedResults.csv';

        plotType=1;
        %Single Point and radii settings
        singleX=392;
        singleY=405;
        sourceRadius=5;
        innerCatchRadius=240;
        outerCatchRadius=260;
        graphFilename="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\InfoHolderForImagingTests\ImageResults\";
        
%         [resultsTable]=resultsRetrieval(resultsTable,singleX,singleY,sourceRadius,innerCatchRadius,outerCatchRadius,singlePBFilename,graphFilename);
%         singleFileMatToCSV(singlePBFilename);
        [NamesandParamsTable] = buildParamArrayFromSingleCollectedFiles(singleOFATFilename,ofatParamString);
        creatingTablesFromUnprocessedDataSingleFile(NamesandParamsTable,singlePBFilename);
        [UpdatedNamesandParamsTable] = combiningTablesFromOFATSingleData(NamesandParamsTable,singleOFATFilename);
        singleFileVisualize(UpdatedNamesandParamsTable,landData,landscapeName,ofatParamString,graphFilename,singleGraphFilename,imageStorLoc,...
            plotType,singleX,singleY,sourceRadius,innerCatchRadius,outerCatchRadius)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Plot ags against structure using single source  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif singleSwitch==2

        singleGraphFilename="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\FebruaryRuns2\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\";
        singleOFATFilename="SimResults\FebruaryRuns\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\E1e-3R1e-3Pd1e-3";
        singlePBFilename="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\InfoHolderForImagingTests\Single6MouthSource\E1e-3R1e-3Pd1e-3\ProbBirth_0.01";
        ofatParamString="E1e-3R1e-3Pd1e-3\";
        plotType=1;
        
        
        %Single Point and radii settings
        singleX=392;
        singleY=405;
        sourceRadius=5;
        innerCatchRadius=240;
        outerCatchRadius=260;
        graphFilename="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\InfoHolderForImagingTests\ImageResults\";
%         singleFileMatToCSV(singlePBFilename);
        [NamesandParamsTable] = buildParamArrayFromSingleCollectedFiles(singleOFATFilename,ofatParamString);
        creatingTablesFromUnprocessedDataSingleFile(NamesandParamsTable,singlePBFilename);
        [UpdatedNamesandParamsTable] = combiningTablesFromOFATSingleData(NamesandParamsTable,singleOFATFilename);
        singleFileVisualize(UpdatedNamesandParamsTable,landData,landscapeName,ofatParamString,graphFilename,singleGraphFilename,...
            plotType,singleX,singleY,sourceRadius,innerCatchRadius,outerCatchRadius)

        %% Homogeneous Highly Deterministic Runs
%         singleOFATFilename="SimResults\CoweetaCollection\InfoHolderForImagingTests\E1e-3R1e-3Pd1e-3";
%         singlePBFilename="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\InfoHolderForImagingTests\E1e-3R1e-3Pd1e-3\ProbBirth_0.01";
%         ofatParamString="E1e-3R1e-3Pd1e-3\";

        graphFilename="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\InfoHolderForImagingTests\ImageResults\";
%         singleFileMatToCSV(singlePBFilename);
        [NamesandParamsTable] = buildParamArrayFromSingleCollectedFiles(singleOFATFilename,ofatParamString);
        creatingTablesFromUnprocessedDataSingleFile(NamesandParamsTable,singlePBFilename);
        [UpdatedNamesandParamsTable] = combiningTablesFromOFATSingleData(NamesandParamsTable,singleOFATFilename);
        singleFileVisualize(UpdatedNamesandParamsTable,landData,landscapeName,ofatParamString,graphFilename,singleGraphFilename)
    %% Structure Build all files
    else
        %% Compile Folder Structures
        [FilesRequiringMoving,AllCollectedFolds,ProcessedFolds,CoweetaCollectedNeedProcessing]=filterStruc();
        %% Move Sample Data
        %         renameFilesWithoutTimestamps(FilesRequiringMoving);
        %% Build Array for Param Recall
        [NamesandParamsTable] = buildParamArrayFromCollectedFiles();
        %% Collected Coweeta .mat to .csv
        [PreResultsStructure]=creatingTablesFromUnprocessedData(NamesandParamsTable);
        %% Create Table of CSV Files and Param Vals into combined and singular
        combiningTablesFromData(PreResultsStructure)
        %% CSV to population data

        %% Results
        %% 1 Sample: Max/time, Death/time, Boundary Perforers Density/time, Boundary Agents escape times/locations
        % Results should contain all values and possible
        % time-controlled elements

        %% One Parameter Set: Anova Tests, BoxPlots, Comparison values

        %% OFAT Results:  Boxplot Compare Results, Anova results

        %%
    end