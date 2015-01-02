function [ matr ] = drawLens( inputMatrix, unitWidth, portLocations )
%drawLens converts the binary matrix to a bitmap of black for metal, white
%for non-metal, and red for ports (with metal)
%
%Author: Blake R. Marshall - bmarshall651@gmail.com
%Date: July 6, 2014
%The Propagation Group at Georgia Institute of Technology
%
%@param inputMatrix MxN binary matrix for metal and non metal
%@param unitWidth is the geometric length and width of each cell in
%inputMatrix
%@param portLocations is the location of all the ports listed as: [x1 y1; x2
%y2; x3 y3;]
%
%@return matr is the bitmap of the matrix
matr=~repmat(inputMatrix,[1,1,3]);


temp1=1;
while temp1 <= size(portLocations,1)
    matr(portLocations(temp1,1),portLocations(temp1,2),:)=[1 0 0];
    temp1=temp1+1;
end

image([0 unitWidth*size(inputMatrix,2)], [0 unitWidth*size(inputMatrix,1) 
    ], matr)
title(['Black=metal, White=air, Red=port, unitCell=',num2str(unitWidth),'mm']);
xlabel('x-dimension (mm)');
ylabel('y-dimension (mm)');

    

end

