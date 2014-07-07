function [ costValue ] = calculateSparamCost(Sactual, Sideal, weighting)
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


diff=Sactual-Sideal; %finds the difference between S-parameters
sqerror=sqrt(diff(:,1).^2+diff(:,2).^2);%Finds square error for each S-param
costValue=sum(weighting.*sqerror); %Weights them and sums them up



end

