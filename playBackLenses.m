clear all;
clc;

load THESIS_MICROSTRIP.mat
x=1;
pause(10)
while(x<=size(porMatrix,3))
    figure(1)
    drawLens(porMatrix(:,:,x),unitWidth,portLocations);
    figure(2)
    plot(cost(1:x))
    ylabel('Cost');
    xlabel('Simulations');
    drawnow
    
    x=x+1;
end