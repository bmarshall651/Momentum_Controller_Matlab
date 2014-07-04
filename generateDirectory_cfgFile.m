function [ ] = generateDirectory_cfgFile(outputProj_cfg )
%generateSubstrate_cfgFile creates cfg file for momentum simulation in
%Agilent ADS
%Author: Blake Marshall
%June 28, 2014

fOut = fopen(outputProj_cfg, 'wt');

fprintf(fOut, 'user     = .\\ \n');
fprintf(fOut,'site     = {$HOME} \n');
fprintf(fOut,'supplied     = {$HPEESOF_DIR}\\momentum\\lib \n');

fclose(fOut);

end

