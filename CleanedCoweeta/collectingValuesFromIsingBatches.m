function [xMin,xMax,yMin,yMax,radialDistMax] = collectingValuesFromIsingBatches(maxPositions,Elevation,River,finalGraphswitch)

A=sortrows(maxPositions,1);
xMin(1,1:2)=A(1:2);
xMin(1,3)=mean(maxPositions(:,1));
xMin(1,4)=std(maxPositions(:,1));
xMin(1,5:6)=A(1,12:13);

AA=sortrows(maxPositions,-3);
xMax(1,1:2)=AA(1,3:4);
xMax(1,3)=mean(maxPositions(:,3));
xMax(1,4)=std(maxPositions(:,3));
xMax(1,5:6)=AA(1,12:13);

B=sortrows(maxPositions,6);
yMin(1,1:2)=B(1,5:6);
yMin(1,3)=mean(maxPositions(:,6));
yMin(1,4)=std(maxPositions(:,6));
yMin(1,5:6)=B(1,12:13);

BB=sortrows(maxPositions,-8);
yMax(1,1:2)=BB(1,7:8);
yMax(1,3)=mean(maxPositions(:,8));
yMax(1,4)=std(maxPositions(:,8));
yMax(1,5:6)=BB(1,12:13);

CC=sortrows(maxPositions,-9);
radialDistMax(1,1:3)=CC(1,9:11);
radialDistMax(1,4)=mean(maxPositions(:,9));
radialDistMax(1,5)=std(maxPositions(:,9));

if finalGraphswitch==1

BirthDeathMax=figure('units','normalized','outerposition',[0 0 1 1]);
hold on
contourf(Elevation)
contourf(River)
h1=scatter(maxPositions(:,10),maxPositions(:,11),16,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[1 0 1],'LineWidth',1.5);
h2=scatter(maxPositions(:,12),maxPositions(:,13),40,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 1 1],'LineWidth',1.5);
h3=scatter(maxPositions(:,14),maxPositions(:,15),16,'MarkerEdgeColor',[0 0 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);
legend([h1,h2,h3],'Max Distances from Birth Site','Birth Site','Reproduction Sites');
hold off
end
end