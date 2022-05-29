function buildAgHisto3(landGrid,parentHandle)

            BirthCountMat=zeros(size(landGrid));
            MaxCountMat=zeros(size(landGrid));
            DeathCountMat=zeros(size(landGrid));
            for i=1:size(reproAgs,1)
                BirthCountMat(reproAgs.BirthCoords_2(i),reproAgs.BirthCoords_1(i))=BirthCountMat(reproAgs.BirthCoords_2(i),reproAgs.BirthCoords_1(i))+1;
                MaxCountMat(reproAgs.RMaxCoords_2(i),reproAgs.RMaxCoords_1(i))=MaxCountMat(reproAgs.RMaxCoords_2(i),reproAgs.RMaxCoords_1(i))+1;
                DeathCountMat(reproAgs.DeathCoords_2(i),reproAgs.DeathCoords_1(i))=DeathCountMat(reproAgs.DeathCoords_2(i),reproAgs.DeathCoords_1(i))+1;
            end

            [plotx,ploty]=find(BirthCountMat>0);
            plotz=zeros(size(plotx));
            
            for i=1:height(plotx)
                plotz(i,1)=BirthCountMat(plotx(i),ploty(i));
            end

            plotBirthCoords=[plotx ploty plotz];
            plotBirthCoords=sortrows(plotBirthCoords,3,'ascend');
            [za,zb,zc]=unique(plotBirthCoords(:,3));
            lengthz=height(za);
            plotBirthVecColors=zeros(size(plotBirthCoords));

            [plotxx,plotyy]=find(DeathCountMat>0);
            plotzz=zeros(size(plotxx));
            for ii=1:height(plotxx)
                plotzz(ii,1)=DeathCountMat(plotxx(ii),plotyy(ii));
            end

            plotDeathCoords=[plotxx plotyy plotzz];
            plotDeathCoords=sortrows(plotDeathCoords,3,'ascend');
            [zza,zzb,zzc]=unique(plotDeathCoords(:,3));
            lengthzz=height(zza);
            plotDeathVecColors=zeros(size(plotDeathCoords));

            colors_BirthBiVarDistz = [linspace(BirthBiVarDistBotCol(1),BirthBiVarDistTopCol(1),lengthz)',...
                linspace(BirthBiVarDistBotCol(2),BirthBiVarDistTopCol(2),lengthz)',...
                linspace(BirthBiVarDistBotCol(3),BirthBiVarDistTopCol(3),lengthz)'];

            colors_DeathBiVarDistz = [linspace(DeathBiVarDistBotCol(1),DeathBiVarDistTopCol(1),lengthzz)',...
                linspace(DeathBiVarDistBotCol(2),DeathBiVarDistTopCol(2),lengthzz)',...
                linspace(DeathBiVarDistBotCol(3),DeathBiVarDistTopCol(3),lengthzz)'];

            for colorCount=1:height(plotBirthCoords)
                plotBirthVecColors(colorCount,:)=colors_BirthBiVarDistz(zc(colorCount),1:3);
            end
            plotBirthVecC=[min(plotBirthVecColors):((max(plotBirthVecColors) - min(plotBirthVecColors)) \ 10):max(plotBirthVecColors);];

            for colorCount=1:height(plotDeathCoords)
                plotDeathVecColors(colorCount,:)=colors_DeathBiVarDistz(zzc(colorCount),:);
            end

            plotDeathVecC=[min(plotDeathVecColors):((max(plotDeathVecColors) - min(plotDeathVecColors)) \ 10):max(plotDeathVecColors)];

            birthPlot=scatter3(plotBirthCoords(:,2),plotBirthCoords(:,1),ones(height(plotBirthCoords(:,1)),1),24,plotBirthVecColors,'filled','Parent',parentHandle);


end