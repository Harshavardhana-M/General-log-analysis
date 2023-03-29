%% FeedForward Calculation

function [Max_FF] = Feedforward(sgnl_X,sgnl_Xout,sgnl_time,filename)

windowSize=100;
b = (1/windowSize)*ones(1,windowSize);
a = 1;
filt_RATX=filter(b,a,double(sgnl_X));%To filter out excess oscillaiton
filt_RATXout=filter(b,a,double(sgnl_Xout));%To filter out excess oscillation
time=filter(b,a,double(sgnl_time));%To equalize length of each array

std_RATX=stdfilt(filt_RATX);% To get standard deviation of signal fro every two element

l=length(filt_RATX);
FF=zeros(1,l);  %preallocating array with zeros to reducing processing required
r=300;          %range of observation

for j=1:r:l-r %Loop to calculate feedforward

    if std_RATX(j:j+r) < 0.1 & abs(mean(filt_RATX(j:j+r)))> 10
       FF(j)=abs(mean(filt_RATXout(j:j+r)))/abs(mean(filt_RATX(j:j+r)));
    end

end

figure
plot(time*10^-6,FF)% Feedforward requirement throught the flight
xlabel('Time(s)','FontSize',22,'FontWeight','bold');
ylabel('Required Feedforward','FontSize',22,'FontWeight','bold');
title(sprintf('%s', filename),'FontSize',26,'FontWeight','bold');

Max_FF=max(FF);% MaX Feedforward required. This will be set as feedforward.



