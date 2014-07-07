clear all;
tic;
unitWidth=0.2;
portLocations=[2 1; 2 4; ];
nextGen=buildPopulation(10,4,4, portLocations);
Sparams=simulatePopulation(nextGen, portLocations, unitWidth, pwd);
Sideal=[0 0; 0.9 0.1; -0.9 -0.1; 0 0;];
weighting=[1; 1; 1; 1;];


totalGenerations=15;
x=1;
while(x<=totalGenerations)
    nextGen=buildNewGeneration(nextGen,Sparams,Sideal,weighting,0.5,0.3, portLocations);
    Sparams=simulatePopulation(nextGen, portLocations, unitWidth, pwd);
    x=x+1;
end

finalCosts=calculateCostOfPop(Sparams, Sideal, weighting);
[lowestCost, inc]=min(finalCosts);
bestOfBest=nextGen(:,:,inc);
bestSparams=Sparams(:,:,inc);
toc;