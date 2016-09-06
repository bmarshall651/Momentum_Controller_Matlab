function [ porMatrix, Sparams, cost, genChange ] = compareCosts( porMatrix, Sparams, ...
    cost, myNextGuess, tempSparams, tempCost,  curHistInd, randRate, ...
    genChange)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if tempCost < cost(curHistInd-1) || rand()<randRate
    porMatrix(:,:,curHistInd)=myNextGuess;
    Sparams(:,:,:,curHistInd)=tempSparams;
    cost(curHistInd)=tempCost;
    genChange=1;
else
    porMatrix(:,:,curHistInd)= porMatrix(:,:,curHistInd-1);
    Sparams(:,:,:,curHistInd)=Sparams(:,:,:,curHistInd-1);
    cost(curHistInd)=cost(curHistInd-1);
end

end

