function [] = ...
        MultiDimensionalFigureGenerator(testFigSaveFolder,testImagesSaveFolder,saveFileName,PhysFactorNames,BioFactorNames,titleTopLineFrontPiece,...
        ArrayOfInterest,TotalMatrix,AllDeathCountMat,BioChoice1,BioChoice2,TChoice1,TChoice2,singleHomoSwitch)
    if ~isfile([testImagesSaveFolder saveFileName 'ReproAgHist2.jpg'])
        load('LandandAltGrids.mat','altLandGrid','landGrid');
        red = [1, 0, 0];
        pink = [255, 192, 203]/255;
        orange=[251, 98, 5]/255;
        green=[94 223 12]/255;
        myBlue=[57 168 251]/255;
        BirthBiVarDistBotCol=[0 0 255]/255;
        BirthBiVarDistTopCol=[0 255 255]/255;
        gray='#9B9B9B';
        %% Size of vectors of interest.  Currently set to successful births (length) and #locations (length2)
        maxTime=max(ArrayOfInterest(:,end));
        length=size(ArrayOfInterest(:,6),1);
        A=ArrayOfInterest(:,6:7);
        B=unique(A,'rows');
        binsYRows=max(B(:,1))-min(B(:,1));
        binsXCols=max(B(:,2))-min(B(:,2));
        length2=size(B,1);
        a=max(max(TotalMatrix));
        TotalPopSize=sum(sum(AllDeathCountMat));
        PercentBirthsOfTotal=roundn((100*length/TotalPopSize),-2);
        
%%%%%%%%%%%%%%%%%%%%%%%%% Come Back here to fix label indices %%%%%%%%%%%%%%%%%%%%%%%%%        
        linSpacePercentInterval=roundn(a/(length*10),-3);%
        linSpaceEndPercent=roundn(a/(length),-4);
        linSpaceLabels=100*(0:linSpacePercentInterval:linSpaceEndPercent);
        
        linSpaceEnd=roundn(a,(floor(log10(a+1))-1));%
        
        %% Color vectors for scatter/hist work
        colors_Bound = [linspace(red(1),pink(1),length)', linspace(red(2),pink(2),length)',...
            linspace(red(3),pink(3),length)'];
        colors_SpawnLoc = [linspace(orange(1),orange(1),length)',...
            linspace(orange(2),orange(2),length)',...
            linspace(orange(3),orange(3),length)'];
        colors_BirthBiVarDist = [linspace(BirthBiVarDistBotCol(1),BirthBiVarDistTopCol(1),length2)',...
            linspace(BirthBiVarDistBotCol(2),BirthBiVarDistTopCol(2),length2)',...
            linspace(BirthBiVarDistBotCol(3),BirthBiVarDistTopCol(3),length2)'];
        %% Graph generation for 3-d histogram evaluation
        
        
        
        reproAgsFig=figure('Name','Successful Reproduction Agents Infographic',...
            'NumberTitle','off');
        % Set up figure properties:
        % Enlarge figure to full screen.
        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
        % Get rid of tool bar and pulldown menus that are along top of figure.
        set(gcf,'Color','w');
%         set(gca,'color',gray)
        hold on
        grid on
        [LandCont,contH]=contour(altLandGrid,'showtext','on');
        contH.LineWidth = 0.5;
        clabel(LandCont,contH,'FontSize',10,'color','k','FontSmoothing','on','LabelSpacing',200)
        [rivRowY,rivColX]=find(landGrid==1);
        rivScat=scatter(rivColX,rivRowY,8,'MarkerEdgeColor',myBlue,'MarkerFaceColor',myBlue);
        if singleHomoSwitch==1
        SpawnLocScat1=scatter(ArrayOfInterest(:,4),ArrayOfInterest(:,5),186,'k','filled','p');
        elseif singleHomoSwitch==2
        SpawnLocScat1=scatter(ArrayOfInterest(:,4),ArrayOfInterest(:,5),24,'k','filled','p');
        end
        %     SpawnLocScat2=scatter(MatrixOfInterest(:,4),MatrixOfInterest(:,5),168,'y','filled','p');
        PopDistHist=histogram2(ArrayOfInterest(:,6),ArrayOfInterest(:,7),[binsYRows binsXCols],'BinMethod','integers','DisplayStyle','bar3','FaceColor','flat','EdgeAlpha',0.5);
        %                                 the following line skip the name of the previous plot from the legend
        PopDistHist.Annotation.LegendInformation.IconDisplayStyle = 'off';
        
         %% Figure out shadow on back panel
%         shading interp 
%         shadowplot x
        lgd=legend('Elevation Contour Isolines (meters above sea level).','The Coweeta river network.','Spawn Location.');
        
        PopC=colorbar;
        w = PopC.LineWidth;
        PopC.LineWidth = 1.5;
        PopC.Ticks = linspace(0,linSpaceEnd,size(linSpaceLabels,2)); %Create 8 ticks from zero to 1
        PopC.TickLabels = num2cell(linSpaceLabels) ;
        PopC.Label.String = 'Percentage of reproducing population.';
        pos = get(PopC,'Position');
        view(-10, 50);
        
        titleName=strcat({[titleTopLineFrontPiece, ' with ~',num2str(PercentBirthsOfTotal) ,'% of the population reproducing.']
            [num2str(length) ' successful agents out of a population of ' num2str(TotalPopSize) '.  Longest lifespan: ' num2str(maxTime) ' seconds.']
            ['Elevation: ' PhysFactorNames{TChoice1} '. River: ' PhysFactorNames{TChoice2} '.']
            ['Environment Lethality: ' BioFactorNames{BioChoice1} '. Chance of Reproduction: ' BioFactorNames{BioChoice2} '.']
            });
        
        lgd.Location='northwest';
        %     lgd.Orientation='horizontal';
        
        title(titleName)
        xlabel('Lattitude (meters)')
        ylabel('Longitude (meters)')
        %                                 ylabel.orientation='vertical';
        zlabel('Number of reproducing agents')
        hold off
        
        savefig(reproAgsFig,[testFigSaveFolder saveFileName 'ReproAgHist2.fig'],'compact');
        saveas(reproAgsFig,[testImagesSaveFolder saveFileName 'ReproAgHist2.jpg'],'jpg');
        close(reproAgsFig)
    end
end