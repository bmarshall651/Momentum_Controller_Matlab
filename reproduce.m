function [child] = reproduce(survivingPop, mutationPercent, portLocations)
%UNTITLED17  of this function goes here
%   Detailed explanation goes here
totalSurviving=size(survivingPop,3);
a=1;
b=1;
while(a==b)
    a=randi([1 totalSurviving]);
    b=randi([1 totalSurviving]);
end

matingMatrix=randi([0 1],size(survivingPop,1),size(survivingPop,2));
child=survivingPop(:,:,a).*matingMatrix+survivingPop(:,:,b).*~matingMatrix;

p=1;
while(p<=size(portLocations,1))
    child(portLocations(p,1),portLocations(p,2))=1;
    p=p+1;
end

end

