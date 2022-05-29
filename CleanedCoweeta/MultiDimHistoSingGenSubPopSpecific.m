function MultiDimHistoSingGenSubPopSpecific(A)
        load('LandandAltGrids.mat','altLandGrid','landGrid');
        red = [1, 0, 0];
        pink = [255, 192, 203]/255;
        orange=[251, 98, 5]/255;
        green=[94 223 12]/255;
        myBlue=[57 168 251]/255;
        BirthBiVarDistBotCol=[0 0 255]/255;
        BirthBiVarDistTopCol=[0 255 255]/255;
        gray='#9B9B9B';
        
BirthCountMat=zeros(size(landGrid));
MaxCountMat=zeros(size(landGrid));
DeathCountMat=zeros(size(landGrid));

%clean up grab for 3dhisto build 
for i=1:size(groupAll,1)
    BirthCountMat(A(i,13),A(i,12))=BirthCountMat(A(i,13),A(i,12))+1;
    MaxCountMat(groupAll(i,11),groupAll(i,10))=MaxCountMat(groupAll(i,11),groupAll(i,10))+1;
    DeathCountMat(groupAll(i,15),groupAll(i,14))=DeathCountMat(groupAll(i,15),groupAll(i,14))+1;
end


        %% Size of vectors of interest.  Currently set to successful births (length) and #locations (length2)
        maxTime=max(ArrayOfInterest(:,end));
        length=size(ArrayOfInterest(:,6),1);
        A=ArrayOfInterest(:,6:7);
        B=unique(A,'rows');
        binsYRows=max(B(:,1))-min(B(:,1));
        binsXCols=max(B(:,2))-min(B(:,2));
        length2=size(B,1);
        a=max(max(TotalMatrix));
        TotalPopSize=sum(sum(DeathCountMat));
        PercentBirthsOfTotal=roundn((100*length/TotalPopSize),-2);

a=[1:size(groupAll)];
b=[1:size(groupAll)];

for i=1:size(groupAll,1)
    BirthCountMat(groupAll(i,13),groupAll(i,12))=BirthCountMat(groupAll(i,13),groupAll(i,12))+1;
    MaxCountMat(groupAll(i,11),groupAll(i,10))=MaxCountMat(groupAll(i,11),groupAll(i,10))+1;
    DeathCountMat(groupAll(i,15),groupAll(i,14))=DeathCountMat(groupAll(i,15),groupAll(i,14))+1;
end
end