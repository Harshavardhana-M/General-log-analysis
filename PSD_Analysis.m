%Make sure to add PSD plot,ISB extract and sigPSD into path before running
%this code
clear all
x="/home/rangeaero/Downloads/tracking check/RA5A1.220825.G2.mat";
clc
clear accel_0 gyro_2 accel_1 gyro_1 gyro_0 accel_2 
load(x)
[accel_0,accel_1,accel_2,gyro_0,gyro_1,gyro_2] = PSDplot(x);

%% PSD
%1st IMU
%Accelerometer
plot(double(accel_0.xfreq),double(accel_0.x_psd_lin),'LineWidth',1.5)%linear PSD
hold on;plot(double(accel_0.xfreq),double(accel_0.y_psd_lin),'LineWidth',1.5)%linear PSD
hold on;plot(double(accel_0.xfreq),double(accel_0.z_psd_lin),'LineWidth',1.5)%linear PSD
xlabel('Frequency(Hz)','FontSize',22,'FontWeight','bold');
ylabel('Amplitude (m/s^2\surdHz)','FontSize',22,'FontWeight','bold');
legend({'X Axis','Y Axis','Z Axis'},'FontSize',14);
title('Pixhawk Accelerometer PSD','FontSize',26,'FontWeight','bold');
figure
%Gyroscope
plot(double(gyro_0.xfreq),double(gyro_0.x_psd_lin),'LineWidth',1.5)
hold on;plot(double(gyro_0.xfreq),double(gyro_0.y_psd_lin),'LineWidth',1.5)
hold on;plot(double(gyro_0.xfreq),double(gyro_0.z_psd_lin),'LineWidth',1.5)
xlabel('Frequency(Hz)','FontSize',22,'FontWeight','bold');
ylabel('Amplitude(m/s^2\surdHz)','FontSize',22,'FontWeight','bold');
legend({'X Axis','Y Axis','Z Axis'},'FontSize',14);
title('PIXHAWK Gyroscope PSD','FontSize',26,'FontWeight','bold');
%% VIBE
plot(double(VIBE.TimeUS(1:3:end))*10^-6,double(VIBE.VibeX(1:3:end)),'LineWidth',1)
hold on;plot(double(VIBE.TimeUS(1:3:end))*10^-6,double(VIBE.VibeY(1:3:end)),'LineWidth',1)
hold on;plot(double(VIBE.TimeUS(1:3:end))*10^-6,double(VIBE.VibeZ(1:3:end)),'LineWidth',1)
hold on;plot(double(RCIN.TimeUS)*10^-6,(double(RCIN.C3)-1000)*0.1,'LineWidth',1)
%xline([166.115 346.69 469.79],'-',{'Tracking.','Off Track','Tracking.'})

xlabel('Time(s)','FontSize',22,'FontWeight','bold');
ylabel('Acceleration(m/s^2)','FontSize',22,'FontWeight','bold');
legend({'X Axis','Y Axis','Z Axis'},'FontSize',14);
title('VIBE','FontSize',26,'FontWeight','bold');
VibrationPeak = [max(double(VIBE.VibeX(1:3:end))) max(double(VIBE.VibeY(1:3:end))) max(double(VIBE.VibeZ(1:3:end)))]
VibrationMean = [mean(double(VIBE.VibeX(1:3:end))) mean(double(VIBE.VibeY(1:3:end))) mean(double(VIBE.VibeZ(1:3:end)))]
VibrationKurtosis = [kurtosis(double(VIBE.VibeX(1:3:end))) kurtosis(double(VIBE.VibeY(1:3:end))) kurtosis(double(VIBE.VibeZ(1:3:end)))]
VibrationRMS = [rms(double(VIBE.VibeX(1:3:end))) rms(double(VIBE.VibeY(1:3:end))) rms(double(VIBE.VibeZ(1:3:end)))]

%%
%2nd instance
plot(double(accel_0.xfreq),double(accel_1.x_psd_lin))%linear PSD
plot(double(accel_0.xfreq),double(accel_1.y_psd_lin))%linear PSD
plot(double(accel_0.xfreq),double(accel_1.z_psd_lin))%linear PSD
%% PSD without ISBH and ISBD
range = 8;%in terms of g(2,4,8,16)
g = 9.81;
fs= mean(double(IMU.AHz(1:3:end)));
[accx_PSD,freq] = sigPSD1(double(IMU.AccX(1:3:end))*g*range,fs);
[accy_PSD,freq] = sigPSD1(double(IMU.AccY(1:3:end))*g*range,fs);
[accz_PSD,freq] = sigPSD1(double(IMU.AccZ(1:3:end))*g*range,fs);


plot(double(freq),double(accx_PSD),'LineWidth',1.5)%linear PSD
hold on;plot(double(freq),double(accy_PSD),'LineWidth',1.5)%linear PSD
hold on;plot(double(freq),double(accz_PSD),'LineWidth',1.5)%linear PSD
xlabel('Frequency(Hz)','FontSize',22,'FontWeight','bold');
ylabel('Amplitude (m/s^2\surdHz)','FontSize',22,'FontWeight','bold');
legend({'X Axis','Y Axis','Z Axis'},'FontSize',14);
title('Pixhawk Accelerometer PSD','FontSize',26,'FontWeight','bold');