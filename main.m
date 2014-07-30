clear all;

unit=0.2; %in mm
portLocations=[2 1; 2 20; 19 1; 19 20;]; %in matrix indicies
lensMatrix1 = generateRandomMatrix(20,20, portLocations);
buildLensFiles(lensMatrix1, unit, portLocations, pwd);
drawLens(lensMatrix1,unit, portLocations);
runMOM(pwd);
Sparams=interpretCTItoSparam('proj.cti');