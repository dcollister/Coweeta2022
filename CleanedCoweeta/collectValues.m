function collectValues()
    %%RunSaveFolder should be the input for this function once fully
    %%operational.  Placeholder atm.
%     RunSaveFolder='SimResults\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\';
RunSaveFolder='Coweeta\CRC\SimResults\Coweeta\Riv_All\Homo\';%'SimResults\Coweeta\Whole\Complete\Riv_All\Homo\';%
Physical Data Settings %%
    width=0;
    TLand=1E5;%0.001;{1E-3};%
    TRiver=1E5;%{1E-3};%
     Biology of the agents   %%
    pb={0.1};pd={0.0001};
    Names={'Negligible','Low','High'};
    nMoves=1;
    maxTimeSteps=200000;
    iniPopSize=5000;
runName=strcat('W_0_ET_',num2str(TLand{1}),'_RT_',num2str(TRiver{1}),'ProbDeath_',num2str(pd{1}),'ProbBirth_',num2str(pb{1}),'*.mat');   
dataName=strcat('ET',Names{1},'RT',Names{1},'ProbDeath',Names{1},'ProbBirth',Names{1},'DataStructure');
if ~isfile(['CollectedValues\9_21_21_',runName(1:end-5),'.mat'])
%%Get the contents from the sim folder of interest for that setting.
project_dir = [RunSaveFolder,runName];%pwd();     %or give a particular directory name
mainDirContents = dir(project_dir);
mainDirContents([mainDirContents.isdir]) = [];   %remove non-folders
mask = ismember( {mainDirContents.name}, {'.', '..'} );
mainDirContents(mask) = [];                       %remove . and .. folders
num_subfolder = length(mainDirContents);


%%Create holders for info
AllAgentsInfo=zeros(5000,28,length(mainDirContents));k1=1;
ReproAgentsInfo=zeros(5000,28,length(mainDirContents));k2=1;
NonReproInfo=zeros(5000,28,length(mainDirContents));k3=1;
%%groups for the boxplots
groupAll=zeros(0,28);
groupRepro=zeros(0,28);
groupNon=zeros(0,28);
maxDisplaceAll=zeros(5000,length(mainDirContents));
maxDisplaceRepro=zeros(5000,length(mainDirContents));
maxDisplaceNon=zeros(5000,length(mainDirContents));


for subfold_idx= 1 : num_subfolder
load individual files
  this_folder = fullfile( mainDirContents(subfold_idx).name );
  load([RunSaveFolder,this_folder],'maxPositions');
  
  dataSet.name{subfold_idx}=this_folder;
Separate different populations, removing zeros
  dataSet.AllAgentsFullData{subfold_idx}=maxPositions;
  dataSet.ReproAgentsFullDataOrderedStreamNames{subfold_idx}=maxPositions([maxPositions(:,16)==1],:);
  dataSet.NonReproAgentsFullDataOrderedStreamNames{subfold_idx}=maxPositions(~[maxPositions(:,16)==1],:);
  AllAgentsInfoHolder=maxPositions;
  ReproAgentsInfoHolder=maxPositions((maxPositions(:,16)==1),:);
  NonReproInfoHolder=maxPositions(~(maxPositions(:,16)==1),:);
  
Generate Max Dists
  dataSet.maxDisplaceAllHolderOrderedStreamNames{subfold_idx}=AllAgentsInfoHolder(:,9);
  dataSet.maxDisplaceReproHolderOrderedStreamNames{subfold_idx}=ReproAgentsInfoHolder(:,9);
  dataSet.maxDisplaceNonHolderOrderedStreamNames{subfold_idx}=NonReproInfoHolder(:,9);
  maxDisplaceAllHolder=AllAgentsInfoHolder(:,9);
  maxDisplaceReproHolder=ReproAgentsInfoHolder(:,9);
  maxDisplaceNonHolder=NonReproInfoHolder(:,9);

  
  
  
Populate Groups for plots by id # of file.  Note that there currently is
not correlation between x vals other than index num of file

  groupAll = [groupAll; AllAgentsInfoHolder];
  groupRepro = [groupRepro; ReproAgentsInfoHolder];
  groupNon = [groupNon; NonReproInfoHolder];
  
Populate Max Dist for boxplots

maxDisplaceAll{subfold_idx}=maxDisplaceAllHolder;
maxDisplaceRepro{subfold_idx}=maxDisplaceReproHolder;
maxDisplaceNon{subfold_idx}=maxDisplaceNonHolder;

%%move the file to a saver location once data processing is done.
movefile this_file strcat['SimResults\9_3_2021Runs\',
mainDirContentsOrderedStreamNames{subfold_idx}.name]
if ~isempty(AllAgentsInfoHolder)
AllAgentsInfo(k1:k1+size(AllAgentsInfoHolder,1)-1,:,subfold_idx)=AllAgentsInfoHolder;
end
if ~isempty(ReproAgentsInfoHolder)
ReproAgentsInfo(k2:k2+size(ReproAgentsInfoHolder,1)-1,:,subfold_idx)=ReproAgentsInfoHolder;
end
if ~isempty(NonReproInfoHolder)
NonReproInfo(k3:k3+size(NonReproInfoHolder,1)-1,:,subfold_idx)=NonReproInfoHolder;
end
end
figure
hold on
boxplot(maxDisplaceAll,groupAll)
set(gca,'XTickLabel',names)
hold off
save(['CollectedValues\9_21_21_',runName(1:end-5),'.mat'],'AllAgentsInfo','ReproAgentsInfo','NonReproInfo','groupAll','groupNon','groupRepro','-v7.3');

else
load(['CollectedValues\9_21_21_',runName(1:end-5),'.mat'],'AllAgentsInfo','ReproAgentsInfo','NonReproInfo','groupAll','groupNon','groupRepro');
end

end

group = [    ones(size(A));
         2 * ones(size(B));
         3 * ones(size(C))];
figure
boxplot([A; B; C],group)
set(gca,'XTickLabel',{'A','B','C'})