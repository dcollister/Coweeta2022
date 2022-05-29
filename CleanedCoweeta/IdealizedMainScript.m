function [filenameholder,xMin,xMax,yMin,yMax,radialDistMax,maxPositions]=...
        IdealizedMainScript(shapefile,altfile,pb,pd,nmoves,altprobcoeff,type,...
        upcoeff,probtype,bias,coords,filename,fileHolder,time,popSize)
%probtype=1 -->linear, 2-->exponential
%bias=1 --> upriver, -1 --> downriver
	eggtime=0; %time spent as egg/larvae
	if type==7 || type==2 || type==8
		gridType={type,shapefile,altfile,eggtime,upcoeff};%shape+altitude+streamorder+eggs+upstreamonriver
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
	[filenameholder,xMin,xMax,yMin,yMax,radialDistMax,maxPositions]=...
        IdealizedFlyRiverMain(gridType,pb,pd,numberOfKids,simulationTimeLength,flyPopulationSize,nmoves,altprobcoeff,cutoffpop,...
        profileswitch, timingswitch,strengthFactor,riverCurrent,eggsPopulationSize,probtype,bias,coords,filename,fileHolder);
end