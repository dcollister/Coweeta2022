function searchResults()
elevationChoice=1;riverChoice=1;

ElSettings = ["_ET_0.01_", "_ET_10_", "_ET_1_", "_ET_1.01_", "_ET_10_", "_ET_100_", "_ET_1000_", "_ET_10000_", "_ET_100000_"];
RivSettings = ["_RT_0.01", "_RT_10", "_RT_1", "_RT_1.01", "_RT_10", "_RT_100", "_RT_1000", "_RT_10000", "_RT_100000"];

structureString='SimResults\ResultsStructure.mat';
resultsStructure=retrieveCoweetaDataStructure(structureString);
fnames=fieldnames(resultsStructure);

data=struct2table(resultsStructure);
idx = cellfun(@ischar,data{:,'SimulationName'}) ;
data{~idx,'SimulationName'} = {''};
testNames=data{:,'SimulationName'};str = convertCharsToStrings(testNames);

ELidx=contains(str,ElSettings(elevationChoice));
RIVidx=contains(str,RivSettings(riverChoice));
idx=and(ELidx,RIVidx);

data.SimulationName = categorical(data.SimulationName);
yourData=data(idx,:);

end
%
% [resultsOut] = convertResults(resultsIn,fnames)
% 
% d = cell2struct(struct2cell(resultsStructure.case),fieldnames(resultsStructure.case));
% for i=1:height(fnames)
% newResultsStructure.fnames{i}(2:end-1)
% end