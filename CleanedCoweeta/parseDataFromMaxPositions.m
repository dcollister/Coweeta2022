 function parseDataFromMaxPositions()

    fileShell='SimResults\CoweetaCollection\';
    landType=C;
    TableTypeNames={'Single','Combined'};
    UAVarNames={'Filename','AllAgents','ReproAgents','BoundAgents','NonRNonBAgents'};
    UAVarTypes={'string','table','table','table','table'};
    AgentNames={'AllAgents','ReproAgents','BoundAgents','NonRNonBAgents'};
    EventNames={'Birth','Max','Death'};
    MeasurementNames={'Values','Locations','Times'};
    ParamNames={'Width','T_Elevation','T_River','Pd','Pb'};
    variableNames={'XminCoords','XMaxCoords','YMinCoords','YMaxCoords','RadialMaxCoords','RMaxCoords',...
        'BirthCoords','DeathCoords','ReproCounter','AgentID','BeginningBranch','Gender','GenePool',...
        'XminTime','XMaxTime','YMinTime','YMaxTime','RadialMaxTime','DeathTime','BoundaryDeathTime','ReproDeathTime'};
    variableIndicies={[1:2],[3:4],[5:6],[7:8],9,[10:11],[12:13],[14:15],16,17,18,19,20,21,22,23,24,25,26,27,28};
    AgentVarIndices={12:13 9 10:11 25 14:15 26};


end
