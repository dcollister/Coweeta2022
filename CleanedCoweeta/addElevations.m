function agentMat=addElevations(agentMat,altGrid)
agentMat.RadialMaxEle=altGrid(sub2ind(size(altGrid),agentMat{:,'RMaxCoords_2'},agentMat{:,'RMaxCoords_1'}));
agentMat.DeathEle=altGrid(sub2ind(size(altGrid),agentMat{:,'DeathCoords_2'},agentMat{:,'DeathCoords_1'}));
agentMat.BirthEle=altGrid(sub2ind(size(altGrid),agentMat{:,'BirthCoords_2'},agentMat{:,'BirthCoords_1'}));

agentMat.XDeathVec=agentMat.DeathCoords_1-agentMat.BirthCoords_1;
agentMat.YDeathVec=agentMat.DeathCoords_2-agentMat.BirthCoords_2;
agentMat.EleDeathVec=agentMat.DeathEle-agentMat.BirthEle;
agentMat.XMaxVec=agentMat.RMaxCoords_1-agentMat.BirthCoords_1;
agentMat.YMaxVec=agentMat.RMaxCoords_2-agentMat.BirthCoords_2;
agentMat.EleMaxVec=agentMat.RadialMaxEle-agentMat.BirthEle;
end