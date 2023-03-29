function [C,RMSE,L] = correlation(des_sgnl,act_sgnl,A,t)

% To increase length of RFND.Dist array to match ATT.X using interpolation 
xi = 1:1:length(des_sgnl); 
x = linspace(1,length(des_sgnl),length(A)); 
Altitude=interp1(x,A,xi);


Index=zeros(size(des_sgnl));%Initialization to improve performance
rms=zeros(size(des_sgnl));%Initialization to improve performance
j=1;

 for i=1:1:length(Altitude)
     if (Altitude(i)>0.26 && abs(des_sgnl(i)-act_sgnl(i))<300)
     % When LIDAR Distance is greater than 0.26m it can be considered in flight     
         Index(j)=i;
         rms(j) = double(des_sgnl(i)).^2 - double(act_sgnl(i)).^2;% Squared Errors
        j=j+1;
     end
 end
 
Index=Index(Index>0);
rms=rms(rms>0);
[c,lags]=xcorr(double(des_sgnl(Index)),double(act_sgnl(Index)),'Normalized'); 
RMSE=sqrt(mean(rms)); %Root Mean Squared Error
C=max(c); %Correlation Co-efficient
L=double(lags(c == max(c)))*double(t(end)-t(1))*10^-6/length(t); %Lag at best correlation in seconds

end
