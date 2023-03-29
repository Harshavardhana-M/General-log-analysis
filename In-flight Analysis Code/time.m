%% Calculate input TC
function [ATC_Input_TC]= time(act_sgnl,des_sgnl,filename)


act_diff=diff(double(act_sgnl));
des_diff=diff(double(des_sgnl)); %calculating differences betweem two attitude points

index=find(abs(des_diff)>0 & abs(des_diff)<10 & abs(act_diff)>0 & abs(act_diff)<10);%condition to extrqact region of interest
ROI=act_diff(index); %region of intrest


x=zeros(1,length(index));%initialization to improve efficiency
r=zeros(1,length(index));
i=2;

j=1;

while i<=length(index) && i+j<length(index) %nested loop to calculate ranges 
    while x(i)<10 && i+j<length(index)     
     x(i)=sum(ROI(i:j+i));
     j=j+1;              
    end

 r(i)=j-1;%range
 i=i+j-1;
 j=1;
end

ATC_Input_TC=(0.005661191/3)*r(r>0 & r<110); %time delay in seconds divided by 3 to get time constant
%plot(x(x>0))

figure
plot(ATC_Input_TC) %plot
xlabel('Instances','FontSize',22,'FontWeight','bold');
ylabel('Time Contants(s)','FontSize',22,'FontWeight','bold');
title(sprintf('%s',filename),'FontSize',26,'FontWeight','bold')
fontname(gcf,"aakar")
grid on;

end