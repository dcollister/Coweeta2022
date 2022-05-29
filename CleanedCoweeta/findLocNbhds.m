 function [clusters]=findLocNbhds(rivNodesInReg,sourceR,ReproMat)
    tempRivNodesInReg=rivNodesInReg;
    nbhdSetSize=1;resetSwitch=0;
    tempRivNodesInRegIDs=linspace(1,size(rivNodesInReg,1),size(rivNodesInReg,1));
    while size(tempRivNodesInRegIDs,2)>1
            %create holder
        if ~resetSwitch
            tempSingNbhdCoords=zeros(0,3);
            newNeighID=false(size(tempRivNodesInReg,1),1);
            neighID=false(size(tempRivNodesInReg,1),1);
            resetSwitch=1;
        else
            %begin nbhd module
            singCoords=tempRivNodesInReg(1,1:2);
            tempSingNbhdCoords(1,:)=tempRivNodesInReg(1,:);

            distFromSingNbhd=sqrt((tempRivNodesInReg(:,1)-singCoords(1,1)*ones(size(tempRivNodesInReg,1),1)).^2+((tempRivNodesInReg(:,2)-singCoords(1,2)*ones(size(tempRivNodesInReg,1),1)).^2));
            neighID=distFromSingNbhd<sourceR;

            newNeighID=or(newNeighID,neighID);
            idHolder=find(distFromSingNbhd<sourceR);
            valHold=[];
            
            %populate with nodes until all grabbed. Delete nbhd and repeat
            %until no more nodes
            while size(idHolder,1)>0
                valHold=[valHold;idHolder(1)];
                distFromSingNbhd=sqrt((tempRivNodesInReg(:,1)-tempRivNodesInReg(idHolder(1,1),1)*ones(size(tempRivNodesInReg,1),1)).^2+((tempRivNodesInReg(:,2)-tempRivNodesInReg(idHolder(1,1),2)*ones(size(tempRivNodesInReg,1),1)).^2));
                neighID=distFromSingNbhd<sourceR;
                localCoordsIDS=find(distFromSingNbhd<sourceR);

                idHolder=[idHolder;localCoordsIDS];
                idHolder=unique(idHolder);
                newNeighID=or(newNeighID,neighID);
                idHolder=setdiff(idHolder,valHold);
            end

            clusters{nbhdSetSize}=tempRivNodesInReg(newNeighID,:);
            tempRivNodesInReg(newNeighID,:)=[];
            tempRivNodesInRegIDs=linspace(1,size(tempRivNodesInReg,1),size(tempRivNodesInReg,1));
            nbhdSetSize=nbhdSetSize+1;
            resetSwitch=0;%Delete counts from id vector once nbhd is completed

        end
    end

%             [rivNodeInRegIDs]=find(ReproMat>catchInR & distFromSing<catchOutR);
end