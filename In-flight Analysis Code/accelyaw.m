
Ydes_accel=diff(double(RATE.YDes))./diff((10^-6)*double(RATE.TimeUS));%Differentiation of desired RATE
YAct_accel=diff(double(RATE.Y))./diff((10^-6)*double(RATE.TimeUS));%Differentiation of RATE

% to find the windowing size

[ws_act] = windowsize(YAct_accel);
[ws_des] = windowsize(Ydes_accel);

%Moving Average Filter Actual Yaw
windowSize = ws_act; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;
filt_YAct = filter(b,a,double(YAct_accel));
atime = filter(b,a,double(RATE.TimeUS(1:end-1)));%Moving Average Filter Time

%Moving Average Filter Desired Yaw
windowSize = ws_des;
b = (1/windowSize)*ones(1,windowSize);
a = 1;
filt_YDes = filter(b,a,double(Ydes_accel));
dtime = filter(b,a,double(RATE.TimeUS(1:end-1)));%Moving Average Filter Time

figure %plot
plot((10^-6)*double(dtime),filt_YDes,'LineWidth',1)
hold on;plot((10^-6)*double(atime),filt_YAct,'LineWidth',1)
hold on;plot((10^-6)*double(RCIN.TimeUS),double(RCIN.C4-1500),'LineWidth',2)
xlabel('Time(s)','FontSize',22,'FontWeight','bold');
ylabel('Acceleration(deg/s^2)','FontSize',22,'FontWeight','bold');
legend({'Desired Yaw','Yaw','RC Input'},'FontSize',14);
title(sprintf('%s', filename),'FontSize',26,'FontWeight','bold');
fontname(gcf,"aakar")
grid on;


%Maximum Positive Accelerations 
Max_AccelYDes_Right=max(double(filt_YDes))
Max_AccelYAct_Right=max(double(filt_YAct))

%Maximum Negative Accelerations 
Max_AccelYDes_Left=min(double(filt_YDes))
Max_AccelYAct_Left=min(double(filt_YAct))

