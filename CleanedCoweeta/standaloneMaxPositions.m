
variableNames={'XminCoords','XMaxCoords','YMinCoords','YMaxCoords','RadialMaxCoords','RMaxCoords',...
        'BirthCoords','DeathCoords','ReproCounter','AgentID','BeginningBranch','Gender','GenePool',...
        'XminTime','XMaxTime','YMinTime','YMaxTime','RadialMaxTime','DeathTime','BoundaryDeathTime','ReproDeathTime'};
    variableIndicies={[1:2],[3:4],[5:6],[7:8],9,[10:11],[12:13],[14:15],16,17,18,19,20,21,22,23,24,25,26,27,28};
    for count=1:width(variableIndicies)
                                XminCoords=MaxPositions(indArray{TablesCount},variableIndicies{1});
                                XMaxCoords=MaxPositions(indArray{TablesCount},variableIndicies{2});
                                YMinCoords=MaxPositions(indArray{TablesCount},variableIndicies{3});
                                YMaxCoords=MaxPositions(indArray{TablesCount},variableIndicies{4});
                                RadialMaxCoords=MaxPositions(indArray{TablesCount},variableIndicies{5});
                                RMaxCoords=MaxPositions(indArray{TablesCount},variableIndicies{6});
                                BirthCoords=MaxPositions(indArray{TablesCount},variableIndicies{7});
                                DeathCoords=MaxPositions(indArray{TablesCount},variableIndicies{8});
                                ReproCounter=MaxPositions(indArray{TablesCount},variableIndicies{9});
                                AgentID=MaxPositions(indArray{TablesCount},variableIndicies{10});
                                BeginningBranch=MaxPositions(indArray{TablesCount},variableIndicies{11});
                                Gender=MaxPositions(indArray{TablesCount},variableIndicies{12});
                                GenePool=MaxPositions(indArray{TablesCount},variableIndicies{13});
                                XMinTime=MaxPositions(indArray{TablesCount},variableIndicies{14});
                                XMaxTime=MaxPositions(indArray{TablesCount},variableIndicies{15});
                                YMinTime=MaxPositions(indArray{TablesCount},variableIndicies{16});
                                YMaxTime=MaxPositions(indArray{TablesCount},variableIndicies{17});
                                RadialMaxTime=MaxPositions(indArray{TablesCount},variableIndicies{18});
                                DeathTime=MaxPositions(indArray{TablesCount},variableIndicies{19});
                                BoundaryDeathTime=MaxPositions(indArray{TablesCount},variableIndicies{20});
                                ReproDeathTime=MaxPositions(indArray{TablesCount},variableIndicies{21});

    end
MaxPositions.variableNames{count}=maxPositions(:,variableIndicies(count,:));
MaxPositions.var