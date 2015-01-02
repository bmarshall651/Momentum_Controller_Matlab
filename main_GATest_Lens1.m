clear all;
tic;
unitWidth=1;
xdimNumofCells=100;
ydimNumofCells=100;
portLocations=[10 1; 20 1; 25 100; 75 100;];

j=sqrt(-1);
startFreq=5.6;
stopFreq=6;
stepFreq=0.2;

killPercent=0.5;
mutationPercent=0.2;
populationSize=5;
totalGenerations=6;

Sideal=repmat([0 0 exp(j*pi/4)/sqrt(2) exp(-j*pi/4)/sqrt(2); ...
    0 0 exp(-j*pi/4)/sqrt(2) exp(j*pi/4)/sqrt(2); ...
    exp(-j*pi/4)/sqrt(2) exp(j*pi/4)/sqrt(2) 0 0; ...
    exp(j*pi/4)/sqrt(2) exp(-j*pi/4)/sqrt(2) 0 0; ...
    ],[1 1 floor((stopFreq-startFreq)/stepFreq)+1]);
weighting=repmat([1 1 1 1; ...
    1 1 1 1; ...
    1 1 1 1; ...
    1 1 1 1;],[1 1 floor((stopFreq-startFreq)/stepFreq)+1]);

nextGen=buildPopulation(populationSize,xdimNumofCells,ydimNumofCells, portLocations,0,0);
Sparams=simulatePopulation(nextGen, portLocations, unitWidth,startFreq, stopFreq, stepFreq, pwd);



x=1;
while(x<=totalGenerations)
    nextGen=buildNewGeneration(nextGen,Sparams,Sideal,weighting,killPercent,mutationPercent, portLocations);
    Sparams=simulatePopulation(nextGen, portLocations,unitWidth, startFreq, stopFreq, stepFreq, pwd);
    disp(['GENERATION ', num2str(x), 'COMPLETE']);
    x=x+1;
   
end

finalCosts=calculateCostOfPop(Sparams, Sideal, weighting);
[lowestCost, inc]=min(finalCosts);
bestOfBest=nextGen(:,:,inc);
bestSparams=Sparams(:,:,:,inc);
%simulateForFarField(bestOfBest,unitWidth,portLocations,5.8,1,50);
save('Results.mat');

toc;