tic
clc
clear all
%open the folder containing the logs
cd '/home/rangeaero/Downloads/July 02 & 03-Flights/Bravo/Jul 03/Flight Test 3/PIXHAWK Log'
filename='RA5-A2.030722.F3.mat';
load(filename)

cd '/home/rangeaero/Desktop/MATLAB/bin'%open the folder containing all the scripts and functions
toc

 %% To display Messages
 %disp(MSG.Message)
 clc
n=length(MSG.TimeUS);
 for(i=1:1:n)
strcat(int2str(double(MSG.TimeUS(i)*10^-6)),(MSG.Message))
 end
%% Attitude PLot
figure
run("attyaw.m")
run("attpitch.m")
run("attroll.m")
%% % Rate Plot
figure
run("rateyaw.m")
run("ratepitch.m")
run("rateroll.m")
%% Acceleration Plot
run("accelyaw.m")
run("accelpitch.m")
run("accelroll.m")
%% % EKF Variance and Vibration compensation
%Compass Interference
Mt = sqrt(double(XKF2.MX).^2 + double(XKF2.MY).^2 + double(XKF2.MZ).^2);
%GPS compass
plot((10^-6)*double(CTUN.TimeUS),double(CTUN.ThI)*1000)
hold on;plot((10^-6)*double(XKF2.TimeUS(1:2:end)),Mt(2:2:end),'LineWidth',2)
%PIXHAWK internal Compass
hold on;plot((10^-6)*double(XKF2.TimeUS(2:2:end)),Mt(1:2:end),'LineWidth',2)
xlabel('Time(s)');
ylabel('Parameters');
legend('Throttle Input','Magnetic Field Strength(GPS Compass)','Pixhawk Internal Compass')
title('Magnetic Field Strength')

figure
%GPS Glitches
plot((10^-6)*double(GPS.TimeUS),GPS.NSats,'LineWidth',2)
hold on;plot((10^-6)*double(GPS.TimeUS),GPS.HDop,'LineWidth',2)
xlabel('Time(s)');
ylabel('Parameters');
legend('Sattelite Count','Horizontal Dilution of Precision')
title('GPS Health')

figure
%% Vibration CLipping

plot((10^-6)*double(VIBE.TimeUS(1:3:end)),smooth(double(VIBE.Clip(1:3:end))),'LineWidth',1.5)
hold on;plot((10^-6)*double(VIBE.TimeUS(2:3:end)),smooth(double(VIBE.Clip(2:3:end))),'LineWidth',1.5)
hold on;plot((10^-6)*double(VIBE.TimeUS(3:3:end)),smooth(double(VIBE.Clip(3:3:end))),'LineWidth',1.5)

xlabel('Time(s)','FontSize',22,'FontWeight','bold');
ylabel('Clip Count','FontSize',22,'FontWeight','bold');
legend({'Lane 1','Lane 2','Lane 3'},'FontSize',14);
title('Vibration Clipping','FontSize',26,'FontWeight','bold')
fontname(gcf,"aakar")

%% Vibration Compensation
%Lane1
plot((10^-6)*double(XKF3.TimeUS(1:2:end)),smooth(double(XKF3.IPD(1:2:end))),'LineWidth',1.5)
hold on;plot((10^-6)*double(XKF3.TimeUS(1:2:end)),smooth(double(XKF3.IVD(1:2:end))),'LineWidth',1.5)
hold on;plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SV(1:2:end))),'LineWidth',1.5)
yline(0.0,'-','Zero')
yline(1.0,'-','Failure')
xlabel('Time(s)','FontSize',22,'FontWeight','bold');
ylabel('Innovations','FontSize',22,'FontWeight','bold');
legend({'Position Innovation','Velocity Innovation','Velocity Variance'},'FontSize',14);
title('Vibration Compensation (Lane 1)','FontSize',26,'FontWeight','bold')
fontname(gcf,"aakar")

figure
%lane 2
plot((10^-6)*double(XKF3.TimeUS(2:2:end)),smooth(double(XKF3.IPD(2:2:end))),'LineWidth',1.5)
hold on;plot((10^-6)*double(XKF3.TimeUS(2:2:end)),smooth(double(XKF3.IVD(2:2:end))),'LineWidth',1.5)
hold on;plot((10^-6)*double(XKF4.TimeUS(2:2:end)),smooth(double(XKF4.SV(2:2:end))),'LineWidth',1.5)
yline(0.0,'-','Zero')
yline(1.0,'-','Failure')
xlabel('Time(s)','FontSize',22,'FontWeight','bold');
ylabel('Innovations','FontSize',22,'FontWeight','bold');
legend({'Position Innovation','Velocity Innovation','Velocity Variance'},'FontSize',14);
title('Vibration Compensation (Lane 2)','FontSize',26,'FontWeight','bold')
fontname(gcf,"aakar")

