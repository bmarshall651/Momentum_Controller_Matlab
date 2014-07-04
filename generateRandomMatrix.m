function [ randomMatrix ] = generateRandomMatrix( M,N, portLocations )
%generateRandomMatrix creates a random binary matrix to be used for lenses
%Author: Blake Marshall
%JUne 28, 2014
%M is number of rows
%N is numer o cols

a=rand(M,N);
randomMatrix=round(a);

p=1;
while(p<=size(portLocations,1))
    randomMatrix(portLocations(p,1),portLocations(p,2))=1;
    p=p+1;
end

end

