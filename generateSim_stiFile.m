function [ output_args ] = generateSim_stiFile( startFreqGiga, stopFreqGiga, numOfSteps, outputProj_sti )
%generateSubstrate_stiFile creates sti file for momentum simulation in
%Agilent ADS
%Author: Blake Marshall
%June 28, 2014

fOut = fopen(outputProj_sti, 'wt');

%fprintf(fOut, ['START          ',num2str(startFreqGiga),' STOP         ', ...
%    num2str(stopFreqGiga),' STEP         ',num2str(numOfSteps),', \n']);
%fprintf(fOut,'AFS S_50 MAXSAMPLES 50 SAMPLING ALL NORMAL \n');

fprintf(fOut,'PT        5.8, \n');
fprintf(fOut,';');


fclose(fOut);
end


