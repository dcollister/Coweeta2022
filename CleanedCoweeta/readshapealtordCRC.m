function [landGrid,altGrid,riverCoordsFinal]=readshapealtordCRC(shapefile,altfile,CoweetaChoice)
buffer=1;
% produce landGrid and altGrid from shapefile and altitude tiff file
[altGrid,altinfo]=geotiffread(altfile);
%       oldnames = {'XWorldLimits','YWorldLimits'};
%   newnames = {'LongitudeLimits','LatitudeLimits'};
%   for k=1:numel(oldnames)
%      [altinfo(1:N).(newnames{k})] = deal(altinfo.(oldnames{k})) ;
%   end
%   map = containers.Map({'XWorldLimits','YWorldLimits'},{'LongitudeLimits','LatitudeLimits'});
%     tmp = reshape(values(map,fieldnames(old)),1,[]);
%     tmp(2,:) = num2cell(permute(struct2cell(old),[3,1,2]),1);
%     new = reshape(struct(tmp{:}),size(old));
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

shp_res ...
    = shaperead(shapefile);
numseg=length(shp_res);
k=0;
for i=1:numseg%
    numpts=length(shp_res(i).X);
    k=k+numpts;
end
xx=zeros(1,k);
yy=zeros(1,k);
sord=zeros(1,k);
k=0;

%Total Structure
if CoweetaChoice==1
    SegHolder=1:numseg;
end

%%%Western Connection%%%%
if CoweetaChoice==2
    SegHolder=[4 5 6 11 12 13 14];
end

%%%Southern Connection%%%%
if CoweetaChoice==3
    SegHolder=[3:6 14:17];
end

%%%NorthEastern Connection%%%%
if CoweetaChoice==4
    SegHolder=[1:4 7:10 15];
end

for i=SegHolder%17%1:numseg%14%
    numpts=length(shp_res(i).X);
    
    %this control changes the width of the river
    segord=1;%shp_res(i).StreamOrde;
    for j=1:numpts
        k=k+1;
        xx(k)=shp_res(i).X(j);
        yy(k)=shp_res(i).Y(j);
        sord(k)=segord;
        if j>1 && ~isnan(xx(k))
            d=norm([xx(k) yy(k)]-[xx(k-1) yy(k-1)]);
            if d>res
                nseg=ceil(d/res)+1;
                tempx=linspace(xx(k-1),xx(k),nseg);
                tempy=linspace(yy(k-1),yy(k),nseg);
                sord(k-1:k+nseg-2)=ones(1,nseg)*segord;
                xx(k-1:k+nseg-2)=tempx;
                yy(k-1:k+nseg-2)=tempy;
                k=k+nseg-2;
            end
        end
%         scatter(xx,yy)
%         pause(.025)
    end
end
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
xx=xx-minx;
yy=yy-miny;

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


%%%%%%%%%%%%%River Section Coordinates Grab with Elevation%%%%%%%%%%%
coordCount=1;
for a=1:size(landGrid,1)
    for b=1:size(landGrid,2)
        if landGrid(a,b)==1
            riverCoords(coordCount,1:2)=[b a];
            riverCoords(coordCount,3)=altGrid(a,b);
            coordCount=coordCount+1;
        end
    end
end
riverCoordsFinal=sortrows(riverCoords,3,'descend');
% % a=size(riverCoordsFinal,1):-1:1;
% scatter3(riverCoordsFinal(:,1),riverCoordsFinal(:,2),riverCoordsFinal(:,3))
% view(0,90);
% view(82.6384,8.2734);
end

