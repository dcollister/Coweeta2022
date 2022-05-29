function makingPictures(maxPositions)
%     close all
%     load('C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\Coweeta\West\Complete\Riv_All_birth_branch_4\Head\_Width0EleT_0.001RivT_1ProbDeath_0ProbBirth_0.001Timestamp_2021_09_02_04_56_06.mat');
birthInd=maxPositions(:,16)==1;
birthA=maxPositions(birthInd,:);
beginX=birthA(:,12);beginY=birthA(:,13);maxX=birthA(:,10);maxY=birthA(:,11);endX=birthA(:,14);endY=birthA(:,15);
[rivY,rivX]=find(River==1);
riv=[rivX,rivY];
hold on
mesh(Elevation)
scatter(rivX,rivY,12,'white')
h1=scatter(maxPositions(1,10),maxPositions(1,11),16,'x');
h2=scatter(birthA(:,12),birthA(:,13),24,'d','MarkerEdgeColor',[1 0 0],'MarkerFaceColor',[0 1 1],'LineWidth',1.5);
h3=scatter(birthA(:,14),birthA(:,15),24,'s','MarkerEdgeColor',[1 0 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);
for i=1:size(maxX,1)
% plot([beginX(i);maxX(i)],[beginY(i);maxY(i)],'--+','Linewidth',1.4);
% plot([maxX(i);endX(i)],[maxY(i);endY(i)],'<--','Linewidth',1.4);
% plot([beginX(i);endX(i)],[beginY(i);endY(i)],'--+','Linewidth',1.4);
end
legend([h1,h2,h3],'Max Distances from Birth Site','Birth Site','Reproduction Sites');
hold off

end