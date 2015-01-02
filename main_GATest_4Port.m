clear all;
tic;
unitWidth=0.2;
portLocations=[2 1; 49 1; 2 50; 49 50;];
nextGen=buildPopulation(20,50,50, portLocations);
Sparams=simulatePopulation(nextGen, portLocations, unitWidth, pwd);
Sideal=[0 0; 0 0; 1/sqrt(2) -pi/2; 1/sqrt(2) 0; ...
        0 0; 0 0; 1/sqrt(2) 0; 1/sqrt(2) -pi/2; ...
        1/sqrt(2) pi/2; 1/sqrt(2) 0; 0 0; 0 0;  ...
        1/sqrt(2) 0; 1/sqrt(2) -pi/2; 0 0; 0 0;];
weighting=[1 0; 1 0; 1 1; 1 1; ...
           1 0; 1 0; 1 1; 1 1; ...
           1 1; 1 1; 1 0; 1 0; ...
           1 1; 1 1; 1 0; 1 0;];


totalGenerations=10;
x=1;
while(x<=totalGenerations)
    nextGen=buildNewGeneration(nextGen,Sparams,Sideal,weighting,0.5,0.3, portLocations);
    Sparams=simulatePopulation(nextGen, portLocations, unitWidth, pwd);
    x=x+1;
    disp(['Generation ', num2str(x), 'Completed']);
end

finalCosts=calculateCostOfPop(Sparams, Sideal, weighting);
[lowestCost, inc]=min(finalCosts);
bestOfBest=nextGen(:,:,inc);
bestSparams=Sparams(:,:,inc);
toc;