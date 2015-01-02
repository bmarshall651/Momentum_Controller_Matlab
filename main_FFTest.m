clear all;
clc;

ER=3.66; %relative permittviity
TAND=0.0127; %tangent delta losses
FREQ=5.8E9; %frequency of er and tand measurements
%H=0.00017018; %6.7 mil %height of substrate in meters
H=0.0015748; %62 mil
COND=5.7E7; %conductivity of metal in S/m

WorL = 1;
if WorL==1
    slash='\';
else
    slash='/';
end

unit=0.2; %in mm
portLocations=[200 100;]; %in matrix indicies
lensMatrix1 = generateRandomMatrix(200,200, portLocations, 0.75, 0, 0);
lensMatrix1 = zeros(200,200);
lensMatrix1(96:200,91:110)=ones(105,20);
lensMatrix1(27:96,56:145)=ones(70,90);
lensMatrix1(96:100,116:145)=ones(5,30);
lensMatrix1(96:100,56:85)=ones(5,30);
% lensMatrix1(100:200,100)=ones(101,1);
% lensMatrix1(70:130,56:144)=ones(61,89);
figure(1)
drawLens(lensMatrix1,unit,portLocations);
axis equal;

generateSubstrate_ltdFile(ER, TAND, FREQ, H, COND, [pwd, slash, 'proj.ltd']);
buildLensFiles(lensMatrix1, unit, portLocations,5,7,0.1, pwd, WorL);
generateFarFieldParams_vplFile(5.8, portLocations, 1, 50, [pwd, slash, 'proj.vpl']);

runMOM(pwd);
S=interpretSingleFreqCTI('proj.cti');

generateFarFieldParams_vplFile(5.8, portLocations, 1, 50, [pwd, slash, 'proj.vpl']);
runFarField(pwd);
[ Gain, Efield_theta, Efield_phi, EthetaMax, EphiMax, THETA, PHI]=interpretFFFtoFarField('proj.fff','proj.ant',1,50);
figure(2)
plot3DPattern(abs(Gain),THETA,PHI);
figure(3)
plot(linspace(5,7,21),reshape(20*log10(abs(S(1,1,:))),1,21))
figure(4)
plot3DPattern(sqrt(Efield_theta.*conj(Efield_theta)),THETA,PHI);
figure(5)
plot3DPattern(sqrt(Efield_phi.*conj(Efield_phi)),THETA,PHI);

% generateFarFieldParams_vplFile(5.8, portLocations, 2, 50, [pwd, '\', 'proj.vpl']);
% runFarField(pwd);
% [ Efield_theta2, Efield_phi2, EthetaMax2, EphiMax2, THETA2, PHI2]=interpretFFFtoFarField('proj.fff','proj.ant');
% figure(3)
% plot3DPattern(sqrt(abs(Efield_phi2).^2+abs(Efield_theta2).^2),THETA2,PHI2)