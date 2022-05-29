function []=parseDataFromMatFilesWithoutTimeToTable(mainDirContents,this_folder,ComparisonObject,runCount)
                        variableIndicies={[1:2],[3:4],[5:6],[7:8],9,[10:11],[12:13],[14:15],16,17,18,19,20};
                        Filename=convertCharsToStrings(this_folder);

                        if ~isfile([mainDirContents(runCount).folder '\Fileinfo_' this_folder(1:end-4) '.csv'])
                            Seed=ComparisonObject.s;
                            fileInfo=table(Filename,Seed);
                            writetable(fileInfo,[mainDirContents(runCount).folder '\Fileinfo_' this_folder(1:end-4) '.csv'])

                        idAll = ComparisonObject.maxPositions(:,9)>=0;
                        idRepro = ComparisonObject.maxPositions(:,16)>0;

                        IDAll=find(idAll);
                        IDRepro=find(idRepro);
                        indCount2=zeros(2,1);

                        if ~isempty(IDAll)
                            indArray{1}=IDAll;
                            indCount2(1)=1;
                        end
                        if ~isempty(IDRepro)
                            indArray{2}=IDRepro;
                            indCount2(2)=1;
                        end

                        TablesNames={'AllCollectedInformation' 'ReproCollectedInformation' 'BoundCollectedInformation' 'NonRNonBCollectedInformation'};
                        MaxPositions=ComparisonObject.maxPositions;

                        for TablesCount=1:2
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
                                % Convert cell to a table and use first row as variable names
                                if TablesCount == 1 && indCount2(TablesCount)==1

                                    AllCollectedInformation=table(XminCoords,XMaxCoords,YMinCoords,YMaxCoords,RadialMaxCoords,RMaxCoords,...
                                        BirthCoords,DeathCoords,ReproCounter,AgentID,BeginningBranch,Gender,GenePool);

                                    writetable(AllCollectedInformation,[mainDirContents(runCount).folder '\AllCollectedInformation_' this_folder(1:end-4) '.csv'])
                                elseif TablesCount == 2 && indCount2(TablesCount)==1

                                    ReproCollectedInformation=table(XminCoords,XMaxCoords,YMinCoords,YMaxCoords,RadialMaxCoords,RMaxCoords,...
                                        BirthCoords,DeathCoords,ReproCounter,AgentID,BeginningBranch,Gender,GenePool);

                                    writetable(ReproCollectedInformation,[mainDirContents(runCount).folder '\ReproCollectedInformation_' this_folder(1:end-4) '.csv'])
                                end
                            end
                        end
                        end

end