function [ output_args ] = buildLensFiles( matrix, unitWidth, ports, startFreq, stopFreq, stepFreq, folderName, WorL)

disp('Building all files required for simulation...')
if(WorL==1)%Windows - DOS
    slash='\';
elseif(WorL==0)%Mac/Linux - UNIX
    slash='/';
else
    disp('Choose either Windows or Linux');
    return;
end

generateGeom_Proj_aFile(matrix, unitWidth, [folderName, slash, 'proj_a']);
generatePorts_prtFile(ports,[folderName, slash, 'proj.prt']);
generatePorts_pinFile(matrix,ports,unitWidth,[folderName, slash, 'proj.pin']);
generateProperties_optFile('dsFolder','dsName', [folderName, slash, 'proj.opt'],WorL);
generateSim_stiFile(startFreq,stopFreq,stepFreq, [folderName, slash, 'proj.sti']);
generateDirectory_cfgFile([folderName, slash, 'proj.cfg'],WorL);

disp('All files complete... Ready for Simulation!')
end

