clear all;

unitWidth=0.2;
portLocations=[5 1; 5 10; ];
nextGen=buildPopulation(4,10,10, portLocations);
Sparams=simulatePopulation(nextGen, portLocations, unitWidth, pwd);
Sideal=[0 0; 1 0; 1 0; 0 0;];
weighting=[1; 1; 1; 1;];


totalGenerations=10;
x=1;
while(x<=totalGenerations)
    nextGen=buildNewGeneration(nextGen,Sparams,Sideal,weighting,0.5,0.1, portLocations);
    Sparams=simulatePopulation(nextGen, portLocations, unitWidth, pwd);
    x=x+1;
end