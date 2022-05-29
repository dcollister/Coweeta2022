function [structure]=assignResultsValuesToStructure(structure,resultsCount,sheetcount,tilecount,results)

if sheetcount==1
    if tilecount==1
structure(resultsCount).NumberOfBins=results.numberBins;
structure(resultsCount).MaxMeanAll=results.allmu;
structure(resultsCount).MaxStandardDeviationAll=results.allsigma;
structure(resultsCount).MaxMedianAll=results.allmed;
structure(resultsCount).MaxNinetyFifthPercentileAll=results.all95;
structure(resultsCount).MaxMaxAll=results.allMax;

structure(resultsCount).MaxMeanRepro=results.repromu2;
structure(resultsCount).MaxStandardDeviationRepro=results.reprosigma2;
structure(resultsCount).MaxMedianRepro=results.repromed;
structure(resultsCount).MaxNinetyFifthPercentileRepro=results.repro95;
structure(resultsCount).MaxMaxRepro=results.repromaxDist2;
    elseif tilecount==2
        if ~(size(results(:).muUp,1)>1)
structure(resultsCount).MaxElUpperMeanRepro=results.muUp(1);
structure(resultsCount).MaxElUpperStandardDeviationRepro=results.sigmaUp(1);
structure(resultsCount).MaxElUpperMedianRepro=results.medUp(1);
structure(resultsCount).MaxElUpperNinetyFifthPercentileRepro=results.upper95(1);
structure(resultsCount).MaxElUpperMaxRepro=results.maxUp(1);

structure(resultsCount).MaxDistUpperMeanRepro=results.muUp(1);
structure(resultsCount).MaxDistUpperStandardDeviationRepro=results.sigmaUp(1);
structure(resultsCount).MaxDistUpperMedianRepro=results.medUp(1);
structure(resultsCount).MaxDistUpperNinetyFifthPercentileRepro=results.upper95(1);
structure(resultsCount).MaxDistUpperMaxRepro=results.maxUp(1);

structure(resultsCount).MaxUpperMeanTimeRepro=results.muUp(1);
structure(resultsCount).MaxUpperStandardDeviationTimeRepro=results.sigmaUp(1);
structure(resultsCount).MaxUpperMedianTimeRepro=results.medUp(1);
structure(resultsCount).MaxUpperNinetyFifthPercentileTimeRepro=results.upper95(1);
structure(resultsCount).MaxUpperMaxTimeRepro=results.maxUp(1);

        else
structure(resultsCount).MaxElUpperMeanRepro=results.muUp(2);
structure(resultsCount).MaxElUpperStandardDeviationRepro=results.sigmaUp(2);
structure(resultsCount).MaxElUpperMedianRepro=results.medUp(2);
structure(resultsCount).MaxElUpperNinetyFifthPercentileRepro=results.upper95(2);
structure(resultsCount).MaxElUpperMaxRepro=results.maxUp(2);

structure(resultsCount).MaxDistUpperMeanRepro=results.muUp(1);
structure(resultsCount).MaxDistUpperStandardDeviationRepro=results.sigmaUp(1);
structure(resultsCount).MaxDistUpperMedianRepro=results.medUp(1);
structure(resultsCount).MaxDistUpperNinetyFifthPercentileRepro=results.upper95(1);
structure(resultsCount).MaxDistUpperMaxRepro=results.maxUp(1);

structure(resultsCount).MaxUpperMeanTimeRepro=results.muUp(3);
structure(resultsCount).MaxUpperStandardDeviationTimeRepro=results.sigmaUp(3);
structure(resultsCount).MaxUpperMedianTimeRepro=results.medUp(3);
structure(resultsCount).MaxUpperNinetyFifthPercentileTimeRepro=results.upper95(3);
structure(resultsCount).MaxUpperMaxTimeRepro=results.maxUp(3);
        end
        
structure(resultsCount).MaxElLowerMeanRepro=results.muDown(2);
structure(resultsCount).MaxElLowerStandardDeviationRepro=results.sigmaDown(2);
structure(resultsCount).MaxElLowerMedianRepro=results.medDown(2);
structure(resultsCount).MaxElLowerNinetyFifthPercentileRepro=results.lower05(2);
structure(resultsCount).MaxElLowerMinRepro=results.minDown(2);

