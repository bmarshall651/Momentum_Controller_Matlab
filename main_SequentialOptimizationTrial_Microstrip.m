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
stopFreq=6.0;
stepFreq=0.2;
freqRange=startFreq:stepFreq:stopFreq;

startCostFreq=5.8;
stopCostFreq=5.8;

xdimNumofCells=12;
ydimNumofCells=200;


totalCycles=20;


Sideal=repmat([0 1.*exp(-j*0.244); ...
    1.*exp(-j*0.244) 0;],[1 1 floor((stopFreq-startFreq)/stepFreq)+1]);
weighting=[1 1; 1 1;];

unitWidth=0.1; %in mm
portLocations=[ceil(xdimNumofCells/2) ydimNumofCells;  ceil(xdimNumofCells/2) 1;]; %in matrix indicies
for portN=1:size(portLocations,1)
    portMinors(3*(portN-1)+1:3*(portN))=[portLocations(portN,1)+(portLocations(portN,2)-1)*xdimNumofCells-1; ...
        portLocations(portN,1)+(portLocations(portN,2)-1)*xdimNumofCells; ...
        portLocations(portN,1)+(portLocations(portN,2)-1)*xdimNumofCells+1;];
end

timer=tic;
%Begin
disp(['GA for Microstrip using...']);
disp(['totalCycles=', num2str(totalCycles)]);
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
disp('Building substrate and simulation paramteres....');
generateSubstrate_ltdFile(ER, TAND, FREQ, H, COND, [pwd, slash, 'proj.ltd']);
disp('Creating initial metal structure....');
myBestGuess=generateRandomMatrix(xdimNumofCells,ydimNumofCells,portLocations, 1,~YAXISSYM,~XAXISSYM);
drawLens(myBestGuess,unitWidth,portLocations);
buildLensFiles(myBestGuess,unitWidth,portLocations, startFreq, stopFreq, stepFreq, pwd, WorL); %builds netlist files for MOM
runMOM(pwd); %calls MOM to run netlist files
Sparams(:,:,:,1)=interpretCTItoSparam('proj.cti'); %interprets file to Matlab
porMatrix(:,:,1)=myBestGuess;
cost(1)=calculateSparamCost(Sparams, Sideal, freqRange, weighting, USEMAGINCOST, ~USEPHASEINCOST, startCostFreq, stopCostFreq)

estTimePerGen=toc(timer);
disp(['Expected run time: ', num2str(xdimNumofCells*ydimNumofCells*estTimePerGen/60/60), ' hours'])
x=1;
while(x<=totalCycles)
    minor=1;
%     if x ==1
%         load twentyKruns.mat;
%         totalCycles=20;
%     end
%     

    while(minor<=xdimNumofCells*ydimNumofCells)
        curHistInd=(x-1)*xdimNumofCells*ydimNumofCells+minor+1;
        if ~ismember(minor, portMinors)
            myNextGuess=porMatrix(:,:,curHistInd-1);
            myNextGuess(minor)=~myNextGuess(minor);
            drawLens(myNextGuess,unitWidth,portLocations);
            buildLensFiles(myNextGuess,unitWidth,portLocations, startFreq, stopFreq, stepFreq, pwd, WorL); %builds netlist files for MOM
            runMOM(pwd); %calls MOM to run netlist files
            tempSparams=interpretCTItoSparam('proj.cti'); %interprets file to Matlab
            while tempSparams == -1
                runMOM(pwd);
                tempSparams=interpretCTItoSparam('proj.cti'); %interprets file to Matlab
                disp(['!!!!!!!!!!!!!Stuck on Minor:', num2str(minor), '!!!!!!!!!!'])
            end
            tempCost=calculateSparamCost(tempSparams, Sideal, freqRange, weighting, USEMAGINCOST, ~USEPHASEINCOST, startCostFreq, stopCostFreq)
        else
            tempCost=1000000000;
        end
        if tempCost < cost(curHistInd-1) || rand(1)<=0.001
            porMatrix(:,:,curHistInd)=myNextGuess;
            Sparams(:,:,:,curHistInd)=tempSparams;
            cost(curHistInd)=tempCost;
        else
            porMatrix(:,:,curHistInd)= porMatrix(:,:,curHistInd-1);
            Sparams(:,:,:,curHistInd)=Sparams(:,:,:,curHistInd-1);
            cost(curHistInd)=cost(curHistInd-1);
        end
        
        figure(2)
        plot(cost)
        drawnow
        
        minor=minor+1;
    end
    x=x+1;
end



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