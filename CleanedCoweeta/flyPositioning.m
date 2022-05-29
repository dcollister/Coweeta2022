function [x, y, gender, geneticPool,maxPositions] = flyPositioning(flyPopulationSize,coordinates,riverBranchNumber)
randPosNeg = [-1 1];
pos = randi(length(randPosNeg));
randomUnit = randPosNeg(pos);
gender=zeros(flyPopulationSize,1);
geneticPool=zeros(flyPopulationSize,1);
x=zeros(flyPopulationSize,1);
y=zeros(flyPopulationSize,1);
n=1;
%1-2 min x coords, 3-4 max x coords, 5-6 min y coords, 7-8 max y coords, 9
%max radial value from starting location, 10-11 max coords, 12-13 birth
%coords, 14-15 death coords, 16 repro counter, 17 Agent ID, 18 River Branch
%ID, #19 Gender id, #20 Genetic Pool
variableNames={'XminCoords','XMaxCoords','YMinCoords','YMaxCoords','RadialMaxCoords','RMaxCoords',...
        'BirthCoords','DeathCoords','ReproCounter','AgentID','BeginningBranch','Gender','GenePool',...
        'XminTime','XMaxTime','YMinTime','YMaxTime','RadialMaxTime','DeathTime','BoundaryDeathTime','ReproDeathTime'};
variableIndicies={[1:2],[3:4],[5:6],[7:8],9,[10:11],[12:13],[14:15],16,17,18,19,20,21,22,23,24,25,26,27,28};
maxPositions=zeros(flyPopulationSize,28);
    for i=1:flyPopulationSize
        run=randi([1 size(coordinates,1)]);
        x(i)=coordinates(run,1);
        maxPositions(i,1)=x(i);maxPositions(i,3)=x(i);maxPositions(i,5)=x(i);maxPositions(i,7)=x(i);
        y(i)=coordinates(run,2);
        maxPositions(i,2)=y(i);maxPositions(i,4)=y(i);maxPositions(i,6)=y(i);maxPositions(i,8)=y(i);
        maxPositions(i,9)=sqrt(((maxPositions(i,1)-x(i))^2)+(maxPositions(i,2)-y(i))^2);
        maxPositions(i,10:11)=[x(i),y(i)];
        maxPositions(i,12:13)=[x(i),y(i)];
        maxPositions(i,14:15)=[x(i),y(i)];
        maxPositions(i,16)=0;
        maxPositions(i,17)=i;
        maxPositions(i,18)=0;%riverBranchNumber;
        n=n+1;
        gender(i)=randomUnit;
        geneticPool(i)=0;
        maxPositions(i,19)=gender(i);
        maxPositions(i,20)=geneticPool(i);
        maxPositions(i,21:28)=0;
    end
    
end
   