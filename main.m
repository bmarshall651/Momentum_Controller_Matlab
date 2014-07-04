clear all;

unit=0.5; %in mm
portLocations=[5 1; 6 10;]; %in matrix indicies
lensMatrix1 = generateRandomMatrix(10,10, portLocations);
%lensMatrix1 = ones(10,10);
%lensMatrix1 = zeros(5,5);
%lensMatrix1(3,:)=[1 1 1 1 1];
buildLensFiles(lensMatrix1, unit, portLocations, pwd);
drawLens(lensMatrix1,unit, portLocations);
runMOM(pwd);