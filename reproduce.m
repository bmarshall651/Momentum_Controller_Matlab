function [child] = reproduce(survivingPop, mutationPercent, portLocations)
%REPRODUCE creates an offspring from a population of binary matrices by
%randoming selecting parents and adding mutations. The port locations are
%checked at the end to ensure proper excitation.
%
%Author: Blake R. Marshall - bmarshall651@gmail.com
%Date: July 6, 2014
%The Propagation Group at Georgia Institute of Technology
%
%@param survivingPop is the population to be selected from for the child.
%It is a MxNxnumOfCitizens binary matrix where 1 is metal and 0 is
%non-metal.
%@param mutationPercent is the percent of matrices cells that may randomly
%being negated
%@param portLocations is the location of all the ports listed as: [x1 y1; x2
%y2; x3 y3;]
%
%@return child is the resulting binary MxN matrix child of the population

%Calculate surviving population size
totalSurviving=size(survivingPop,3);

%Find two different parents randomly
a=1;
b=1;
while(a==b)
    a=randi([1 totalSurviving]);
    b=randi([1 totalSurviving]);
end

%Mate the parents to produce chile
matingMatrix=randi([0 1],size(survivingPop,1),size(survivingPop,2));
child=survivingPop(:,:,a).*matingMatrix+survivingPop(:,:,b).*~matingMatrix;

%Mutations
numOfMutations=floor(mutationPercent*size(child,1)*size(child,2));
temper=1;
while(temper<=numOfMutations)
    a=randi([1 size(child,1)]);
    b=randi([1 size(child,2)]);
    child(a,b)=~child(a,b);
    temper=temper+1;
end

%Ensure that port locations have metal connections to excite
child=adjustLensForPorts(child,portLocations);

end

