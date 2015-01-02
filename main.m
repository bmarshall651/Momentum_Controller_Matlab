clear all;

unit=0.2; %in mm
portLocations=[2 1; 2 20; 19 1; 19 20;]; %in matrix indicies
lensMatrix1 = generateRandomMatrix(20,20, portLocations,1,1);
buildLensFiles(lensMatrix1, unit, portLocations,5.6,6.0,0.2, pwd);
drawLens(lensMatrix1,unit, portLocations);
runMOM(pwd);
Sparams=interpretCTItoSparam('proj.cti');