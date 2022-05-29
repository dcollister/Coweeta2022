function []=MaxPositionsToTables(maxPositions)
                    AgentTypes=["" "Reproducing Agent" "Boundary Escape" "Death From Environment"] ;  
    variableIndicies={[1:2],[3:4],[5:6],[7:8],9,[10:11],[12:13],[14:15],16,17,18,19,20,21,22,23,24,25,26,27,28};
    variableNames={'XminCoords','XMaxCoords','YMinCoords','YMaxCoords','RadialMaxCoords','RMaxCoords',...
        'BirthCoords','DeathCoords','ReproCounter','AgentID','BeginningBranch','Gender','GenePool',...
        'XminTime','XMaxTime','YMinTime','YMaxTime','RadialMaxTime','DeathTime','BoundaryDeathTime','ReproDeathTime'};


                        idAll = maxPositions(:,9)>=0;
                        idRepro = maxPositions(:,16)>0;
                        idBound = maxPositions(:,27)>0;
                        idNonRNonB = ( ~idRepro & ~idBound );

                        IDAll=find(idAll);
                        IDRepro=find(idRepro);
                        IDBound=find(idBound);
                        IDNonRNonB=find(idNonRNonB);
                        indCount2=zeros(4,1);

                        if ~isempty(IDAll)
                            indArray{1}=IDAll;
                            indCount2(1)=1;
                        end
                        if ~isempty(IDRepro)
                            indArray{2}=IDRepro;
                            indCount2(2)=1;
                        end
                        if ~isempty(IDBound)
                            indArray{3}=IDBound;
                            indCount2(3)=1;
                        end
                        if ~isempty(IDNonRNonB)
                            indArray{4}=IDNonRNonB;
                            indCount2(4)=1;
                        end

                        TablesNames={'AllCollectedInformation' 'ReproCollectedInformation' 'BoundCollectedInformation' 'NonRNonBCollectedInformation'};


                        for TablesCount=1:4
                            if indCount2(TablesCount)==1
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
                                % Convert cell to a table and use first row as variable names
                                if TablesCount == 1 && indCount2(TablesCount)==1

                                    AllCollectedInformation=table(XminCoords,XMaxCoords,YMinCoords,YMaxCoords,RadialMaxCoords,RMaxCoords,BirthCoords,DeathCoords,ReproCounter,AgentID,BeginningBranch,Gender,GenePool,XMinTime,XMaxTime,YMinTime,YMaxTime,RadialMaxTime,DeathTime,BoundaryDeathTime,ReproDeathTime);
                                    
                                for typeCount=1:4
                                    AllCollectedInformation.AgentType(indArray{typeCount},1)=AgentTypes(typeCount);
                                end
                                
                                    writetable(AllCollectedInformation,[mainDirContents(runCount).folder '\AllCollectedInformation_' this_folder(1:end-4) '.csv'])
                                    clear XminCoords XMaxCoords YMinCoords YMaxCoords RadialMaxCoords RMaxCoords BirthCoords DeathCoords ReproCounter AgentID BeginningBranch Gender GenePool XMinTime XMaxTime YMinTime YMaxTime RadialMaxTime DeathTime BoundaryDeathTime ReproDeathTime
                                elseif TablesCount == 2 && indCount2(TablesCount)==1

                                    ReproCollectedInformation=table(XminCoords,XMaxCoords,YMinCoords,YMaxCoords,RadialMaxCoords,RMaxCoords,BirthCoords,DeathCoords,ReproCounter,AgentID,BeginningBranch,Gender,GenePool,...
                                        XMinTime,XMaxTime,YMinTime,YMaxTime,RadialMaxTime,DeathTime,BoundaryDeathTime,ReproDeathTime);
                                    
                                    AgsTypeVec=repmat(AgentTypes(2),height(XMinTime),1);
                                    ReproCollectedInformation.AgentType=AgsTypeVec;
                                    
                                    writetable(ReproCollectedInformation,[mainDirContents(runCount).folder '\ReproCollectedInformation_' this_folder(1:end-4) '.csv'])
                                    clear XminCoords XMaxCoords YMinCoords YMaxCoords RadialMaxCoords RMaxCoords BirthCoords DeathCoords ReproCounter AgentID BeginningBranch Gender GenePool XMinTime XMaxTime YMinTime YMaxTime RadialMaxTime DeathTime BoundaryDeathTime ReproDeathTime
                                elseif TablesCount == 3 && indCount2(TablesCount)==1

                                    BoundCollectedInformation=table(XminCoords,XMaxCoords,YMinCoords,YMaxCoords,RadialMaxCoords,RMaxCoords,...
                                        BirthCoords,DeathCoords,ReproCounter,AgentID,BeginningBranch,Gender,GenePool,...
                                        XMinTime,XMaxTime,YMinTime,YMaxTime,RadialMaxTime,DeathTime,BoundaryDeathTime,ReproDeathTime);
                                    
                                    AgsTypeVec=repmat(AgentTypes(3),height(XMinTime),1);
                                    BoundCollectedInformation.AgentType=AgsTypeVec;
                                    writetable(BoundCollectedInformation,[mainDirContents(runCount).folder '\BoundCollectedInformation_' this_folder(1:end-4) '.csv'])
                                    clear XminCoords XMaxCoords YMinCoords YMaxCoords RadialMaxCoords RMaxCoords BirthCoords DeathCoords ReproCounter AgentID BeginningBranch Gender GenePool XMinTime XMaxTime YMinTime YMaxTime RadialMaxTime DeathTime BoundaryDeathTime ReproDeathTime
                                elseif TablesCount == 4 && indCount2(TablesCount)==1

                                    NonRNonBCollectedInformation=table(XminCoords,XMaxCoords,YMinCoords,YMaxCoords,RadialMaxCoords,RMaxCoords,...
                                        BirthCoords,DeathCoords,ReproCounter,AgentID,BeginningBranch,Gender,GenePool,...
                                        XMinTime,XMaxTime,YMinTime,YMaxTime,RadialMaxTime,DeathTime,BoundaryDeathTime,ReproDeathTime);
                                    AgsTypeVec=repmat(AgentTypes(4),height(XMinTime),1);
                                    
                                    NonRNonBCollectedInformation.AgentType=AgsTypeVec;
                                    % Write the table to a CSV file
                                    writetable(NonRNonBCollectedInformation,[mainDirContents(runCount).folder '\NonRNonBCollectedInformation_' this_folder(1:end-4) '.csv'])
                                    clear XminCoords XMaxCoords YMinCoords YMaxCoords RadialMaxCoords RMaxCoords BirthCoords DeathCoords ReproCounter AgentID BeginningBranch Gender GenePool XMinTime XMaxTime YMinTime YMaxTime RadialMaxTime DeathTime BoundaryDeathTime ReproDeathTime
                                end
                            end
                        end
                        end

end