function [ costValue ] = calculateSparamCost(Sactual, Sideal, weighting)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here

diff=Sactual-Sideal;
sqerror=sqrt(diff(:,1).^2+diff(:,2).^2);
costValue=sum(weighting.*sqerror);

end

