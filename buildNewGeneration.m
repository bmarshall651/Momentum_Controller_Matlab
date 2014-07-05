function [ newPopulation ] = buildNewGeneration( pop, Sparams, Sideal, costWeighting, killPercent, mutationPercent, portLocations)
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here
costPop=calculateCostOfPop(Sparams,Sideal,costWeighting);
survivingPop=survival(pop,killPercent,costPop);
newPopulation=survivingPop;
while(size(newPopulation,3)<size(pop,3))
    newPopulation(:,:,size(newPopulation,3)+1)=reproduce(survivingPop, mutationPercent, portLocations);
end

end

