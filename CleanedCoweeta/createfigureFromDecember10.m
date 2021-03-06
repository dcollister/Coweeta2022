function createfigureFromDecember10(X1, Y1, X2, Y2)
    %CREATEFIGURE(X1, Y1, X2, Y2)
    %  X1:  vector of x data
    %  Y1:  vector of y data
    %  X2:  vector of x data
    %  Y2:  vector of y data

    %  Auto-generated by MATLAB on 10-Dec-2021 08:32:05

    % Create figure
    figure1 = figure('WindowState','maximized');

    % Create axes
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');

    % Create plot
    plot(X1,Y1,'ZDataSource','','DisplayName','Mean =269.1725\newlineStand. Dev. =145.706','Parent',axes1,...
        'MarkerFaceColor',[0 0.447058823529412 0.741176470588235]);

    % Create ylabel
    ylabel({'Percentage of population'});

    % Create xlabel
    xlabel({'Maximum Distance in Meters'});

    % Create title
    title('Normal pdf fitting plot of Maximum Distances for All Agents');

    % Uncomment the following line to preserve the X-limits of the axes
    % xlim(axes1,[0 1000]);
    % Uncomment the following line to preserve the Y-limits of the axes
    % ylim(axes1,[0 0.003]);
    box(axes1,'on');
    hold(axes1,'off');
    % Set the remaining axes properties
    set(axes1,'DataAspectRatio',[333333.333333333 1 666.666666666667],'XTick',[0 200 400 600 800 1000],'YTick',...
        [0 0.0005 0.001 0.0015 0.002 0.0025 0.003]);
    % Create legend
    legend(axes1,'show');

    % Create axes
    axes2 = axes('Parent',figure1);
    axis off
    hold(axes2,'on');

    % Create plot
    plot(X2,Y2,'ZDataSource','','Parent',axes2);

    % Uncomment the following line to preserve the X-limits of the axes
    % xlim(axes2,[0 1000]);
    % Uncomment the following line to preserve the Y-limits of the axes
    % ylim(axes2,[0 0.003]);
    box(axes2,'on');
    hold(axes2,'off');
    % Set the remaining axes properties
    set(axes2,'DataAspectRatio',[333333.333333333 1 666.666666666667],'XTick',[0 200 400 600 800 1000],'YTick',...
        [0 0.0005 0.001 0.0015 0.002 0.0025 0.003]);
