clear all;
clc;

j=sqrt(-1);

M11=linspace(0,1,100);
P11=linspace(0,pi,100);

[M11,P11]=meshgrid(M11,P11);

for ind=1:size(M11,1)*size(M11,2)
    S(:,:,ind)=[M11(ind) sqrt(1-M11(ind)^2).*exp(j*P11(ind)); sqrt(1-M11(ind)^2).*exp(j*P11(ind)) M11(ind);];
    Sn=S(:,:,ind);
    
%     %     Sh=ctranspose(S(:,:,ind));
%     %    Scost=(Sn*Sh-eye(2));
    
   Scost=Sn-[0 1; 1 0;].*[0 exp(j*pi/2); exp(j*pi/2) 0;];
   magnitized=Scost.*conj(Scost);
   cost(ind)=sum(sum(magnitized));
%     
%      SmagCost=abs([0 1; 1 0;])-abs(Sn);
%     SphaseCost=abs([0 1; 1 0;]).*(abs(angle(Sn)-[0 pi/2; pi/2 0;]));
%     
%     magCost=sum(sum(sum(abs(SmagCost))))/(1) ...
%         /(size([0 1; 1 0;],2)^2);
%     phaseCost=1000*sum(sum(sum(abs(SphaseCost))))/(1) ...
%        /(size([0 pi/2; pi/2 0;],2)^2);
   
%    
%     %magCost(ind)=abs(mean(abs(sum(Scost)))-1/sqrt(2));
%     % cost(ind)=abs(sum(sum(Scost)));
%     %costMag=[0 1 1 0];
%     % phseSn= [0
%     
    
%     cost(ind)=(magCost+phaseCost)/2;
    
    if mod(ind,50)==0
        x=1;
    end
end

cost=reshape(cost,size(M11,1),size(M11,2))
%magCost=reshape(magCost,size(M11,1),size(M11,2));

figure(1)
surf(M11,P11,cost)
xlabel('Magnitude S11 (S21=sqrt(1-S11^2)');
ylabel('Phase Difference Between (S11 and S21)');
title('Surface using sum(sum(abs(A*A^H-I))');

% figure(2)
% surf(M11,P11*180/pi,magCost)
% xlabel('Magnitude S11 (S21=sqrt(1-S11^2)');
% ylabel('Phase Difference Between (S11 and S21)');
% title('Surface magCost');
%
% figure(3)
% surf(M11,P11*180/pi,cost+magCost)
% xlabel('Magnitude S11 (S21=sqrt(1-S11^2)');
% ylabel('Phase Difference Between (S11 and S21)');
% title('Surface using sum(sum(abs(A*A^H-I))+magCost');