structure(resultsCount).MaxDistLowerMeanRepro=results.muDown(1);
structure(resultsCount).MaxDistLowerStandardDeviationRepro=results.sigmaDown(1);
structure(resultsCount).MaxDistLowerMedianRepro=results.medDown(1);
structure(resultsCount).MaxDistLowerNinetyFifthPercentileRepro=results.lower95(1);
structure(resultsCount).MaxDistLowerMaxRepro=results.maxDown(1);

structure(resultsCount).MaxLowerMeanTimeRepro=results.muDown(3);
structure(resultsCount).MaxLowerStandardDeviationTimeRepro=results.sigmaDown(3);
structure(resultsCount).MaxLowerMedianTimeRepro=results.medDown(3);
structure(resultsCount).MaxLowerNinetyFifthPercentileTimeRepro=results.lower95(3);
structure(resultsCount).MaxLowerMaxTimeRepro=results.maxDown(3);

    elseif tilecount==3

    elseif tilecount==4

    end
elseif sheetcount==2
    if tilecount==1
structure(resultsCount).NumberOfBins=results.numberBins;
structure(resultsCount).DeathMeanAll=results.allmu;
structure(resultsCount).DeathStandardDeviationAll=results.allsigma;
structure(resultsCount).DeathMedianAll=results.allmed;
structure(resultsCount).DeathNinetyFifthPercentileAll=results.all95;
structure(resultsCount).DeathMaxAll=results.allMax;

structure(resultsCount).DeathMeanRepro=results.repromu2;
structure(resultsCount).DeathStandardDeviationRepro=results.reprosigma2;
structure(resultsCount).DeathMedianRepro=results.repromed;
structure(resultsCount).DeathNinetyFifthPercentileRepro=results.repro95;
structure(resultsCount).DeathMaxRepro=results.repromaxDist2;
    elseif tilecount==2
        if ~(size(results(:).muUp,1)>1)
structure(resultsCount).MaxElUpperMeanRepro=results.muUp(1);
structure(resultsCount).MaxElUpperStandardDeviationRepro=results.sigmaUp(1);
structure(resultsCount).MaxElUpperMedianRepro=results.medUp(1);
structure(resultsCount).MaxElUpperNinetyFifthPercentileRepro=results.upper95(1);
structure(resultsCount).MaxElUpperMaxRepro=results.maxUp(1);

structure(resultsCount).MaxDistUpperMeanRepro=results.muUp(1);
structure(resultsCount).MaxDistUpperStandardDeviationRepro=results.sigmaUp(1);
structure(resultsCount).MaxDistUpperMedianRepro=results.medUp(1);
structure(resultsCount).MaxDistUpperNinetyFifthPercentileRepro=results.upper95(1);
structure(resultsCount).MaxDistUpperMaxRepro=results.maxUp(1);

structure(resultsCount).MaxUpperMeanTimeRepro=results.muUp(1);
structure(resultsCount).MaxUpperStandardDeviationTimeRepro=results.sigmaUp(1);
structure(resultsCount).MaxUpperMedianTimeRepro=results.medUp(1);
structure(resultsCount).MaxUpperNinetyFifthPercentileTimeRepro=results.upper95(1);
structure(resultsCount).MaxUpperMaxTimeRepro=results.maxUp(1);

        else
structure(resultsCount).MaxElUpperMeanRepro=results.muUp(2);
structure(resultsCount).MaxElUpperStandardDeviationRepro=results.sigmaUp(2);
structure(resultsCount).MaxElUpperMedianRepro=results.medUp(2);
structure(resultsCount).MaxElUpperNinetyFifthPercentileRepro=results.upper95(2);
structure(resultsCount).MaxElUpperMaxRepro=results.maxUp(2);

structure(resultsCount).MaxDistUpperMeanRepro=results.muUp(1);
structure(resultsCount).MaxDistUpperStandardDeviationRepro=results.sigmaUp(1);
structure(resultsCount).MaxDistUpperMedianRepro=results.medUp(1);
structure(resultsCount).MaxDistUpperNinetyFifthPercentileRepro=results.upper95(1);
structure(resultsCount).MaxDistUpperMaxRepro=results.maxUp(1);

