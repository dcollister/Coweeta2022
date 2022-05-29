function [popName,saverStringPopName]=populationTypeStringTempGen(name)
    if contains(name,'All')
        popName=' All Agents';
        saverStringPopName='AllAgents';
    elseif contains(name,'Bound')
        popName=' Boundary Agents';
        saverStringPopName='BoundAgents';
    elseif contains(name,'Repro')
        popName=' Successfully Reproducing Agents';
        saverStringPopName='ReproAgents';
    elseif contains(name,'NonRNonB')
        popName=' Natural deaths excluding Reproduction and Boundary Agents';
        saverStringPopName='NonRNonBAgents';
    end
end