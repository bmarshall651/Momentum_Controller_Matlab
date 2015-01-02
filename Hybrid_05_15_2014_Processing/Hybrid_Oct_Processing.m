clear all;
load('Hybrid_2x2_Oct_Final.mat');

figure(1)
drawLens(bestOfAllLens(:,:,1),unitWidth, portLocations);

figure(2)
plot(costs(:,1),costs(:,2));

figure(3)
plot(freqRange,squeeze(20*log10(abs(Sparams(1,1,:,1)))), ...
     freqRange,squeeze(20.*log10(abs(Sparams(1,2,:,1)))), ...
     freqRange,squeeze(20.*log10(abs(Sparams(1,3,:,1)))), ...
     freqRange,squeeze(20.*log10(abs(Sparams(1,4,:,1)))));
legend('S11','S21', 'S31', 'S41');

figure(4)
plot(freqRange, (180/pi)*squeeze(angle(Sparams(1,1,:,1))), ...
     freqRange, (180/pi)*squeeze(angle(Sparams(1,2,:,1))),  ...
     freqRange, (180/pi)*squeeze(angle(Sparams(1,3,:,1))),  ...
     freqRange, (180/pi)*squeeze(angle(Sparams(1,2,:,1))));
legend('S11','S21', 'S31', 'S41');

