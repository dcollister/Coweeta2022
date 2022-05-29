function scatPlotComp(inputs,a,river)
   
    hold on 
    contour(river);
    %ending positions
    scatter(inputs(:,a(1)),inputs(:,a(2)));
    %beginning positions
    scatter(inputs(:,a(3)),inputs(:,a(4)),'filled','blue');
    hold off 
    
end