function [ S ] = interpretSingleFreqCTI( ctifile )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

fOut = fopen(ctifile, 'r');

x=1;
count=1;
numOfSparams=1;
while(1)
    tline=fgetl(fOut);
    if(findstr('NBR_OF_PORTS',tline)==10)
        numOfPorts=str2double(tline(23));
        numOfSparams=numOfPorts*numOfPorts;
        break;
    end
end

while(count <= numOfSparams)
    tline=fgetl(fOut);
    if(findstr('BEGIN',tline)==1)
        tline2=fgetl(fOut);
        SStr(count,:)=strsplit(tline2,',');
        S(count,1)=str2double(SStr(count,1));
        S(count,2)=str2double(SStr(count,2));
        count=count+1;
    end
end

fclose(fOut);

end

