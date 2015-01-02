clear all;
clc;
%Constants
ER=3.66; %relative permittviity
TAND=0.0127; %tangent delta losses
FREQ=5.8E9; %frequency of er and tand measurements
H=0.00017018; %6.7 mil %height of substrate in meters
%H=0.0015748; %62 mil
COND=5.7E7; %conductivity of metal in S/m

YAXISSYM=1;
XAXISSYM=1;
USEMAGINCOST=1;
USEPHASEINCOST=1;
DOS=1;
j=sqrt(-1);

%Parameters
WorL=DOS;

startFreq=5.6;
stopFreq=6;
stepFreq=0.3;
freqRange=startFreq:stepFreq:stopFreq;

startCostFreq=5.7;
stopCostFreq=5.9;

xdimNumofCells=80;
ydimNumofCells=80;

killPercent=0.75;
mutationPercent=0.025;
populationSize=75;
totalGenerations=1000;
percentMetal=0.75;

Sideal=repmat((-1/sqrt(2))*[0 j 1 0; ...
               j 0 0 1; ...
               1 0 0 j; ...
               0 1 j 0;],[1 1 floor((stopFreq-startFreq)/stepFreq)+1]);
weighting=[1 1 1 1; 1 1 1 1; 1 1 1 1; 1 1 1 1;];

unitWidth=0.2; %in mm
portLocations=[ceil(xdimNumofCells/4) 1; ...
               ceil(xdimNumofCells/4) ydimNumofCells; ...
               ceil(3*xdimNumofCells/4) ydimNumofCells; ...
               ceil(3*xdimNumofCells/4) 1; ...
               ]; %in matrix indicies

%Begin
disp(['GA for Microstrip using...']);
disp(['popSize=',num2str(populationSize)]);
disp(['totGens=', num2str(totalGenerations)]);
disp(['mutationRate=', num2str(mutationPercent)]);
disp(['killRate=', num2str(killPercent)]);
disp('Ideal S-parameter Matrix:');
disp(Sideal(:,:,1));
disp('Weighting Matrix:');
disp(weighting(:,:,1));
disp('=======================================');

if(WorL==1)
    slash='\';
else
    slash='/';
end
timer=tic;
disp('=======================================');
disp('First Generation Begins!');
disp('=======================================');
generateSubstrate_ltdFile(ER, TAND, FREQ, H, COND, [pwd, slash, 'proj.ltd']);

nextGen=buildPopulation(populationSize,xdimNumofCells,ydimNumofCells, portLocations,percentMetal,~YAXISSYM,~XAXISSYM);
drawLens(nextGen(:,:,1),unitWidth,portLocations);
Sparams=simulatePopulation(nextGen, portLocations,unitWidth, startFreq, stopFreq, stepFreq, pwd, WorL);
disp('=======================================');
disp('First Generation Simulation Complete');
disp('=======================================');
estTimePerGen=toc(timer);

x=1;
while(x<=totalGenerations)
    %try
    disp('=======================================');
    disp(['Generation ', num2str(x), ' Begins']);
    disp('Time Per Generation of Simulation:');
    disp(estTimePerGen)
    disp('=======================================');
    [nextGen,prevCosts]=buildNewGeneration(nextGen,Sparams,Sideal,freqRange, weighting,killPercent,mutationPercent, portLocations,~YAXISSYM,~XAXISSYM,USEMAGINCOST,USEPHASEINCOST, startCostFreq, stopCostFreq);
    Sparams=simulatePopulation(nextGen, portLocations,unitWidth, startFreq, stopFreq, stepFreq, pwd, WorL);
    finalCosts=calculateCostOfPop(Sparams, Sideal, freqRange, weighting, USEMAGINCOST, USEPHASEINCOST,  startCostFreq, stopCostFreq)
    recordOfBestCosts(x,1)=x;
    [recordOfBestCosts(x,2),temp]=min(finalCosts);
    recordOfBestLensGeom(:,:,x)=nextGen(:,:,temp(1));
    
     disp('=======================================');
    disp(['Generation ', num2str(x), 'Complete']);
    disp('=======================================');
   
    
    figure(1)
    plot(recordOfBestCosts(:,1),recordOfBestCosts(:,2));
    xlabel('Generations');
    ylabel('Cost');
    
    figure(2)
    drawLens(recordOfBestLensGeom(:,:,x),unitWidth,portLocations);
%     catch err
%         disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
%         disp('Errored during GA');
%         disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
%         break;
%     end

 x=x+1;
end

%%Find best member
finalCosts=calculateCostOfPop(Sparams, Sideal, freqRange, weighting, USEMAGINCOST, USEPHASEINCOST,  startCostFreq, stopCostFreq)
[bestCost,bestInd]=min(finalCosts);
bestSparams=Sparams(:,:,:,bestInd);
bestLens=nextGen(:,:,bestInd);

figure(1)
plot(recordOfBestLensGeom(:,1),recordOfBestLensGeom(:,2));
xlabel('Generations');
ylabel('Cost');

figure(2)
drawLens(bestLens,unitWidth,portLocations);

% figure(3)
% plot(freqRange,squeeze(abs(bestSparams(1,1,:))),freqRange, squeeze(abs(Sparams(2,1,:))));
%buildLensFiles(lensMatrix1, unit, portLocations,5,7,0.1, pwd);
%generateFarFieldParams_vplFile(5.8, portLocations, 1, 50, [pwd, '\', 'proj.vpl']);

% figure(1)
% drawLens(lensMatrix1,unit, portLocations);
%runMOM(pwd);
%S=interpretSingleFreqCTI('proj.cti');
% generateFarFieldParams_vplFile(5.8, portLocations, 1, 50, [pwd, '\', 'proj.vpl']);
% runFarField(pwd);
% [ Efield_theta, Efield_phi, EthetaMax, EphiMax, THETA, PHI]=interpretFFFtoFarField('proj.fff','proj.ant');
% figure(2)
% plot3DPattern(sqrt(abs(Efield_phi).^2+abs(Efield_theta).^2),THETA,PHI)


%  figure(2)
%  plot(linspace(5,7,21),reshape(20*log10(abs(S(1,1,:))),1,21))
%  hold on;
%  plot(linspace(5,7,21),reshape(20*log10(abs(S(2,1,:))),1,21),'r-')
%  hold off;
%  legend('S11', 'S21');
%  xlabel('Frequency (GHz)');
%  ylabel('dB');
% title('S-parameters of Microstrip using Matlab-ADS Co-simulation');
% generateFarFieldParams_vplFile(5.8, portLocations, 2, 50, [pwd, '\', 'proj.vpl']);
% runFarField(pwd);
% [ Efield_theta2, Efield_phi2, EthetaMax2, EphiMax2, THETA2, PHI2]=interpretFFFtoFarField('proj.fff','proj.ant');
% figure(3)
% plot3DPattern(sqrt(abs(Efield_phi2).^2+abs(Efield_theta2).^2),THETA2,PHI2)