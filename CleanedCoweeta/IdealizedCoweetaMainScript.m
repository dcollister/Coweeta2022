 function [filenameholder,maxPositions]=...
        IdealizedCoweetaMainScript(shapefile,altfile,pb,pd,nmoves,altprobcoeff,type,...
            upcoeff,probtype,bias,coords,fileHolder,filename,time,popSize,preWeights,name,runType,...
            NormedName,wholesaveToggle,riverBranchNumber)
%probtype=1 -->linear, 2-->exponential
%bias=1 --> upriver, -1 --> downriver
	eggtime=0; %time spent as egg/larvae
	if type==7 || type==2 
		gridType={type,shapefile,altfile,eggtime,upcoeff};%shape+altitude+streamorder+eggs+upstreamonriver
    elseif type==8
        gridType={type,shapefile,altfile,eggtime,upcoeff,preWeights};
    else
		gridType={type,shapefile,altfile,eggtime};%shape+altitude+streamorder+eggs
	end
	%pb=0.0059;%probability of birth when on water
	%pd=0.0118;%probability of death
	numberOfKids=0;%egg surviving
	simulationTimeLength=time;
	flyPopulationSize=popSize;
	eggsPopulationSize=0;
	%nmoves=1;%number of motion moves per time step (adults)
	%altprobcoeff=0.5;%0.1;%strength of altitude effect (adults)
	cutoffpop=3000000;
	profileswitch=0;
	timingswitch=1;
    strengthFactor=10;%river strength (eggs)
    riverCurrent=0;%not yet used
	[filenameholder,maxPositions]=...
        IdealizedFlyRiverMain(gridType,pb,pd,numberOfKids,simulationTimeLength,flyPopulationSize,...
            nmoves,altprobcoeff,cutoffpop,profileswitch, timingswitch,strengthFactor,riverCurrent,...
            eggsPopulationSize,probtype,bias,coords,fileHolder,filename,name,runType,NormedName,wholesaveToggle,riverBranchNumber);
end