structure(resultsCount).MaxUpperMeanTimeRepro=results.muUp(3);
structure(resultsCount).MaxUpperStandardDeviationTimeRepro=results.sigmaUp(3);
structure(resultsCount).MaxUpperMedianTimeRepro=results.medUp(3);
structure(resultsCount).MaxUpperNinetyFifthPercentileTimeRepro=results.upper95(3);
structure(resultsCount).MaxUpperMaxTimeRepro=results.maxUp(3);
        end
        
structure(resultsCount).DeathElLowerMeanRepro=results.muDown(2);
structure(resultsCount).DeathElLowerStandardDeviationRepro=results.sigmaDown(2);
structure(resultsCount).DeathElLowerMedianRepro=results.medDown(2);
structure(resultsCount).DeathElLowerNinetyFifthPercentileRepro=results.lower05(2);
structure(resultsCount).DeathElLowerMinRepro=results.minDown(2);

structure(resultsCount).MaxDistLowerMeanRepro=results.muDown(1);
structure(resultsCount).MaxDistLowerStandardDeviationRepro=results.sigmaDown(1);
structure(resultsCount).MaxDistLowerMedianRepro=results.medDown(1);
structure(resultsCount).MaxDistLowerNinetyFifthPercentileRepro=results.lower95(1);
structure(resultsCount).MaxDistLowerMaxRepro=results.maxDown(1);

structure(resultsCount).MaxLowerMeanTimeRepro=results.muDown(3);
structure(resultsCount).MaxLowerStandardDeviationTimeRepro=results.sigmaDown(3);
structure(resultsCount).MaxLowerMedianTimeRepro=results.medDown(3);
structure(resultsCount).MaxLowerNinetyFifthPercentileTimeRepro=results.lower95(3);
structure(resultsCount).MaxLowerMaxTimeRepro=results.maxDown(3);
    elseif tilecount==3

    elseif tilecount==4

    end
end


% 
% structure.NumberOfBins=results{};
% structure.MaxMean=results{};
% structure.MaxStandardDeviation=results{};
% structure.MaxMedian=results{};
% structure.MaxNinetyFifthPercentile=results{};
% structure.MaxMax=results{};
% structure.MaxUpperMean=results{};
% structure.MaxUpperStandardDeviation=results{};
% structure.MaxUpperMedian=results{};
% structure.MaxUpperNinetyFifthPercentile=results{};
% structure.MaxUpperMax=results{};
% structure.MaxUpperMeanTime=results{};
% structure.MaxUpperStandardDeviationTime=results{};
% structure.MaxUpperMedianTime=results{};
% structure.MaxUpperNinetyFifthPercentileTime=results{};
% structure.MaxUpperMaxTime=results{};
% structure.MaxLowerMean=results{};
% structure.MaxLowerStandardDeviation=results{};
% structure.MaxLowerMedian=results{};
% structure.MaxLowerNinetyFifthPercentile=results{};
% structure.MaxLowerMin=results{};
% structure.MaxLowerMeanTime=results{};
% structure.MaxLowerStandardDeviationTime=results{};
% structure.MaxLowerMedianTime=results{};
% structure.MaxLowerNinetyFifthPercentileTime=results{};
% structure.MaxLowerMinTime=results{};
% structure.DeathMean=results{};
% structure.DeathStandardDeviation=results{};
% structure.DeathMedian=results{};
% structure.DeathNinetyFifthPercentile=results{};
% structure.DeathMax=results{};
% structure.DeathUpperMean=results{};
% structure.DeathUpperStandardDeviation=results{};
% structure.DeathUpperMedian=results{};
% structure.DeathUpperNinetyFifthPercentile=results{};
% structure.DeathUpperMax=results{};
% structure.DeathUpperMeanTime=results{};
% structure.DeathUpperStandardDeviationTime=results{};
% structure.DeathUpperMedianTime=results{};
% structure.DeathUpperNinetyFifthPercentileTime=results{};
% structure.DeathUpperMaxTime=results{};
% structure.DeathLowerMean=results{};
% structure.DeathLowerStandardDeviation=results{};
% structure.DeathLowerMedian=results{};
% structure.DeathLowerNinetyFifthPercentile=results{};
% structure.DeathLowerMin=results{};
% structure.DeathLowerMeanTime=results{};
% structure.DeathLowerStandardDeviationTime=results{};
% structure.DeathLowerMedianTime=results{};
% structure.DeathLowerNinetyFifthPercentileTime=results{};
% structure.DeathLowerMinTime=results{};