function [] = spewTitleStuff(sys, totalCycles, Sideal, weighting )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
disp('=================================================');
disp('  Geometric Lens Analyzer for Microwaves (GLAM)  ');
disp('          Written by: Blake Marshall             ');
disp('       The Propagation Group at Georgia Tech     ');
disp('                  2016                           ');
disp('=================================================');
disp(' ');
disp(' ');
disp(['Search Mode: Non-Homogenous Sequential']);
disp(['Computer System: ', sys])
disp(' ');
disp(['Total Number of Full Cycles = ', num2str(totalCycles)]);
disp(' ');
disp('The goal S-parameter Matrix in Linear Complex:');
disp(Sideal(:,:,1));
disp(' ');
disp('Weighting Matrix for the Cost Analysis:');
disp(weighting(:,:,1));
disp(' ');
disp(' ');
disp('===============================================');
disp('===============================================');

end