%%  Notch FIlter
f=1-0.038;
notchSpecs = fdesign.notch(3,f,2,f/2,40);
notchFilt = design(notchSpecs,'SystemObject',true)
fvtool(notchFilt)
%% I term
plot(double(PIDY.TimeUS)*10^-6,double(PIDY.I))
yline(0)
mean(PIDY.I)
%% To check oscillations while descending
plot((10^-6)*double(RFND.TimeUS),double(RFND.Dist)*60)
hold on;plot((10^-6)*double(ATT.TimeUS),double(ATT.DesYaw),'LineWidth',2)
hold on;plot((10^-6)*double(ATT.TimeUS),double(ATT.Yaw),'LineWidth',2)
hold on;plot((10^-6)*double(RCIN.TimeUS),double(RCIN.C4-1140),'LineWidth',2)
xlabel('Time(s)');
ylabel('Parameters');
legend('Altitide(m)*60','Desired Yaw','Actual Yaw','RC Yaw Input')
yline(0)
title('Right Yaw while descending')

%%  Pitch Attitude
plot((10^-6)*double(ATT.TimeUS),double(ATT.DesPitch),'LineWidth',2)
hold on;plot((10^-6)*double(ATT.TimeUS),double((ATT.Pitch)),'LineWidth',2)
hold on;plot((10^-6)*double(RCIN.TimeUS),double(RCIN.C2-1500)/10,'LineWidth',2)
xlabel('Time(s)');
ylabel('Attitude (deg)');
legend('Desired Pitch','Pitch','(RCIN Pitch-1500)/10');
title('RA5A2.020722.F4');
%% Normalized Innovations
%lane1
plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SV(1:2:end))),'LineWidth',2)
hold on;plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SH(1:2:end))),'LineWidth',2)
hold on;plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SP(1:2:end))),'LineWidth',2)
hold on;plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SM(1:2:end))),'LineWidth',2)
hold on;plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SVT(1:2:end))),'LineWidth',2)
hold on;plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.PI(1:2:end))),'LineWidth',2)
yline(0.5,'-','Caution')
yline(1.0,'-','Failure')
xlabel('Time(s)');
ylabel('Normalized Innovations');
legend('GPS Velocity','Barometric Height','GPS Position','Magnetometer','Air Speed','Primare Core Index');
title('Lane 1:RA5A1.030722.F5');
figure
plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SV(2:2:end))),'LineWidth',2)
hold on;plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SH(2:2:end))),'LineWidth',2)
hold on;plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SP(2:2:end))),'LineWidth',2)
hold on;plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SM(2:2:end))),'LineWidth',2)
hold on;plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SVT(2:2:end))),'LineWidth',2)
hold on;plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.PI(2:2:end))),'LineWidth',2)
yline(0.5,'-','Caution')
yline(1.0,'-','Failure')
xlabel('Time(s)');
ylabel('Normalized Innovations');
legend('GPS Velocity','Barometric Height','GPS Position','Magnetometer','Air Speed','Primare Core Index');
title('Lane 2:RA5A1.030722.F5');
%% Magnetic Innovation 

MIT = sqrt(double(XKF3.IMX).^2 + double(XKF3.IMY).^2 + double(XKF3.IMZ).^2);
%PIXHAWK internal Compass
plot((10^-6)*double(XKF3.TimeUS(1:2:end)),MIT(1:2:end),'LineWidth',2)
%GPS compass
hold on;plot((10^-6)*double(XKF3.TimeUS(2:2:end)),MIT(2:2:end),'LineWidth',2)
xlabel('Time(s)');
ylabel('Magnetic Field Strength Innovation');
legend('Pixhawk Internal Magnetometer Innovations','GPS Magnetometer Innovations')
title('Magnetic Field Strength')
figure
plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SM(1:2:end))),'LineWidth',2)
hold on;plot((10^-6)*double(XKF4.TimeUS(1:2:end)),smooth(double(XKF4.SM(2:2:end))),'LineWidth',2)
xlabel('Time(s)');
ylabel('Magnetic Field Normalised Innovation');
legend('Pixhawk Internal Magnetometer Innovations','GPS Magnetometer Innovations')
title('RA5A2.020722.F5')
yline(0.5)
yline(1)
%%
plot((10^-6)*double(XKF3.TimeUS),double(XKF3.IMX))
hold on;plot((10^-6)*double(XKF3.TimeUS),double(XKF3.IMY))
hold on;plot((10^-6)*double(XKF3.TimeUS),double(XKF3.IMZ))
xlabel('Time(s)');
ylabel('Innovations');

plot((10^-6)*double(XKF3.TimeUS),double(XKF3.IVD))
hold on;plot((10^-6)*double(XKF4.TimeUS),double(XKF4.SV))
Mt = sqrt(double(XKF2.MX).^2 + double(XKF2.MY).^2 + double(XKF2.MZ).^2);
%GPS compass
hold on;plot((10^-6)*double(XKF2.TimeUS(1:2:end)),Mt(1:2:end),'LineWidth',2)
%PIXHAWK internal Compass
hold on;plot((10^-6)*double(XKF2.TimeUS(2:2:end)),Mt(2:2:end),'LineWidth',2)
yline(0)

plot((10^-6)*double(GPS.TimeUS),double(GPS.VZ))
%hold on;plot((10^-6)*double(RFND.TimeUS),-1*gradient(double(RFND.Dist)))
hold on;plot((10^-6)*double(CTUN.TimeUS),(double(CTUN.CRt)))

hold on;plot((10^-6)*double(XKF4.TimeUS),double(XKF4.SV))

%% FeedForward Calculation
Max_FeedForward = Feedforward(RATE.Y,RATE.YOut,RATE.TimeUS,filename)

%% Comparing two signals
[C,RMSE,L] = correlation(des_sgnl,act_sgnl);