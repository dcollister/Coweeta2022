function [ResultsStructure]=resultsRetrieval()%%type,position,params

% if ~istable()
ResultsStructure=struct('Run Type','','Source Center',zeros(1,2),'Timestamp','','Tables Location','','Figures Location','','Catch Traps',zeros(1,3),'Results Table',table);
var_type_options={'categorical' 'datetime' 'string' 'double'};
field_names= ["Run Type", "Center", "Parameters", "Timestamp", "Tables Location", "Figures Location"];
field_values={var_type_options{1}, var_type_options{4}, var_type_options{4}, var_type_options{4}, var_type_options{4}, var_type_options{4}, var_type_options{4}, var_type_options{2}, var_type_options{3}, var_type_options{3}};
ResultsTable = table('Size',[1,size(field_names,2)],... 
	'VariableNames', field_names(1,:),...
	'VariableTypes', field_types(1,:));


writeTable(ResultsTable,'SimResults\CollectedResults.csv')
% else
%     readtable();"Neighborhoods",zeros(9,3)

end
%         ResultsTable=table('','','',zeros(1,2),'Parameter Values',zeros(1,4),'Table Locations','string');runType="Homogeneous Spread";
% resultsStructure.RunType='Homogeneous';
% resultsStructure.SourceCenter=[CenterX CenterY];
% resultsStructure.minSourceReproDist=minReproDist;
% resultsStructure.meanSourceReproDist=meanReproDist;
% resultsStructure.meanSourceMaxReproDist=meanMaxReproDist;
% resultsStructure.minSourceCatchReproTime=minCatchReproTime;
% resultsStructure.meanSourceCatchReproTime=meanCatchReproTime;
% resultsStructure.maxSourceCatchReproTime=maxCatchReproTime;
% resultsStructure.minSourceBoundTime=minBoundTime;
% resultsStructure.meanSourceBoundTime=meanBoundTime;
% resultsStructure.maxSourceBoundTime=maxBoundTime;

