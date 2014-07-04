function [ matr ] = drawLens( inputMatrix, unitWidth, portLocations )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

matr=~repmat(inputMatrix,[1,1,3]);


temp1=1;
while temp1 <= size(portLocations,1)
    matr(portLocations(temp1,1),portLocations(temp1,2),:)=[1 0 0];
    temp1=temp1+1;
end

image([0 unitWidth*size(inputMatrix,2)], [0 unitWidth*size(inputMatrix,1) 
    ], matr)


    

end

