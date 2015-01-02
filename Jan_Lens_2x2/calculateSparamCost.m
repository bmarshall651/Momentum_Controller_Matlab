function [ avgNormCostValue ] = calculateSparamCost(Sactual, Sideal, freq, weighting, useMagInCost, usePhaseInCost, startCostFreq, stopCostFreq)
%calculateSparamCost calculates the weighted error of distance between each
%S-parameter
%
%Author: Blake R. Marshall - bmarshall651@gmail.com
%Date: July 6, 2014
%The Propagation Group at Georgia Institute of Technology
%
%@param Sactual is the actual S-parameters
%@param Sideal is the ideal S-parameters to be obtained
%@param weighting is how heavily weighted each real and imaginary S
%parameter is weighted: [1 1; 1 1; 1 1; 1 1;] would be equal weighting on
%all S-parameters of a 2 port network
%
%@return costValue is the calculated cost

[messa, a]=min(abs(freq-startCostFreq));
[messb, b]=min(abs(freq-stopCostFreq));
W=repmat(weighting,[1,1,b-a+1]);

diff=Sactual(:,:,a:b)-Sideal(:,:,a:b); %finds the difference between S-parameters
magDiff=W.*abs(diff);
phaseDiff=W.*abs(angle(diff));

if(useMagInCost==1 && usePhaseInCost==0)
    avgNormCostValue=sum(sum(sum(magDiff)))/max(max(max(magDiff)))/(b-a+1);
elseif(useMagInCost==0&&usePhaseInCost==1)
    avgNormCostValue=sum(sum(sum(phaseDiff)))/max(max(max(phaseDiff)))/(b-a+1);
elseif(useMagInCost==1&&usePhaseInCost==1)
    avgNormCostValue=sum(sum(sum(magDiff)))/max(max(max(magDiff)))+sum(sum(sum(phaseDiff)))/max(max(max(phaseDiff)))/(b-a+1)/2;
else
    disp('Error - Must use either magnitude or phase for cost function');
end

end

