function [ matrix ] = buildPopulation( initialPopulationSize, M, N, portLocations )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
x=1;

while(x<=initialPopulationSize)
    matrix(:,:,x)=generateRandomMatrix(M,N,portLocations);
    x=x+1;
end

end

