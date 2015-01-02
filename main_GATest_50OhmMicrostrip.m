clear all;
tic;
unitWidth=0.2032;
xdimNumofCells=10;
ydimNumofCells=10;
portLocations=[5 1; 5 20;];

j=sqrt(-1);
startFreq=5.6;
stopFreq=6;
stepFreq=0.2;

killPercent=0.75;
mutationPercent=0.025;
populationSize=30;
totalGenerations=20;

Sideal=repmat([0 1; 1 0;],[1 1 floor((stopFreq-startFreq)/stepFreq)+1]);
weighting=repmat([1 1; 1 1;],[1 1 floor((stopFreq-startFreq)/stepFreq)+1]);

disp(['GA for Microstrip using...']);
disp(['popSize=',num2str(populationSize)]);
disp(['totGens=', num2str(totalGenerations)]);
disp(['mutationRate=', num2str(mutationPercent)]);
disp(['killRate=', num2str(killPercent)]);
disp('Ideal S-parameter Matrix:');
disp(Sideal(:,:,1));
disp('Weighting Matrix:');
disp(weighting(:,:,1));
disp('=======================================');
%nextGen dim 1=x-cells, dim2=y-cells, dim3=popMemberNumber
nextGen=buildPopulation(populationSize,xdimNumofCells,ydimNumofCells, portLocations,0,0);
%Sparams dim 1=outputSparam, dim2=inputSparam, dim3=frequency, dim3=popMemberNumber
Sparams=simulatePopulation(nextGen, portLocations, unitWidth,startFreq, stopFreq, stepFreq, pwd);



x=1;
while(x<=totalGenerations)
    try
    beg=tic;
    nextGen=buildNewGeneration(nextGen,Sparams,Sideal,weighting,killPercent,mutationPercent, portLocations);
    Sparams=simulatePopulation(nextGen, portLocations,unitWidth, startFreq, stopFreq, stepFreq, pwd);
    disp(['GENERATION ', num2str(x), 'COMPLETE']);
    drawLens(nextGen(:,:,1),unitWidth,portLocations);
    title(['Gen=',num2str(x)]);
    disp('Time per Generation:');
    toc(beg)
    disp([num2str(totalGenerations-x),' Remaining']);
    
    x=x+1;
    catch err
        disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
        disp('Errored during GA');
        disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
        
        save('Results.mat');
        break;
    end
    save('Results.mat');
end

try
finalCosts=calculateCostOfPop(Sparams, Sideal, weighting);
[lowestCost, inc]=min(finalCosts);
bestOfBest=nextGen(:,:,inc);
bestSparams=Sparams(:,:,:,inc);
%simulateForFarField(bestOfBest,unitWidth,portLocations,5.8,1,50);
save('Results.mat');
disp('=======================================');
disp('Results Saved!');
catch err
    save('Results.mat');
    disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    disp('Errored during final calcs');
    disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
end




toc;