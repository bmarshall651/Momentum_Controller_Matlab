clear all;
clc;

x=4;
tots=50;
dsq=1;


while(x<tots)
    portLocs=[floor(10*x/4) 1; floor(10*x/4) 10*x;  floor(30*x/4) 1; floor(30*x/4) 10*x;];
    matr=generateRandomMatrix(10*x,10*x,portLocs);
    buildLensFiles(matr,dsq,portLocs,5.8,5.8,0.1,pwd);
    beg=tic;
    runMOM(pwd);
    telapsed=toc(beg);
    finalData(x-3,4)=telapsed;
    finalData(x-3,1)=x;
    finalData(x-3,2)=dsq;
    finalData(x-3,3)=size(portLocs,1);
    x=x+1;
end

save timeData40to500with1mm4Ports.mat