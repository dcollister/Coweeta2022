function testing(numID)
    
    Current=shaperead('Coweeta/coweetaProject.shp');
    
    save(['ThisWorksNumber',num2str(numID)],'Current')
end