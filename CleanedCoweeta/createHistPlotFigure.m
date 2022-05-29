function createHistPlotFigure(X1, Y1,figname,picname,pd,TitleString,meanVal)
    meanValVec=repmat(meanVal,1,width(X1));
    %CREATEFIGURE(X1, Y1)
    %  X1:  vector of x data
    %  Y1:  vector of y data

    %  Auto-generated by MATLAB on 09-Dec-2021 14:32:00

    % Create figure
    figure1 = figure('WindowState','maximized');

    % Create axes
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');
    % Create plot
    hold on
    a1=plot(X1,Y1,'ZDataSource','','DisplayName','pdf FunctionNameHolder','MarkerFaceColor',[0 0.447058823529412 0.741176470588235]);
%     a2=plot(meanValVec,X1);
    hold off
    % Create ylabel
    ylabel({'Percentage of population'});

    % Create xlabel
    xlabel({'Maximum Distance in Meters'});

    % Create title
    title(TitleString);
    muString=strcat('Mu = ',num2str(pd.mu));
    SigmaString=strcat('Sigma = ',num2str(pd.sigma));
    LegendLabelTemp=strcat(muString, '\newline', SigmaString);
    legend(axes1,a1,LegendLabelTemp,'show');%,['Mean =' num2str(meanVal)]}
    box(axes1,'on');
    hold(axes1,'off');
savefig(figure1,figname,'compact');
saveas(figure1,picname);

