function [ ] = runMOM(folderPath)

system(['cd ' folderPath]);
% system(['MomEngine -T --objMode=MW proj proj']);
% system(['MomEngine -DB --objMode=MW proj proj']);
% system(['MomEngine -M --objMode=MW proj proj']);
system(['MomEngine -O -3D --objMode=MW proj proj']);
end

