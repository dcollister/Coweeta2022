function [width,TLandFull,TRiverFull,pdHolder,pbHolder,LandType,SubTypeChoice,AgentSubTypeChoiceSet,OrderedStreamsCounterSet,BranchChoice,AgentPlacement,wholesaveToggle,titleTopLineFrontPiece]...
        =ParameterChoiceSetsValues(singleHomoSwitch,TChoice1,TChoice2,BioChoice1,BioChoice2)
    
    %% Homogeneous All Network
    LandSetupChoices{1}=[1 1 1 4 2 1 0];
    %% Single 6 mouth (392,405)
    LandSetupChoices{2}=[1 1 2 1 1 3 0];
    
    
    TChoices{1,1}=[1E-3,1E-3];
    TChoices{1,2}=[1E5,1E-3];
    TChoices{2,1}=[1E-3,1E5];
    TChoices{2,2}=[1E5,1E5];
    
    BioChoices{1,1}=[1E-1,1E-1];
    BioChoices{1,2}=[1E-1,1E-2];
    BioChoices{1,3}=[1E-1,0];
    BioChoices{2,1}=[1E-3,1E-1];
    BioChoices{2,2}=[1E-3,1E-2];
    BioChoices{2,3}=[1E-3,0];
    
    titleTopLineFrontPieceChoices={'Single-point spawn at branch 6 mouth','Full-network spawn'};
    %% Fix Param Values
    
    %% Physical Data Settings %%
    width=0;
    TLandFull=TChoices{TChoice1,TChoice2}(1);%1E-3;%
    TRiverFull=TChoices{TChoice1,TChoice2}(2);%1E5;%
    %%  Biology of the agents   %%
    pdHolder=BioChoices{BioChoice1,BioChoice2}(1);
    pbHolder=BioChoices{BioChoice1,BioChoice2}(2);
    
    %% Physical Data Settings %%
    LandType=LandSetupChoices{singleHomoSwitch}(1);
    SubTypeChoice=LandSetupChoices{singleHomoSwitch}(2);%1:4
    AgentSubTypeChoiceSet=LandSetupChoices{singleHomoSwitch}(3);%[2 5];
    OrderedStreamsCounterSet=LandSetupChoices{singleHomoSwitch}(4);%[1 4];
    BranchChoice=LandSetupChoices{singleHomoSwitch}(5);
    AgentPlacement=LandSetupChoices{singleHomoSwitch}(6);%2:3;%2;%
    wholesaveToggle=LandSetupChoices{singleHomoSwitch}(7);
    
    
    titleTopLineFrontPiece=titleTopLineFrontPieceChoices{singleHomoSwitch};
    