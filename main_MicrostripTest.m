clear all;
clc;

ER=3.66; %relative permittviity
TAND=0.0127; %tangent delta losses
FREQ=5.8E9; %frequency of er and tand measurements
H=0.00017018; %6.7 mil %height of substrate in meters
%H=0.0015748; %62 mil
COND=5.7E7; %conductivity of metal in S/m

unit=0.40; %in mm
portLocations=[200 100; 1 100;]; %in matrix indicies
lensMatrix1 = generateRandomMatrix(200,200, portLocations, 0, 0);
lensMatrix1 = zeros(200,200);
lensMatrix1(:,100)=ones(200,1);
% lensMatrix1(100:200,100)=ones(101,1);
% lensMatrix1(70:130,56:144)=ones(61,89);
figure(1)
drawLens(lensMatrix1,unit,portLocations);

generateSubstrate_ltdFile(ER, TAND, FREQ, H, COND, [pwd, '\', 'proj.ltd']);
buildLensFiles_W(lensMatrix1, unit, portLocations,5,7,0.1, pwd);
generateFarFieldParams_vplFile(5.8, portLocations, 1, 50, [pwd, '\', 'proj.vpl']);

figure(1)
drawLens(lensMatrix1,unit, portLocations);
runMOM(pwd);
S=interpretSingleFreqCTI('proj.cti');
% generateFarFieldParams_vplFile(5.8, portLocations, 1, 50, [pwd, '\', 'proj.vpl']);
% runFarField(pwd);
% [ Efield_theta, Efield_phi, EthetaMax, EphiMax, THETA, PHI]=interpretFFFtoFarField('proj.fff','proj.ant');
% figure(2)
% plot3DPattern(sqrt(abs(Efield_phi).^2+abs(Efield_theta).^2),THETA,PHI)


 figure(2)
 plot(linspace(5,7,21),reshape(20*log10(abs(S(1,1,:))),1,21))
 hold on;
 plot(linspace(5,7,21),reshape(20*log10(abs(S(2,1,:))),1,21),'r-')
 hold off;
 legend('S11', 'S21');
 xlabel('Frequency (GHz)');
 ylabel('dB');
title('S-parameters of Microstrip using Matlab-ADS Co-simulation');
% generateFarFieldParams_vplFile(5.8, portLocations, 2, 50, [pwd, '\', 'proj.vpl']);
% runFarField(pwd);
% [ Efield_theta2, Efield_phi2, EthetaMax2, EphiMax2, THETA2, PHI2]=interpretFFFtoFarField('proj.fff','proj.ant');
% figure(3)
% plot3DPattern(sqrt(abs(Efield_phi2).^2+abs(Efield_theta2).^2),THETA2,PHI2)