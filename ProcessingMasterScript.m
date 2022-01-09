function ProcessingMasterScript()
    %% Notes for tomorrow: Currnetly param values set to one value.  Need to go through and change to eat variable vals.
    clc
    clear
    singleSwitch=1;
    %% Single OFAT Grab
    if singleSwitch==1
        landData='CoweetaLandscapeNumericMatrices.mat';
        landscapeName='CoweetaLandscapeWithRiverandQuiverData';
        singleOFATFilename="SimResults\CoweetaCollection\InfoHolderForImagingTests\E1e5R1e5Pd1e-5";
        singlePBFilename="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\InfoHolderForImagingTests\E1e5R1e5Pd1e-5\ProbBirth_0.01";
        ofatParamString="E1e5R1e5Pd1e-5\";
        graphFilename="C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\InfoHolderForImagingTests\ImageResults\";
%         singleFileMatToCSV(singlePBFilename);
        [NamesandParamsTable] = buildParamArrayFromSingleCollectedFiles(singleOFATFilename,ofatParamString);
        creatingTablesFromUnprocessedDataSingleFile(NamesandParamsTable,singlePBFilename);
        [UpdatedNamesandParamsTable] = combiningTablesFromOFATSingleData(NamesandParamsTable,singleOFATFilename);
        singleFileVisualize(UpdatedNamesandParamsTable,landData,landscapeName,ofatParamString,graphFilename)
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