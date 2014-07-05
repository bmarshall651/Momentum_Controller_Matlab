function [ Sparams ] = simulatePopulation( pop, portLocations, unitWidth ,folderName)
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here

x=1;

while(x<=size(pop,3))
    buildLensFiles(pop(:,:,x),unitWidth,portLocations, folderName);
    runMOM(folderName);
    Sparams(:,:,x)=interpretSingleFreqCTI('proj.cti');
    x=x+1;
end

end

