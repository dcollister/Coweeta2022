function [agCoords] = agentCoordSettings(shapefile,altfile,AgentSubTypeChoice,OrderedStreamsCounter,...
    BranchChoice,AgentPlacementChoice,coordsFileName,OrderedStreams,InsideOrderCounter)

if isfile(coordsFileName)==0
    if BranchChoice==1

        riverBranchNumber=OrderedStreams{OrderedStreamsCounter}{AgentSubTypeChoice}(InsideOrderCounter);

    elseif BranchChoice==2

        riverBranchNumber=OrderedStreams{OrderedStreamsCounter}{AgentSubTypeChoice};
    else
    end
    if isfile('branchCoords.mat')==0 || AgentPlacementChoice==1
        buffer=1;
        [altGrid,altinfo]=geotiffread(altfile);
        X=altinfo.LongitudeLimits;
        Y=altinfo.LatitudeLimits;
        sizex=size(altGrid,2);
        sizey=size(altGrid,1);
        resx=abs(X(1)-X(2))/sizex;
        resy=abs(Y(1)-Y(2))/sizey;
        if abs(resx-resy)<1e-16
            res=resx;
        else
            disp('X and Y resolution of altitude file are different')
            disp(num2str(resx))
            disp(num2str(resy))
        end



        if AgentPlacementChoice==1
            %% Homogeneous Placement%%
            singleSwitch=1;
            placement='Homo';
        elseif AgentPlacementChoice==2
            %% Single Placement %%
            singleSwitch=0;
            placement='Head';
        elseif AgentPlacementChoice==3
            %% Single Placement %%
            singleSwitch=0;
            placement='Mouth';
        elseif AgentPlacementChoice==4
            %% Single Placement %%
            singleSwitch=0;
            placement='MidPoint';
        elseif AgentPlacementChoice==5
            %% Single Placement %%
            singleSwitch=0;
            placement='Staggered';
        end

        shp_res = shaperead(shapefile);
        numseg=length(shp_res);
        k=0;
        beginCount=1;

        for i=riverBranchNumber(1):riverBranchNumber(end)%
            numpts=length(shp_res(i).X);
            k=k+numpts;
        end
        xx=zeros(1,k);
        yy=zeros(1,k);
        sord=zeros(1,k);
        k=0;xxfinal=0;yyfinal=0;

        branchNames={'Branch 1','Branch 2','Branch 3','Branch 4','Branch 5','Branch 6','Branch 7','Branch 8',...
            'Branch 9','Branch 10','Branch 11','Branch 12','Branch 13','Branch 14','Branch 15','Branch 16','Branch 17'};
        dataType={'double','double','double','double','double','double','double','double','double','double',...
            'double','double','double','double','double','double','double'};
        for i=riverBranchNumber
            numpts=length(shp_res(i).X);
            %% this control changes the width of the river %%
            %
            segord=1;%shp_res(i).StreamOrde;
            for j=1:numpts
                k=k+1;
                if ~isnan(shp_res(i).X(j)) && ~isnan(shp_res(i).Y(j))
                    xx(k)=shp_res(i).X(j);
                    yy(k)=shp_res(i).Y(j);
                    sord(k)=segord;
                    branchCoordsPre{i}(j,1:3)=[xx(k)  yy(k) 0];
                    if j>1 && ~isnan(xx(k))
                        d=norm([xx(k) yy(k)]-[xx(k-1) yy(k-1)]);
                        %Taking the x and y values given in the start and
                        %ending points of each segment from the branch and is
                        %subdividing it into nseg=# of subdivisions needed in
                        %the segment from the branch.
                        if d>res
                            nseg=ceil(d/res)+1;
                            tempx=linspace(xx(k-1),xx(k),nseg);
                            tempy=linspace(yy(k-1),yy(k),nseg);
                            %Assigns all the nodes the values of the order
                            sord(k-1:k+nseg-2)=ones(1,nseg)*segord;
                            xx(k-1:k+nseg-2)=tempx;
                            yy(k-1:k+nseg-2)=tempy;
                            k=k+nseg-2;
                        end
                    end
                else
                end
            end
        end

        a=find(yy==0);xx(a)=[];yy(a)=[];
        maxx=max(xx);
        if maxx<=max(X)
            maxx=max(X);
        else
            disp('Altitude region needs to fully contain river region')
        end

        minx=min(xx);
        if minx>=min(X)
            minx=min(X);
        else
            disp('Altitude region needs to fully contain river region')
        end

        maxy=max(yy);
        if maxy<=max(Y)
            maxy=max(Y);
        else
            disp('Altitude region needs to fully contain river region')
        end

        miny=min(yy);
        if miny>=min(Y)
            miny=min(Y);
        else
            disp('Altitude region needs to fully contain river region')
        end

        landGrid=zeros(sizey,sizex);
        for branchCount=1:17
            branchCoordsPre{branchCount}(:,1)=branchCoordsPre{branchCount}(:,1)-minx;
            branchCoordsPre{branchCount}(:,2)=branchCoordsPre{branchCount}(:,2)-miny;
            for k=1:length(branchCoordsPre{branchCount}(:,1))
                for xio=1:sord(k)
                    for yio=1:sord(k)
                        branchCoords{branchCount}(k,1:2)=[round(branchCoordsPre{branchCount}(k,1)/res-(sord(k)-1)/2+xio-1)+buffer,round(branchCoordsPre{branchCount}(k,2)/res-(sord(k)-1)/2+yio-1)+buffer];
                    end
                end
            end
        end
        xx=xx-minx;
        yy=yy-miny;
        counter=1;
        for k=1:length(xx)
            if ~isnan(xx(k))
                if mod(sord(k),2)==0
                    for xio=1:sord(k)
                        for yio=1:sord(k)
                            landGrid(round(yy(k)/res-sord(k)/2+0.5+xio-1)+buffer,round(xx(k)/res-sord(k)/2+0.5+yio-1)+buffer)=1;
                        end
                    end
                else
                    for xio=1:sord(k)
                        for yio=1:sord(k)
                            landGrid(round(yy(k)/res-(sord(k)-1)/2+xio-1)+buffer,round(xx(k)/res-(sord(k)-1)/2+yio-1)+buffer)=1;
                            counter=counter+1;
                        end
                    end
                end
            end
        end
        if strcmp(altinfo.ColumnsStartFrom,'north')
            altGrid=altGrid(end:-1:1,:);
        end
        if strcmp(altinfo.RowsStartFrom,'east')
            altGrid=altGrid(:,end:-1:1);
        end

        for branchCount=1:width(branchCoords)
            for nodeCount=1:height(branchCoords{branchCount})
                branchCoords{branchCount}(nodeCount,3)=altGrid(branchCoords{branchCount}(nodeCount,2),branchCoords{branchCount}(nodeCount,1));
            end
            branchCoords{branchCount}=sortrows(branchCoords{branchCount},3,'descend');
        end

        %%%%%%%%%%%%%River Section Coordinates Grab with Elevation%%%%%%%%%%%
        coordCount=1;
        %             [ONESxx,~]=find(landGrid==1);
        %             riverCoordsBirth=zeros(size(ONESxx,1));
        for a=1:size(landGrid,1)
            for b=1:size(landGrid,2)
                if landGrid(a,b)==1
                    riverCoordsBirth(coordCount,1:2)=[b a];
                    riverCoordsBirth(coordCount,3)=altGrid(a,b);
                    coordCount=coordCount+1;
                end
            end
        end
        save('branchCoords.mat','branchCoords','riverCoordsBirth','-v7.3');
    else
        load('branchCoords.mat','branchCoords','riverCoordsBirth');
    end

    agCoords=setAgCoords(riverCoordsBirth,riverBranchNumber,branchCoords,AgentPlacementChoice);

    % a=size(riverCoordsFinal,1):-1:1;
    % scatter3(coords(:,1),coords(:,2),coords(:,3))
    % view(0,90);
    if ~exist(coordsFileName(1:end-10),'dir')
        mkdir(coordsFileName(1:end-10))
    end
    save(coordsFileName,'agCoords','riverBranchNumber');
else
    load(coordsFileName,'agCoords');
end
end