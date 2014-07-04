function [ output_args ] = buildLensFiles( matrix, unitWidth, ports, folderName)

ER=3.66; %relative permittviity
TAND=0.0127; %tangent delta losses
FREQ=5.8E9; %frequency of er and tand measurements
H=0.00017018; %height of substrate in meters
COND=5.7E7; %conductivity of metal in S/m

generateGeom_Proj_aFile(matrix, unitWidth, [folderName, '\', 'proj_a']);
generateSubstrate_ltdFile(ER, TAND, FREQ, H, COND, [folderName, '\', 'proj.ltd']);
generatePorts_prtFile(ports,[folderName, '\', 'proj.prt']);
generatePorts_pinFile(matrix,ports,unitWidth,[folderName, '\', 'proj.pin']);
generateProperties_optFile('dsFolder','dsName', [folderName, '\', 'proj.opt']);
generateSim_stiFile(5,6,6, [folderName, '\', 'proj.sti']);
generateDirectory_cfgFile([folderName, '\', 'proj.cfg']);

end

