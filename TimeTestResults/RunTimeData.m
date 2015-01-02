clear all;
load('timeData40to500with02mm2Ports_Oct.mat');
data_02mm_2ports=finalData;
data_02mm_2ports(all(data_02mm_2ports==0,2),:)=[];
load('timeData40to500with1mm2Ports_Sept_2.mat');
data_1mm_2ports=finalData;
load('timeData40to500with5mm2Ports_Sept.mat');
data_5mm_2ports=finalData;

figure(1)
plot((data_02mm_2ports(:,1)*10).*0.2,data_02mm_2ports(:,4)/3600,(data_1mm_2ports(:,1)*10),data_1mm_2ports(:,4)/3600, '-.g' ...
    ,(data_5mm_2ports(:,1)*10).*5,data_5mm_2ports(:,4)/3600,'--r');
title('Two Port Agilent ADS Method of Moments Run Time for a Single Structure');
xlabel('Width of Square Structure (mm)');
ylabel('Run Time (hours)');
legend('0.2 mm Unit Squares','1 mm Unit Squares','5 mm Unit Squares');
axis([0 800 0 6]);


load('timeData40to500with02mm4Ports_Oct.mat');
data_02mm_4ports=finalData;
load('timeData40to500with1mm4Ports_Sept_2.mat');
data_1mm_4ports=finalData;
load('timeData40to500with5mm4Ports_Oct.mat');
data_5mm_4ports=finalData;


figure(2)
plot(data_02mm_4ports(:,1).*10.*0.2,data_02mm_4ports(:,4)./3600,data_1mm_4ports(:,1).*10,data_1mm_4ports(:,4)./3600, '-.g' ...
    ,data_5mm_4ports(:,1).*10.*5,data_5mm_4ports(:,4)./3600,'--r');
title('Four Port Agilent ADS Method of Moments Run Time for a Single Structure');
xlabel('Width of Square Structure (mm)');
ylabel('Run Time (hours)');
legend('0.2 mm Unit Squares','1 mm Unit Squares','5 mm Unit Squares');
axis([0 800 0 3.5]);



%16 threads
%Method of Moments

