function [ randomMatrix ] = generateRandomMatrix( M,N, portLocations )
%generateRandomMatrix creates a random binary MxN matrix and ensures that
%there is  1 at each port location.
%
%Author: Blake R. Marshall - bmarshall651@gmail.com
%Date: July 6, 2014
%The Propagation Group at Georgia Institute of Technology
%
%@param M is the number of rows
%@param N is the number of columns
%@param portLocations is the location of all the ports listed as: [x1 y1; x2
%y2; x3 y3;]
%
%@return randomMatrix is the resulting binary MxN matrix

%Creates random matrix of values then rounds them to 1 or 0
a=rand(M,N);
randomMatrix=round(a);

randomMatrix=adjustLensForPorts(randomMatrix,portLocations);

end

