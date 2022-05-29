function [images,images2] = FrancescoCoweetaGifGenerator(River,Elevation,name)
% name=strcat(name,'_upcoeff_*_bias_*.mat');
%name='Trough_size_1001x1001_width_31_buffer_100March_03_2020_ 7_17_54_405_PM_upcoeff_10_bias_10.mat';
% fileList = dir(name);
%     numfile=length(fileList);
%     for file=1:numfile
%         filename=fileList(file).name(1:end-4);
        load(name);
%         load(('IdealizedGeometries/Wedge_size_1001x1001_width_51_buffer_100.mat'),'River','Elevation')
    images=cell(simulationTimeLength,1);
    images2=cell(simulationTimeLength,1);
h = figure;
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
%bias=1;
probtype=1;
axis tight manual % this ensures that getframe() returns a consistent size
%if gridType{5}>0
    RiverBias='T=100';
%elseif gridType{5}<0
    %RiverBias='downstream';
%else
    %RiverBias='no stream bias';
%end

% if bias>0
    ElevationBias='T=1';
% elseif bias<0
%     ElevationBias='uphill';
% else
%     ElevationBias='no elevation bias';
% end


% if probtype==1
    probability='Ising Model';
% else
%     probability='exponential';
% end

filename = strcat('Elevation bias_',num2str(bias),ElevationBias,'River bias_',num2str(gridType{5}),RiverBias, '.gif');
xlabel('X coordinate');
ylabel('Y coordinate');
movieend=simulationTimeLength;%simulationTimeLength;

% [A,cmap]=imread('Coweeta/coweeta1.tif');
contour(Elevation);
colorbar;
hold on;
cont=contour(River);
axis([0 size(River,2) 0 size(River,1)]);
for i=1:movieend+1
    if ~isempty(simdata{i})
        countercounter=1;
            [checkR,checkC]=find(birthInformation(:,1)>=i);
            for repAgentCount=1:size(checkR,1)
            reproAgents(countercounter,:)=birthInformation(checkR(repAgentCount,1),:);
            countercounter=countercounter+1;
            end
            reproAgents=sortrows(reproAgents,9);
        countercountercounter=1;
        reproAgentsScatterImage=zeros(1,9);
        for reproID=1:size(simdata{i},1)
            if simdata{1,i}(reproID,9)==reproAgents(countercountercounter,9)
            reproAgentsScatterImage(countercountercounter,:)=simdata{i}(reproID,:);
            countercountercounter=countercountercounter+1;
            end
            
        end
            
            
        title(['Fly population on River after ' num2str(i-1) ' hours']); 
        xlabel('X coordinate');
        ylabel('Y coordinate');
        scat=scatter(simdata{i}(:,1),simdata{i}(:,2),'filled','b','MarkerEdgeColor','b');
        scat2=scatter(reproAgentsScatterImage(:,1),reproAgentsScatterImage(:,2),'MarkerEdgeColor','black');
        if ~isempty(simeggdata{i})
            scategg=scatter(simeggdata{i}(:,1),simeggdata{i}(:,2),'MarkerEdgeColor','r');
        end
        grid on
        %legend({'River','Flies','Larvae/Eggs'});
        drawnow 
        % Capture the plot as an image 
        frame = getframe(h); 
        im = frame2im(frame); 
        images{i}=im;
        [imind,cm] = rgb2ind(im,256); 
        % Write to the GIF File 
        if i == 1 
        imwrite(imind,cm,filename,'gif','DelayTime',0.1, 'Loopcount',inf); 
        else 
        imwrite(imind,cm,filename,'gif','DelayTime',0.1,'WriteMode','append'); 
        end
        
        if i~=simulationTimeLength+1
            delete(scat)
            delete(scat2)
            
            if ~isempty(simeggdata{i})
                delete(scategg)
            end
        end
    elseif isempty(simeggdata{i})
        break;
    end
    pause(0.01)
end
hold off
%     end