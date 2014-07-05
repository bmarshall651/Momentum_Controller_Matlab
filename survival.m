function [ newPop] = survival(oldPop, killPercent, costs)
%UNTITLED19 Summary of this function goes here
%   Detailed explanation goes here

totalSurvival=floor(size(oldPop,3)*(1-killPercent));
x=1;
[lowest,lowIndex]=min(costs);
while(x<=totalSurvival)
    newPop(:,:,x)=oldPop(:,:,lowIndex);
    oldPop(:,:,x)=zeros(size(oldPop,1),size(oldPop,2));
    costs(lowIndex)=NaN;
    [lowest,lowIndex]=min(costs);
    x=x+1;
end

end

