function [externalSupportAgsMat,supportAgsIDs,nonSupportAgsIds]=SupportAgents(A,sourceR,catchInR,catchOutR)


supportBoundDeaths=find(A.DeathType=="Boundary Escape");
EnvironmentDeaths=find(A.DeathType=="Death From Environment");
ReproducingDeaths=find(A.DeathType=="Reproducing Agent");

%% Support Agents separated by birth outside of source radius. Then separated into bound agents, envi and repro ags.
%% The repro ags are split into support ags and non-support ags, with both parsed into zones. <---need to finish non-support repro ags when you get a second.

externalAllAgsIDs=find(A.birthDistFromSourceCenter>sourceR);
externalBoundAgIDs=intersect(supportBoundDeaths,externalAllAgsIDs);
externalEnviAgIDs=intersect(EnvironmentDeaths,externalAllAgsIDs);
externalAllReproAgIDs=intersect(ReproducingDeaths,externalAllAgsIDs);
% externalNonSupportReproAgIDs=intersect(externalAllReproAgIDs,find(deathDistFromSourceCenter>sourceR));<----need to finish non-support repro ags when you get a second.
% externalNonSupportReproAgHolderIDs=1:height(externalNonSupportReproAgIDs);

%% Support Repro Ags Partitioning
supportAllAgIDs=intersect(ReproducingDeaths,find(A.deathDistFromSourceCenter<=sourceR));
if ~isempty(externalAllReproAgIDs)
    externalSupportAllReproAgs=intersect(externalAllReproAgIDs,supportAllAgIDs);
    externalNonSupportReproAgIDs=setdiff(externalAllReproAgIDs,externalSupportAllReproAgs);

    if ~isempty(externalSupportAllReproAgs)
        externalSupportAgsMat=A(externalSupportAllReproAgs,:);
        supportAgsBirthDistFromSourceNodeCenter=externalSupportAgsMat.birthDistFromSourceCenter;
        supportAgIDHolder=1:height(externalSupportAgsMat);

        % Ags from source support
        supportAgsFromSourceID=setdiff(supportAllAgIDs,externalSupportAllReproAgs);
        supportAgIDHolder=setdiff(supportAgIDHolder,supportAgsFromSourceID);

        if ~isempty(supportAgIDHolder)
            % Ags from beyond Source and before inner ring
            supportAgsCloserThanInnerRingID=find(supportAgsBirthDistFromSourceNodeCenter<=catchInR);
            supportAgsOutOfSourceButWithinInnerRingID=setdiff(supportAgsCloserThanInnerRingID,supportAgsFromSourceID);
            supportAgIDHolder=setdiff(supportAgIDHolder,supportAgsOutOfSourceButWithinInnerRingID);
        end

        %% Ags from Catchment annulus agents
        if ~isempty(supportAgIDHolder)
            supportAgsCloserThanOuterRingID=find(supportAgsBirthDistFromSourceNodeCenter<=catchOutR);
            supportAgsFromCatchmentZoneID=setdiff(supportAgsCloserThanOuterRingID,supportAgsCloserThanInnerRingID);
            supportAgIDHolder=setdiff(supportAgIDHolder,supportAgsFromCatchmentZoneID);
        end

        %% Ags from Beyond Catchment
        if ~isempty(supportAgIDHolder)
            supportAgsFromBeyondTheOuterRingID=find(supportAgsBirthDistFromSourceNodeCenter>catchOutR);
            supportAgIDHolder=setdiff(supportAgIDHolder,supportAgsFromBeyondTheOuterRingID);
        end

        if ~isempty(supportAgIDHolder)
            WeirdGuys=A(supportAgIDHolder);
        end

        supportAgsIDs={externalSupportAllReproAgs supportAgsOutOfSourceButWithinInnerRingID supportAgsFromCatchmentZoneID supportAgsFromBeyondTheOuterRingID};

    else
        supportAgsIDs={zeros(0,0) zeros(0,0) zeros(0,0) zeros(0,0)};
        externalSupportAgsMat=A(false(height(A)),:);
    end
    nonSupportAgsIds={ externalBoundAgIDs externalEnviAgIDs externalNonSupportReproAgIDs };
else
    nonSupportAgsIds={zeros(0,0) zeros(0,0) zeros(0,0) zeros(0,0)};
end
end
% colonizeAgsDistFromSingCenter