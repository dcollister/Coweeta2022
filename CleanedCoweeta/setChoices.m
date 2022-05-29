function [LandSetupChoices, InsideOrderCounterSet, SingleBranchValue]=setChoices(LandChoice,BranchChoice,placeChoice)
coweetaCoarse=[1 1];
if LandChoice==1
%% Homogeneous All Network
branchSettings=[1 4 2];SingleBranchValue=[1:17];
InsideOrderCounterSet{1}=100;%100=homogeneous
elseif LandChoice==2
%% Single 6 mouth (392, 405)
branchSettings=[2 1 1];
InsideOrderCounterSet{2}=1;SingleBranchValue=6;
elseif LandChoice==3
%% Single 10 headwater (292, 799)
branchSettings=[4 1 1];
InsideOrderCounterSet{3}=2;SingleBranchValue=10;
end
LandSetupChoices{LandChoice}=[coweetaCoarse branchSettings placeChoice 1];
% %% Single 10 headwater (292, 799)
% LandSetupChoices{4}=[1 1 4 1 1 3 1];
% InsideOrderCounterSet{4}=2;SingleBranchValue=10;
% %% Single 10 headwater (292, 799)
% LandSetupChoices{5}=[1 1 4 1 1 4 1];
% InsideOrderCounterSet{5}=2;SingleBranchValue=10;
% %% Single 10 headwater (292, 799)
% LandSetupChoices{6}=[1 1 4 1 1 5 1];
% InsideOrderCounterSet{6}=2;SingleBranchValue=10;
% %% Single 10 headwater (292, 799)
% LandSetupChoices{6}=[1 1 4 1 1 6 1];
% InsideOrderCounterSet{7}=2;SingleBranchValue=10;
    end

% LandSetupChoices{1}=[1 1 1 4 2 1 1];