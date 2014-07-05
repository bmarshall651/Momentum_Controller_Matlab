function [ costs ] = calculateCostOfPop( SparamsOfPop, idealS, weighting )
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here
x=1;
while(x<=size(SparamsOfPop,3))
    costs(x)=calculateSparamCost(SparamsOfPop(:,:,x),idealS,weighting);
    x=x+1;
end



end

